# build the binary so we are compliant with the license
FROM golang:1.12

COPY build.sh /
COPY patches /patches
RUN chmod +x /build.sh

ENTRYPOINT /build.sh