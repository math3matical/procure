<<<<<<< HEAD
# README

This README would normally document whatever steps are necessary to get the
application up and running.

https://guides.rubyonrails.org/getting_started.html
install git
rhel-7-server-rpms

install git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl

install mariadb mariadb-server mysql-devel

cd /tmp
#curl -O https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpmls 
# ls *.rpm
yum install epel-release-latest-7.noarch.rpm

#had to do add rbenv build plugin for the doctor script to be happy
#plugin:
https://github.com/rbenv/ruby-build#readme
$ mkdir -p "$(rbenv root)"/plugins
$ git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

#had to add this for the doctor script to be happy:
 echo 'export PATH="$HOME/.rbenv/shims:$PATH"' >> ~/.bashrc

rbenv install 2.7.5
echo "2.7.5" > ~/.ruby-version

yum isntall nodejs
yum isntall npm

npm install --global yarn

gem install rails

systemctl start mariadb
mysql -u root


create brocure_development database in mysql:
create database if not exists brocure_development;
grant all privileges on brocure_development.* to 'yoder'@'shab1.ooo.mu' identified by 'redhat';
flush privileges;


cd into procure director
bundle install






Things you may want to cover:

https://guides.rubyonrails.org/getting_started.html

# rbenv version
2.7.5 (set by /root/procure/.ruby-version)

# node --version
v16.13.2

# yarn --version
1.22.17

gem install rails

yum install openssl11
rbenv install 2.7.5     <=== requires openssl11 (i think, hope :) )


ruby --version
 Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
=======
# procure
>>>>>>> 6ca89f50e4a0b1c47faafb37722c99a332c5f8d8
