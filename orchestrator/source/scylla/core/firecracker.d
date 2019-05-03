module scylla.core.firecracker;
import std.stdio;
import firecracker_d.models.client_models;
import firecracker_d.core.client;
import bap.models.vps;
import std.file;
import std.process;
import core.sys.posix.signal;

struct IPInfo {
        string macAddress;
        string mainIP;
        string gatewayIP;
};

class FirecrackerVM {
        private {
            VPS __template;
            string __id;
            string __socket;

            bool __init = false;
            string __logPath;
            string __metricsPath;
            FirecrackerAPIClient __client;
            ProcessPipes __vmPipes;
            IPInfo __allocatedIP;

            bool pushLogger() {
                if(__init) {
                    return false;
                }

                if(!socketExists()) {
                    return false;
                }

                Logger vmLogger;
                vmLogger.logFifo = __logPath;
                vmLogger.metricsFifo = __metricsPath;
                vmLogger.showLevel = true;
                vmLogger.showLogOrigin = false;
                vmLogger.options = ["LogDirtyPages"];
                vmLogger.level = LoggerLevel.Info;

                try {
                    vmLogger.put(__client);
                }
                catch(FirecrackerException e) {
                    writeln("error: " ~ e.error.faultMessage);
                    return false;
                }

                __init = true;

                return __init;
            }
        }

        @property IPInfo allocatedIP() {
            return __allocatedIP;
        }

        @property void allocatedIP(IPInfo __new) {
            __allocatedIP = __new;
        }

        @property JSONValue mmds() {
            return __client.MMDS.content;
        }

        @property void mmds(JSONValue newContent) {
            MMDS a = __client.MMDS;
            a.content = newContent;
            a.put(__client);
        }

        @property string logPath() {
            return __logPath;
        }

        @property string metricsPath() {
            return __metricsPath;
        }

        @property string socketPath() {
            return __socket;
        }

        bool socketExists() {
            return exists(__socket);
        }

        bool pushBootSource(BootSource b) {
            b.put(__client);
            return true;
        }

        bool pushNIC(NetworkInterface n) {
            n.put(__client);
            return true;
        }

        bool pushDrive(Drive d) {
            d.put(__client);
            return true;
        }

        bool isAlive() {
            if(!socketExists()) {
                return false;
            }

            import core.exception;

            try {
                InstanceInfo.InstanceState state = __client.InstanceInfo.state; 
            }
            catch(Exception e){
                return false;
            }
            catch(AssertError e) {
                return false;
            }
            catch(InvalidMemoryOperationError e) {
                return false;
            }

            return true;
        }

        bool isRunning() {
            if(!isAlive()) {
                return false;
            }

            if(__client.InstanceInfo.state == InstanceInfo.InstanceState.Running) {
                return true;
            }
            else {
                return false;
            }
        }

        string[] getLogs() {
            string[] ret;
            string line;
            return ret;
        }

        bool start() {
            InstanceActionInfo act;
            act.actionType = InstanceActionInfoType.InstanceStart;
            act.put(__client);
            return true;
        }

        bool shutdown() {
            InstanceActionInfo act;
            act.actionType = InstanceActionInfoType.SendCtrlAltDel;
            act.put(__client);
            return true;
        }

        bool stop() {
            int pid = __vmPipes.pid.processID;
            kill(pid, SIGKILL);
            wait(__vmPipes.pid);
            return true;
        }

        bool reboot() {
            import vibe.vibe;
            shutdown();
            sleep(1.seconds);
            recreate();
            start();

            return true;
        }
            
        void cleanup() {
            if(exists(__socket)) {
                remove(__socket);
            }

            if(exists(__logPath)) {
                remove(__logPath);
            }

            if(exists(__metricsPath)) {
                remove(__metricsPath);
            }
        }

        bool startFirecracker() {
            // Now launch it..
            cleanup();
            std.file.write(__logPath, "");
            std.file.write(__metricsPath, "");

            import std.json;
            JSONValue ctx = ["id": __id];
            ctx.object["jailed"] = JSONValue(false);
            ctx.object["seccomp_level"] = JSONValue(0);
            ctx.object["start_time_us"] = JSONValue(0);
            ctx.object["start_time_cpu_us"] = JSONValue(0);

            try {
                __vmPipes = pipeProcess(["firecracker", "--api-sock", __socket, "--context", ctx.toString]);
            }
            catch(ProcessException) {
                writefln("%s had an issue..", __id); 
                return false;
            } catch(Exception e) {
                writefln("starting firecracker exception: %s", e.msg);
                return false;
            }

            writeln("firecracker is up!");

            while(!socketExists()) {
                auto k = tryWait(__vmPipes.pid);
                if(k.terminated) {
                    writeln("firecracker unexpectedly terminated");
                    return false;
                }

                import vibe.vibe;
                sleep(1.msecs);
            }
            writeln("pushing client");
            __client = new FirecrackerAPIClient(__socket);
            writeln("pushing logger");
            pushLogger();
            return true;
        }

        void recreate() {
            if(__init) {
                __init = false;
                startFirecracker();
                __template.boot.put(__client);
                foreach(drive; __template.drives) {
                    drive.put(__client);
                }
                foreach(nic; __template.nics) {
                    nic.put(__client);
                }
            }
        }

        void createFromVPS(VPS model) {
            __template = model;
            model.boot.put(__client);
            foreach(drive; model.drives) {
                drive.put(__client);
            }

            foreach(nic; model.nics) {
                nic.put(__client);
            }
        }


        this(string id) {
            __id = id.idup;
            writefln("id: %s", __id);
            __socket = "/tmp/fc-" ~ __id ~ "-socket";
            __logPath = "/tmp/fc-" ~ __id ~ "-log";
            __metricsPath = "/tmp/fc-" ~ __id ~ "-metrics";
            std.file.write(__logPath, "");
            std.file.write(__metricsPath, "");
            writefln("socket: %s", __socket);

            try {
                if(startFirecracker()) {
                    writeln("firecracker is up");
                }
                else {
                    writeln("error: fc is down");
                }
            } catch(Exception e) {
                writeln("could not spool firecracker..");
                writeln("exception msg: ", e.msg);
            }

        }

        ~this() {
            kill(__vmPipes.pid.processID, SIGKILL);
        }


}
