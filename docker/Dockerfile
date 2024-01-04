### Webapp build
FROM node:16.3.0@sha256:ca6daf1543242acb0ca59ff425509eab7defb9452f6ae07c156893db06c7a9a4 as nodebuild

WORKDIR /webapp
ADD webapp/ /webapp

### 'CPPFLAGS="-DPNG_ARM_NEON_OPT=0"' Needed To Avoid Bug Described in: https://github.com/imagemin/optipng-bin/issues/118#issuecomment-1019838562
### Can be Removed when Ticket will be Closed
RUN CPPFLAGS="-DPNG_ARM_NEON_OPT=0" npm install --no-optional && \
    npm run pack

### Go build
FROM golang:1.18.3@sha256:b203dc573d81da7b3176264bfa447bd7c10c9347689be40540381838d75eebef AS gobuild

WORKDIR /go/src/focalboard
ADD . /go/src/focalboard

# Get target architecture 
ARG TARGETOS
ARG TARGETARCH  

RUN EXCLUDE_PLUGIN=true EXCLUDE_SERVER=true EXCLUDE_ENTERPRISE=true make server-docker os=${TARGETOS} arch=${TARGETARCH}

## Final image
FROM cloudron/base:4.2.0@sha256:46da2fffb36353ef714f97ae8e962bd2c212ca091108d768ba473078319a47f4

ADD docker/start.sh /app/code/start.sh
RUN chown -R cloudron:cloudron /app/code
RUN chmod +x /app/code/start.sh
RUN mkdir -p /opt/focalboard/data/files
RUN chown -R cloudron:cloudron /opt/focalboard

WORKDIR /opt/focalboard

COPY --from=nodebuild --chown=cloudron:cloudron /webapp/pack pack/
COPY --from=gobuild --chown=cloudron:cloudron /go/src/focalboard/bin/docker/focalboard-server bin/
COPY --from=gobuild --chown=cloudron:cloudron /go/src/focalboard/LICENSE.txt LICENSE.txt
COPY --from=gobuild --chown=cloudron:cloudron /go/src/focalboard/docker/server_config.json config.json


USER cloudron

EXPOSE 8000/tcp

EXPOSE 8000/tcp 9092/tcp

CMD [ "/app/code/start.sh" ]