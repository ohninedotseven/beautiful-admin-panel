module scylla.nic.nicrpc;


// Generated by the gRPC dlang plugin.


import scylla.nic.nic;
import std.array;
import grpc;
import google.protobuf;
import hunt.logging;
import core.thread;


import scylla.zone.zone;


class NICHandlerClient
{
	this(Channel channel)
	{
		_channel = channel;
	}

	ClientReader!ResourceIdentifier ListNICs(ZoneIdentifier request ){
		mixin(CM1!(ResourceIdentifier , NICHandlerBase.SERVICE));
	}
	NetworkInterface GetNIC( ResourceIdentifier request)
	{
		mixin(CM!(NetworkInterface , NICHandlerBase.SERVICE));
	}

	void GetNIC( ResourceIdentifier request , void delegate(Status status , NetworkInterface response) dele)
	{
		mixin(CMA!(NetworkInterface , NICHandlerBase.SERVICE));
	}

	NICReply DeleteNIC( ResourceIdentifier request)
	{
		mixin(CM!(NICReply , NICHandlerBase.SERVICE));
	}

	void DeleteNIC( ResourceIdentifier request , void delegate(Status status , NICReply response) dele)
	{
		mixin(CMA!(NICReply , NICHandlerBase.SERVICE));
	}

	ResourceIdentifier DeployNIC( NetworkInterface request)
	{
		mixin(CM!(ResourceIdentifier , NICHandlerBase.SERVICE));
	}

	void DeployNIC( NetworkInterface request , void delegate(Status status , ResourceIdentifier response) dele)
	{
		mixin(CMA!(ResourceIdentifier , NICHandlerBase.SERVICE));
	}

	NICReply UpdateSecPol( SecPolUpdateAction request)
	{
		mixin(CM!(NICReply , NICHandlerBase.SERVICE));
	}

	void UpdateSecPol( SecPolUpdateAction request , void delegate(Status status , NICReply response) dele)
	{
		mixin(CMA!(NICReply , NICHandlerBase.SERVICE));
	}

	NICReply ActionNIC( NICAction request)
	{
		mixin(CM!(NICReply , NICHandlerBase.SERVICE));
	}

	void ActionNIC( NICAction request , void delegate(Status status , NICReply response) dele)
	{
		mixin(CMA!(NICReply , NICHandlerBase.SERVICE));
	}


	private:
	Channel _channel;
}

class NICHandlerBase: GrpcService
{
	enum SERVICE  = "scylla.nic.NICHandler";
	string getModule()
	{
		return SERVICE;
	}

	Status ListNICs(ZoneIdentifier , ServerWriter!ResourceIdentifier){ return Status.OK; }
	Status GetNIC(ResourceIdentifier , ref NetworkInterface){ return Status.OK; }
	Status DeleteNIC(ResourceIdentifier , ref NICReply){ return Status.OK; }
	Status DeployNIC(NetworkInterface , ref ResourceIdentifier){ return Status.OK; }
	Status UpdateSecPol(SecPolUpdateAction , ref NICReply){ return Status.OK; }
	Status ActionNIC(NICAction , ref NICReply){ return Status.OK; }

	Status process(string method , GrpcStream stream)
	{
		switch(method)
		{
			mixin(SM1!(ZoneIdentifier , ResourceIdentifier , "ListNICs"));
			mixin(SM!(ResourceIdentifier , NetworkInterface , "GetNIC"));
			mixin(SM!(ResourceIdentifier , NICReply , "DeleteNIC"));
			mixin(SM!(NetworkInterface , ResourceIdentifier , "DeployNIC"));
			mixin(SM!(SecPolUpdateAction , NICReply , "UpdateSecPol"));
			mixin(SM!(NICAction , NICReply , "ActionNIC"));
			mixin(NONE());
		}
	}
}


