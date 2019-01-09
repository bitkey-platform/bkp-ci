FROM circleci/golang:1.11

RUN go get github.com/golang/dep/cmd/dep \
    && go get google.golang.org/grpc \
    && go get github.com/stormcat24/protodep \
    && go get github.com/grpc-ecosystem/go-grpc-middleware/validator \
    && go get github.com/mwitkow/go-proto-validators \
    && go get github.com/mwitkow/go-proto-validators/protoc-gen-govalidators \
    && go get github.com/rubenv/sql-migrate/... \
    && go get github.com/golang/mock/gomock \
    && go install github.com/golang/mock/mockgen

RUN GIT_TAG="v1.2.0" \
    && go get -d -u github.com/golang/protobuf/protoc-gen-go \
    && git -C "$(go env GOPATH)"/src/github.com/golang/protobuf checkout $GIT_TAG \
    && go install github.com/golang/protobuf/protoc-gen-go

RUN sudo apt-get update
RUN curl -OL https://github.com/google/protobuf/releases/download/v3.2.0/protoc-3.2.0-linux-x86_64.zip \
    && unzip protoc-3.2.0-linux-x86_64.zip -d protoc3\
    && sudo mv protoc3/bin/* /usr/local/bin/\
    && sudo mv protoc3/include/* /usr/local/include/\
    && sudo chown circleci /usr/local/bin/protoc\
    && sudo chown -R circleci /usr/local/include/google

RUN sudo apt-get -y install mysql-client \
    && sudo apt-get install ruby-full \
    && sudo gem install bundler \
    && sudo gem install danger -v "5.11.0"

RUN sudo curl -sfL https://install.goreleaser.com/github.com/golangci/golangci-lint.sh | sudo sh -s -- -b $(go env GOPATH)/bin v1.12.5
