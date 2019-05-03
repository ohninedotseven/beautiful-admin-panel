// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: instance.proto

module scylla.instance.instance;

import google.protobuf;
import scylla.drive.drive;
import scylla.zone.zone;

enum protocVersion = 3006001;

class InstanceReply
{
    @Proto(1) int code = protoDefaultValue!int;
    @Proto(2) string info = protoDefaultValue!string;
}

class InstanceUpdateAction
{
    @Proto(1) ResourceIdentifier id = protoDefaultValue!ResourceIdentifier;
    @Proto(2) ProvisioningInfo update = protoDefaultValue!ProvisioningInfo;
}

class InstanceAction
{
    @Proto(1) Action action = protoDefaultValue!Action;
    @Proto(2) ResourceIdentifier instance = protoDefaultValue!ResourceIdentifier;

    enum Action
    {
        START = 0,
        STOP = 1,
        REBOOT = 2,
        REDEPLOY = 3,
        RECOVERY = 4,
    }
}

class ProvisioningInfo
{
    @Proto(1) string hostname = protoDefaultValue!string;
    @Proto(2) int vcpus = protoDefaultValue!int;
    @Proto(3) long ram = protoDefaultValue!long;
    @Proto(4) string template_ = protoDefaultValue!string;
}

class InstanceStatus
{
    @Proto(1) string datacenter = protoDefaultValue!string;
    @Proto(2) string hostname = protoDefaultValue!string;
    @Proto(3) int vcpus = protoDefaultValue!int;
    @Proto(4) long ram = protoDefaultValue!long;
    @Proto(5) string template_ = protoDefaultValue!string;
    @Proto(6) Status status = protoDefaultValue!Status;
    @Proto(7) Drive[] drive = protoDefaultValue!(Drive[]);

    enum Status
    {
        ONLINE = 0,
        OFFLINE = 1,
        REDEPLOYING = 2,
        RECOVERY = 3,
        PROVISIONING = 4,
    }
}
