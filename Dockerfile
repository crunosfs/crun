ARG     BASE_IMG=alpine:latest

FROM    $BASE_IMG AS build

RUN     apk --update --no-cache add \
        curl

WORKDIR /mnt/bin

ARG     REPO=containers/crun

RUN     TAG=$(curl --silent https://api.github.com/repos/$REPO/releases/latest | grep '"tag_name":' | cut -d"\"" -f4) \
	&& wget -O crun https://github.com/containers/crun/releases/download/0.16/crun-$TAG-linux-amd64-disable-systemd

RUN	chmod +x /mnt/bin/crun



FROM    scratch

COPY    --from=build /mnt/ /
