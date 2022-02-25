FROM ubuntu:18.04
RUN apt-get update && \
apt-get install -y redis-server && \
apt-get clean
EXPOSE 6379
ENTRYPOINT ["redis-server", "--protected-mode no"]
#Image Scanning variables, passed in from pipeline (See command below)
ARG CONSOLE=https://us-west1.cloud.twistlock.com/us-3-159181236
ARG USERNAME=f04d752e-26fd-4c43-b4ec-0b1a96d60ad7
ARG PASSWORD=Fd541jRnVmlYnrsn3H0Onu+al28=
ARG IMAGENAME=hello:kaniko
#Add Twistcli
RUN mkdir /app
COPY /twistcli /app/twistcli
RUN chmod a+x /app/twistcli
#Execute image scan
RUN /app/twistcli images scan --containerized --details --address https://us-west1.cloud.twistlock.com/us-3-159181236 --user
f04d752e-26fd-4c43-b4ec-0b1a96d60ad7 --password Fd541jRnVmlYnrsn3H0Onu+al28=  hello:kaniko
