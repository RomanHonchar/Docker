#!/bin/bash

values=(${PARAMS//,/ })
CS_IP=${values[0]}
CS_U=${values[1]}
CS_P=${values[2]}
ES_NAME=${values[3]}

export MONO_IOMAP=all
/bin/rm -f /tmp/QsExecutionServer.exe.lock
mono /opt/ExecutionServer/QsExecutionServerConsoleConfig.exe /s:$CS_IP /u:$CS_U /p:$CS_P /esn:$ES_NAME /i:100 
unset PARAMS
export
mono-service -d:/opt/ExecutionServer /opt/ExecutionServer/QsExecutionServer.exe --no-daemon
