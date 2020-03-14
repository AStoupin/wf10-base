#!/bin/bash
 
# Usage: execute.sh [WildFly mode] [configuration file]
#
# The default mode is 'standalone' and default configuration is based on the
# mode. It can be 'standalone.xml' or 'domain.xml'.
 
echo "=> Executing Customization script - build phase"

JBOSS_HOME=/opt/jboss/wildfly
JBOSS_CLI=$JBOSS_HOME/bin/jboss-cli.sh
JBOSS_MODE=${1:-"standalone"}
JBOSS_CONFIG=${2:-"$JBOSS_MODE.xml"}
 
function wait_for_server() {
  until `$JBOSS_CLI -c ":read-attribute(name=server-state)" 2> /dev/null | grep -q running`; do
    sleep 1
  done
}
 
echo "=> Starting WildFly server - build phase"
 
echo "JBOSS_HOME  : " $JBOSS_HOME
echo "JBOSS_CLI   : " $JBOSS_CLI
echo "JBOSS_MODE  : " $JBOSS_MODE
echo "JBOSS_CONFIG: " $JBOSS_CONFIG
 
echo $JBOSS_HOME/bin/$JBOSS_MODE.sh -b 0.0.0.0 -c $JBOSS_CONFIG &
$JBOSS_HOME/bin/$JBOSS_MODE.sh -b 0.0.0.0 -c $JBOSS_CONFIG &
 
echo "=> Waiting for the server to boot - build phase"
wait_for_server
 
echo "=> Executing the commands - build phase"
$JBOSS_CLI -c --file=`dirname "$0"`/commands-build.cli

echo "=> Shutting down WildFly - build phase"
if [ "$JBOSS_MODE" = "standalone" ]; then
  $JBOSS_CLI -c ":shutdown"
else
  $JBOSS_CLI -c "/host=*:shutdown"
fi
echo "=> Self-swept commands  - build phase"
rm -r /opt/jboss/wildfly/standalone/configuration/standalone_xml_history