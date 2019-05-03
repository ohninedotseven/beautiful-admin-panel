module scylla.node.noderpc;


// Generated by the gRPC dlang plugin.


import scylla.node.node;
import std.array;
import grpc;
import google.protobuf;
import hunt.logging;
import core.thread;


import scylla.instance.instance;
import scylla.zone.zone;
import scylla.drive.drive;
import scylla.nic.nic;


class NodeHandlerClient
{
	this(Channel channel)
	{
		_channel = channel;
	}

	ResourceStatus QueryResource( ResourceIdentifier request)
	{
		mixin(CM!(ResourceStatus , NodeHandlerBase.SERVICE));
	}

	void QueryResource( ResourceIdentifier request , void delegate(Status status , ResourceStatus response) dele)
	{
		mixin(CMA!(ResourceStatus , NodeHandlerBase.SERVICE));
	}

	DestroyReply DestroyResource( ResourceIdentifier request)
	{
		mixin(CM!(DestroyReply , NodeHandlerBase.SERVICE));
	}

	void DestroyResource( ResourceIdentifier request , void delegate(Status status , DestroyReply response) dele)
	{
		mixin(CMA!(DestroyReply , NodeHandlerBase.SERVICE));
	}

	ResourceReply QuerySystemResources( ProvisioningInfo request)
	{
		mixin(CM!(ResourceReply , NodeHandlerBase.SERVICE));
	}

	void QuerySystemResources( ProvisioningInfo request , void delegate(Status status , ResourceReply response) dele)
	{
		mixin(CMA!(ResourceReply , NodeHandlerBase.SERVICE));
	}

	ResourceIdentifier CreateInstance( ProvisioningInfo request)
	{
		mixin(CM!(ResourceIdentifier , NodeHandlerBase.SERVICE));
	}

	void CreateInstance( ProvisioningInfo request , void delegate(Status status , ResourceIdentifier response) dele)
	{
		mixin(CMA!(ResourceIdentifier , NodeHandlerBase.SERVICE));
	}

	InstanceReply RedeployInstance( ResourceIdentifier request)
	{
		mixin(CM!(InstanceReply , NodeHandlerBase.SERVICE));
	}

	void RedeployInstance( ResourceIdentifier request , void delegate(Status status , InstanceReply response) dele)
	{
		mixin(CMA!(InstanceReply , NodeHandlerBase.SERVICE));
	}

	InstanceReply RecoverInstance( ResourceIdentifier request)
	{
		mixin(CM!(InstanceReply , NodeHandlerBase.SERVICE));
	}

	void RecoverInstance( ResourceIdentifier request , void delegate(Status status , InstanceReply response) dele)
	{
		mixin(CMA!(InstanceReply , NodeHandlerBase.SERVICE));
	}

	ResourceIdentifier CreateDrive( Drive request)
	{
		mixin(CM!(ResourceIdentifier , NodeHandlerBase.SERVICE));
	}

	void CreateDrive( Drive request , void delegate(Status status , ResourceIdentifier response) dele)
	{
		mixin(CMA!(ResourceIdentifier , NodeHandlerBase.SERVICE));
	}

	DriveReply RedeployDrive( ResourceIdentifier request)
	{
		mixin(CM!(DriveReply , NodeHandlerBase.SERVICE));
	}

	void RedeployDrive( ResourceIdentifier request , void delegate(Status status , DriveReply response) dele)
	{
		mixin(CMA!(DriveReply , NodeHandlerBase.SERVICE));
	}

	NICReply CreateNIC( NetworkInterface request)
	{
		mixin(CM!(NICReply , NodeHandlerBase.SERVICE));
	}

	void CreateNIC( NetworkInterface request , void delegate(Status status , NICReply response) dele)
	{
		mixin(CMA!(NICReply , NodeHandlerBase.SERVICE));
	}

	NICReply UpdateSecPol( SecPolUpdateAction request)
	{
		mixin(CM!(NICReply , NodeHandlerBase.SERVICE));
	}

	void UpdateSecPol( SecPolUpdateAction request , void delegate(Status status , NICReply response) dele)
	{
		mixin(CMA!(NICReply , NodeHandlerBase.SERVICE));
	}

	NICReply AssignPublicIP( ResourceIdentifier request)
	{
		mixin(CM!(NICReply , NodeHandlerBase.SERVICE));
	}

	void AssignPublicIP( ResourceIdentifier request , void delegate(Status status , NICReply response) dele)
	{
		mixin(CMA!(NICReply , NodeHandlerBase.SERVICE));
	}

	NICReply AssignPrivateIP( ResourceIdentifier request)
	{
		mixin(CM!(NICReply , NodeHandlerBase.SERVICE));
	}

