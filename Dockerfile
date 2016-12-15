FROM        gavinjonespf/docker-mc-backuprestore:latest

#Build args
ARG         COMMIT_ID=unknown
ARG         GIT_COMMIT=unknown
ARG         GIT_BRANCH=unknown
ARG         BUILD_NUMBER=experimental
ARG         GIT_URL=unknown
ARG         BUILD_DATE=$BUILD_NUMBER
ARG         BUILD_VERSION=$BUILD_NUMBER
ARG         IMAGE_NAME="docker-basic-storage-mgmt"
ARG         IMAGE_DESC="Storage manager files - backup and restore"
ARG         IMAGE_URL=$GIT_URL

ENV         TERM=xterm

RUN         apk  --no-cache add git

#All cron scripts
COPY        files/crontab/* /etc/cron.d/

COPY        ./scripts /app/scripts
WORKDIR     /app/scripts
RUN         chmod -R +x *.sh

#Add version txt
RUN         mkdir -p /v/ && echo "IMAGE_NAME=${IMAGE_NAME}\nIMAGE_DESC=${IMAGE_DESC}\nIMAGE_URL=${IMAGE_URL}\nCOMMIT_URL=${GIT_URL}\nCOMMIT=${GIT_COMMIT}-${COMMIT_ID}\nBUILD=${BUILD_NUMBER}\nBRANCH=${GIT_BRANCH}\n" >> /v/$IMAGE_NAME.txt

# Basic build-time metadata as defined at http://label-schema.org
LABEL       org.label-schema.schema-version="1.0.0-rc.1" \
            org.label-schema.build-date=${BUILD_DATE} \
            org.label-schema.license="Copyright" \
            org.label-schema.name=${IMAGE_DESC} \
            org.label-schema.url=${IMAGE_URL} \
            org.label-schema.vendor="Power Farming" \
            org.label-schema.version=${BUILD_VERSION} \
            org.label-schema.vcs-ref=${GIT_COMMIT} \
            org.label-schema.vcs-url=${GIT_URL} \
            org.label-schema.vcs-type="Git"

ENTRYPOINT [ "/app/scripts/start.sh" ]
CMD ["/etc/cron.d/storagemgr", ""]
