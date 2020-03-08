# WildFly 10 docker base image
Installed components
- Oracle Java 8
- WildFly 10


Usefull scripts
to bulid
docker build -t wf10-base .
to run 
docker run -d  wf10-base 

to run bash in interactive mode and root params
docker exec -u:0 -it container_num /bin/bash

debug mode
docker run -it --entrypoint=/bin/bash  wf10-base

