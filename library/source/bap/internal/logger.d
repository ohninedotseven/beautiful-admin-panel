// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: logger.proto

module bap.internal.logger;

import google.protobuf;

enum protocVersion = 3007000;

struct LogEvent
{
    @Proto(1) string origin = protoDefaultValue!string;
    @Proto(2) LogLevel level = protoDefaultValue!LogLevel;
    @Proto(3) string message = protoDefaultValue!string;
}

enum LogLevel
{
    ERROR = 0,
    WARNING = 1,
    INFO = 2,
    DEBUG = 3,
}
