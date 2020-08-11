FROM circleci/golang:1.12.4

ARG VCS_REF
ARG BUILD_DATE
LABEL maintainer="Bitkey Inc." \
      org.label-schema.url="https://bitkey.co.jp" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/bitkey-platform/bkp-ci"\
      org.label-schema.vcs-ref=$VCS_REF

ENV PROTOBUF_GIT_TAG="v1.2.0" \
    PROTOC_VERSION="3.12.3" \
    MOCKGEN_VERSION="v1.4.4"

RUN go get github.com/golang/dep/cmd/dep \
    && go get google.golang.org/grpc \
    && go get github.com/stormcat24/protodep \
    && go get github.com/grpc-ecosystem/go-grpc-middleware/validator \
    && go get github.com/mwitkow/go-proto-validators \
    && go get github.com/mwitkow/go-proto-validators/protoc-gen-govalidators \
    && go get -u golang.org/x/tools/go/packages \
    && go get github.com/golang/mock/gomock \
    && GO111MODULE=on go get -u github.com/golang/mock/mockgen@${MOCKGEN_VERSION} \
    && go get -d -u github.com/golang/protobuf/protoc-gen-go \
    && git -C "$(go env GOPATH)"/src/github.com/golang/protobuf checkout $PROTOBUF_GIT_TAG \
    && go install github.com/golang/protobuf/protoc-gen-go\
    && sudo apt-get update \
    && curl -L https://github.com/google/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-x86_64.zip -o /tmp/protoc-${PROTOC_VERSION}-linux-x86_64.zip \
    && unzip /tmp/protoc-${PROTOC_VERSION}-linux-x86_64.zip -d /tmp/protoc\
    && sudo mv /tmp/protoc/bin/* /usr/local/bin/\
    && sudo mv /tmp/protoc/include/* /usr/local/include/\
    && sudo chown circleci /usr/local/bin/protoc\
    && sudo chown -R circleci /usr/local/include/google\
    && sudo apt-get -y install postgresql-client\
    && rm -fr /tmp/*

CMD ["/bin/sh"]