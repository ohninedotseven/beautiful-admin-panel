// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: resource_manager.proto

module scylla.models.kintsugi.resource_manager;

import google.protobuf;
import scylla.internal.zone;
import google.protobuf.any;

enum protocVersion = 3007000;

struct GeneralReply
{
    @Proto(1) int code = protoDefaultValue!int;
    @Proto(2) string info = protoDefaultValue!string;
}
