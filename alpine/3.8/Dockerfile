FROM scratch

LABEL "online.simha.vendor"="Simha Online Services Private Limited <devops@simhaglobal.com>" \
      "maintainer"="Megam.Cloud - A Model Driven Platform as a Service" \
      "description"="Alpine Linux Distribution" \
      "architecture"="amd64" \
      "version"="3.8.1"
	  
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Alpine Linux Distribution - Alpine:latest Image" \
      org.label-schema.description="Megam.Cloud - A Model Driven Platform as a Service" \
      org.label-schema.usage="https://github.com/simhaonline/Dockerfile#docker-run" \
      org.label-schema.url="https://megam.cloud" \
      org.label-schema.vcs-url="https://github.com/simhaonline/Dockerfile.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vendor="Megam.Cloud - Simha Online Services Private Limited"
      org.label-schema.version="3.8.1"
      org.label-schema.schema-version="1.0.0"
      org.label-schema.docker.cmd="docker run -i -t -rm alpine:3.8 cat /etc/alpine-release"
	  
ADD rootfs.tar.xz /

CMD ["/bin/sh"]
