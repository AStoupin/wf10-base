FROM bangnab/wildfly-oraclejdk

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN /opt/jboss/wildfly/bin/add-user.sh admin Admin123 --silent

ENV WEBAPPS /opt/jboss/wildfly/standalone/deployments

VOLUME /tmp

COPY --chown=jboss ./docker/ojdbc7.jar  /tmp

COPY --chown=jboss ./docker/customization/. /opt/jboss/wildfly/customization

CMD  chmod +x /opt/jboss/wildfly/customization/build.sh  && \
	 chmod +x /opt/jboss/wildfly/customization/execute.sh  && \
	 chmod +x /opt/jboss/wildfly/customization/init.sh

# pack custumizations into the image
# use this template for packaging in extension layers
CMD ["/bin/bash", "/opt/jboss/wildfly/customization/build.sh"]

USER jboss

ENTRYPOINT  ["/bin/bash", "/opt/jboss/wildfly/customization/execute.sh"]




