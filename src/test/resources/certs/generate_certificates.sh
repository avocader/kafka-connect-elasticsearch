#!/usr/bin/env bash

# Generate the certificates used in the HTTPS tests.
# Copy these into the docker image to make available to client (Java class in this repo) and
# elastic server (docker container started in test setup). Volume mounting is unsolved issue.

# Todo: It may be possible to call this directly from the docker-maven-plugin

# Todo: find a way to use DNS and hostnames
DOMAIN=`hostname -i`

echo "Generating certificates for ${DOMAIN}"
pwd

openssl genrsa -out /usr/share/elasticsearch/config/certs/key.pem 2048
openssl req -new -x509 -keyout /usr/share/elasticsearch/config/certs/cacert.key -out /usr/share/elasticsearch/config/certs/ca.pem -days 3000 \
    -passin pass:asdfasdf \
    -passout pass:asdfasdf \
    -subj "/C=US/ST=CA/L=Palo Alto/O=Confluent/CN=$DOMAIN"
openssl req -new -key /usr/share/elasticsearch/config/certs/key.pem -out /usr/share/elasticsearch/config/certs/cert.csr \
    -subj "/C=US/ST=CA/L=Palo Alto/O=Confluent/CN=$DOMAIN"
openssl x509 -req -in /usr/share/elasticsearch/config/certs/cert.csr -CA /usr/share/elasticsearch/config/certs/ca.pem -CAkey /usr/share/elasticsearch/config/certs/cacert.key -CAcreateserial \
    -passin pass:asdfasdf \
    -out /usr/share/elasticsearch/config/certs/cert.pem -days 10000 -sha256
openssl pkcs12 -export -out /usr/share/elasticsearch/config/certs/bundle.p12 -in /usr/share/elasticsearch/config/certs/cert.pem -inkey /usr/share/elasticsearch/config/certs/key.pem \
    -passin pass:asdfasdf \
    -passout pass:asdfasdf
/opt/jdk-11.0.1/bin/keytool -keystore /usr/share/elasticsearch/config/certs/truststore.jks -import -file /usr/share/elasticsearch/config/certs/ca.pem -alias cacert \
    -storepass asdfasdf -noprompt
/opt/jdk-11.0.1/bin/keytool -destkeystore /usr/share/elasticsearch/config/certs/keystore.jks -deststorepass asdfasdf \
    -importkeystore -srckeystore /usr/share/elasticsearch/config/certs/bundle.p12  -srcstorepass asdfasdf -srcstoretype PKCS12 \
    -noprompt

chmod 777 ./*

export ES_JAVA_OPTS="$ES_JAVA_OPTS -Djavax.net.debug=ssl:handshake"

/usr/local/bin/docker-entrypoint.sh eswrapper


#exec "$@"