	void AssignPrivateIP( ResourceIdentifier request , void delegate(Status status , NICReply response) dele)
	{
		mixin(CMA!(NICReply , NodeHandlerBase.SERVICE));
	}

	AssociationReply AssociateDevice( AssociationInfo request)
	{
		mixin(CM!(AssociationReply , NodeHandlerBase.SERVICE));
	}

	void AssociateDevice( AssociationInfo request , void delegate(Status status , AssociationReply response) dele)
	{
		mixin(CMA!(AssociationReply , NodeHandlerBase.SERVICE));
	}

	AssociationReply DisassociateDevice( AssociationInfo request)
	{
		mixin(CM!(AssociationReply , NodeHandlerBase.SERVICE));
	}

	void DisassociateDevice( AssociationInfo request , void delegate(Status status , AssociationReply response) dele)
	{
		mixin(CMA!(AssociationReply , NodeHandlerBase.SERVICE));
	}

	ClientReader!BillableUnit GetBillableHours(ResourceIdentifier request ){
		mixin(CM1!(BillableUnit , NodeHandlerBase.SERVICE));
	}
	InstanceLog GetInstanceLog( ResourceIdentifier request)
	{
		mixin(CM!(InstanceLog , NodeHandlerBase.SERVICE));
	}

	void GetInstanceLog( ResourceIdentifier request , void delegate(Status status , InstanceLog response) dele)
	{
		mixin(CMA!(InstanceLog , NodeHandlerBase.SERVICE));
	}


	private:
	Channel _channel;
}

class NodeHandlerBase: GrpcService
{
	enum SERVICE  = "scylla.node.NodeHandler";
	string getModule()
	{
		return SERVICE;
	}

	Status QueryResource(ResourceIdentifier , ref ResourceStatus){ return Status.OK; }
	Status DestroyResource(ResourceIdentifier , ref DestroyReply){ return Status.OK; }
	Status QuerySystemResources(ProvisioningInfo , ref ResourceReply){ return Status.OK; }
	Status CreateInstance(ProvisioningInfo , ref ResourceIdentifier){ return Status.OK; }
	Status RedeployInstance(ResourceIdentifier , ref InstanceReply){ return Status.OK; }
	Status RecoverInstance(ResourceIdentifier , ref InstanceReply){ return Status.OK; }
	Status CreateDrive(Drive , ref ResourceIdentifier){ return Status.OK; }
	Status RedeployDrive(ResourceIdentifier , ref DriveReply){ return Status.OK; }
	Status CreateNIC(NetworkInterface , ref NICReply){ return Status.OK; }
	Status UpdateSecPol(SecPolUpdateAction , ref NICReply){ return Status.OK; }
	Status AssignPublicIP(ResourceIdentifier , ref NICReply){ return Status.OK; }
	Status AssignPrivateIP(ResourceIdentifier , ref NICReply){ return Status.OK; }
	Status AssociateDevice(AssociationInfo , ref AssociationReply){ return Status.OK; }
	Status DisassociateDevice(AssociationInfo , ref AssociationReply){ return Status.OK; }
	Status GetBillableHours(ResourceIdentifier , ServerWriter!BillableUnit){ return Status.OK; }
	Status GetInstanceLog(ResourceIdentifier , ref InstanceLog){ return Status.OK; }

	Status process(string method , GrpcStream stream)
	{
		switch(method)
		{
			mixin(SM!(ResourceIdentifier , ResourceStatus , "QueryResource"));
			mixin(SM!(ResourceIdentifier , DestroyReply , "DestroyResource"));
			mixin(SM!(ProvisioningInfo , ResourceReply , "QuerySystemResources"));
			mixin(SM!(ProvisioningInfo , ResourceIdentifier , "CreateInstance"));
			mixin(SM!(ResourceIdentifier , InstanceReply , "RedeployInstance"));
			mixin(SM!(ResourceIdentifier , InstanceReply , "RecoverInstance"));
			mixin(SM!(Drive , ResourceIdentifier , "CreateDrive"));
			mixin(SM!(ResourceIdentifier , DriveReply , "RedeployDrive"));
			mixin(SM!(NetworkInterface , NICReply , "CreateNIC"));
			mixin(SM!(SecPolUpdateAction , NICReply , "UpdateSecPol"));
			mixin(SM!(ResourceIdentifier , NICReply , "AssignPublicIP"));
			mixin(SM!(ResourceIdentifier , NICReply , "AssignPrivateIP"));
			mixin(SM!(AssociationInfo , AssociationReply , "AssociateDevice"));
			mixin(SM!(AssociationInfo , AssociationReply , "DisassociateDevice"));
			mixin(SM1!(ResourceIdentifier , BillableUnit , "GetBillableHours"));
			mixin(SM!(ResourceIdentifier , InstanceLog , "GetInstanceLog"));
			mixin(NONE());
		}
	}
}


