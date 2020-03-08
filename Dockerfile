FROM bangnab/wildfly-oraclejdk

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN /opt/jboss/wildfly/bin/add-user.sh admin Admin123 --silent

ENV WEBAPPS /opt/jboss/wildfly/standalone/deployments

VOLUME /tmp

COPY --chown=jboss ./ojdbc7.jar  /tmp

COPY --chown=jboss ./customization/. /opt/jboss/wildfly/customization


USER jboss

#CMD ["/bin/bash", "/opt/jboss/wildfly/customization/execute.sh"]
ENTRYPOINT  ["/bin/bash", "/opt/jboss/wildfly/customization/execute.sh"]

