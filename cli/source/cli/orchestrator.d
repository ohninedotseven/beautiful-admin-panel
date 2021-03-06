module cli.orchestrator;
import structs;
import std.stdio : writeln;
import zmqd;
import dproto.dproto;
import bap.core.resource_manager;

mixin ProtocolBufferFromString!"
	enum KintsugiWorkerActions {
			INSTANCEACTION = 0;
			NICACTION = 1;
			DRIVEACTION = 2;
			NODEACTION = 3;
			ZONEACTION = 4;
			CONNECTACTION = 5;
			HELLOACTION = 6;
	}

	message KintsugiWorkerAction {
		KintsugiWorkerActions action = 1;
		optional InstanceAction instanceAction = 2;
		optional NICAction nicAction = 3; 
		optional DriveAction driveAction = 4;
		optional ZoneAction zoneAction = 5;

	}

	enum Level {
		ERROR = 0;
		WARNING = 1;
		INFO = 2;
		DEBUG = 3;
	}

	message KintsugiWorkerResponse {
		Level responseLevel = 1;
		optional string msg = 2;
		optional string origin = 3;
	}

	message ConnectionAction {
		enum ConnectionType {
			CONNECT = 0;
			DISCONNECT = 1;
		}

		ConnectionType connectionType = 1;
		required ResourceIdentifier target = 2;
		required ResourceIdentifier client = 3;
	}

	message ZoneAction {
		enum Action {
			ENUMERATERESOURCES = 0;
			ENUMERATEZONES = 1;
		}
		Action act = 1;
		optional ZoneIdentifier zone = 2;
	}
	
	message DriveAction {

	}

	message NICAction {
		enum Action { 
			ASSIGNMAC = 0;
			ASSIGNIP = 1;
			LIST = 2;
		}
		Action act = 1;
		optional ResourceIdentifier id = 2;
		optional ZoneIdentifier zone = 3;
	}


	message ProvisioningInfo {
		string hostname = 1;
		int32 vcpus = 2;
		int64 ram = 3;
		string template = 4;
	}
	
	message InstanceUpdateInfoAction {
		ResourceIdentifier id = 1;
		ProvisioningInfo update = 2;
	}

	message GeneralReply {
		int32 code = 1;
		string info = 2;
	}

	message InstanceAction {
		enum Action {
			START = 0;
			STOP = 1;
			REBOOT = 2;
			REDEPLOY = 3;
			RECOVERY = 4;
			LOG = 5;
			DEPLOY = 6;
			UPDATEINFO = 7;
			UPDATEOS = 8;
			LIST = 9;
		}
		Action act = 1;
		optional ZoneIdentifier zone = 2;
		optional ResourceIdentifier id = 3;
		optional ProvisioningInfo deployInfo = 4; 
		optional InstanceUpdateInfoAction updateInfo = 5; 
	}

";

Socket orchestratorSock;

mixin Command!("connect", 2,
(string[] args) {
	orchestratorSock = Socket(SocketType.req);
	orchestratorSock.connect("tcp://" ~ args[1] ~ ":5556");
	KintsugiWorkerAction w;
	w.action = KintsugiWorkerActions.HELLOACTION;
	orchestratorSock.send(w.serialize());

	auto f = Frame();
	orchestratorSock.receive(f);

	KintsugiWorkerResponse resp = KintsugiWorkerResponse(f.data);
	writeln(resp.msg);
});

static menu_entry orchestratorMenu = {
	name: "orchestrator",
	entries: [
	{
		name: "connect",
		usage: "(string ip)",
		ptr: &__connect
	}]
};
