FROM ubuntu:latest

COPY azulsystems.gpg /etc/apt/trusted.gpg.d/

ARG DEBIAN_FRONTEND=noninteractive

RUN echo 'deb http://repos.azulsystems.com/ubuntu stable main' > /etc/apt/sources.list.d/zulu.list \
&& apt-get -qq update \
&& apt-get -qqy install zulu-8 \
&& apt-get -qq clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
&& sed -i \
-e 's_^[#\s]\{0,2\}securerandom\.source=.*_securerandom.source=file:/dev/urandom_' \
-e 's_^[#\s]\{0,2\}securerandom\.strongAlgorithms=.*_securerandom.strongAlgorithms=NativePRNGNonBlocking:SUN_' \
-e 's_^[#\s]\{0,2\}crypto\.policy=.*_crypto.policy=unlimited_' \
/usr/lib/jvm/zulu-8-amd64/jre/lib/security/java.security

ENV LANG=C.UTF-8
