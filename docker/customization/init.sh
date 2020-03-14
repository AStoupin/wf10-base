#!/bin/bash

#
#	Waits for a WildFly started. 
#   Executes commands-init.cli commands to install defined in its datasources and War files
#
 
JBOSS_HOME=/opt/jboss/wildfly
JBOSS_CLI=$JBOSS_HOME/bin/jboss-cli.sh
JBOSS_MODE=${1:-"standalone"}
JBOSS_CONFIG=${2:-"$JBOSS_MODE.xml"}
 
echo "=> Executing Customization script - init phase"
 
 
function wait_for_server() {
  until `$JBOSS_CLI -c ":read-attribute(name=server-state)" 2> /dev/null | grep -q running`; do
    sleep 1
  done
}
 
 
echo "JBOSS_HOME  : " $JBOSS_HOME
echo "JBOSS_CLI   : " $JBOSS_CLI
echo "JBOSS_MODE  : " $JBOSS_MODE
echo "JBOSS_CONFIG: " $JBOSS_CONFIG
 
echo "=> Waiting for the server to boot - init phase"
wait_for_server
 
echo "=> Executing the commands - init phase"
$JBOSS_CLI -c --file=`dirname "$0"`/commands-init.cli

 