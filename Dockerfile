FROM ubuntu:trusty
MAINTAINER Jimmy Mesta <@jimmesta>

RUN apt-get update && apt-get install -y openjdk-7-jdk wget
RUN mkdir Threadfix 
COPY Install /Threadfix
WORKDIR /Threadfix/tomcat/webapps
RUN wget https://storage.googleapis.com/threadfix/threadfix.war
EXPOSE 8443
WORKDIR /Threadfix
RUN chmod +x threadfix.sh
ENTRYPOINT ["./threadfix.sh"]
RUN sleep 30
RUN echo "INSERT INTO APIKEY VALUES(1,TRUE,'2016-03-22 20:46:55.444000000','2016-03-22 20:46:55.444000000','zrbgpZ9OauUNbyz9H4La3AIcH3mf05rI4UEY5vxTUB5Q',FALSE,'JENKINS',NULL)" >> /Threadfix/database/threadfix.script;
RUN threadfixclipath="/Threadfix/command-line-interface/tfcli.jar";
RUN java -jar ${threadfixclipath} --set key zrbgpZ9OauUNbyz9H4La3AIcH3mf05rI4UEY5vxTUB5Q;
RUN java -jar ${threadfixclipath} --set url https://127.0.0.1:8443/threadfix/rest;
RUN java -jar ${threadfixclipath} --create-team TeamDC;
RUN java -jar ${threadfixclipath} --create-app 1 WebGoat_dc http://127.0.0.1:8080/WebGoat;"
