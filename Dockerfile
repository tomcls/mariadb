FROM ubuntu:16.04
MAINTAINER Thomas Claessens

RUN apt update && apt-get install wget vim curl -y 
RUN DEBIAN_FRONTEND=noninteractive apt install -y python-software-properties software-properties-common 
RUN DEBIAN_FRONTEND=noninteractive apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 
RUN DEBIAN_FRONTEND=noninteractive add-apt-repository 'deb [arch=amd64,i386,ppc64el] ] http://archive.mariadb.org/mariadb-10.3.15/repo/ubuntu xenial main' 
RUN DEBIAN_FRONTEND=noninteractive apt-get install apt-transport-https ca-certificates -y
RUN apt-get update

RUN echo mariadb-server mysql-server/root_password password ci4ever | debconf-set-selections
RUN echo mariadb-server mysql-server/root_password_again password ci4ever | debconf-set-selections
RUN LC_ALL=fr_BE.utf8 DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::='--force-confnew' -qqy install mariadb-server

RUN wget https://repo.percona.com/apt/percona-release_0.1-4.xenial_all.deb
RUN dpkg -i percona-release_0.1-4.xenial_all.deb
RUN apt-get update
RUN apt-get install percona-xtrabackup-24 -y


EXPOSE 3306

RUN service mysql start
