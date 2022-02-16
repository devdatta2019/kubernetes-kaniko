FROM ubuntu:latest

RUN apt-get update -y
ARG CONSOLE=https://us-west1.cloud.twistlock.com/us-3-159181236
ARG USERNAME=900b7165-5f94-4d39-a28b-8958c01a5501
ARG PASSWORD=aszFmAFbIjisuWRL+O+Zx6qnzzE=
ARG IMAGENAME=ubuntu:latest #Specified name to show in Console
#Add Twistcli
RUN mkdir /app
COPY /twistcli /app/twistcli
RUN chmod a+x /app/twistcli
#Execute image scan
RUN /app/twistcli images scan --details --address $https://us-west1.cloud.twistlock.com/us-3-159181236 --user $8e697432-27d3-4b59-9573-bdb30e5f710b --password $5vcLdzwH/NMy4Q/pLNNVNkkGTFw=$ubuntu:latest
