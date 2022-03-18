<<<<<<< HEAD
# README

 - This application was tested on a RHEL7 system.  To get the necessary libraries for this rails application, you will need:

~~~
  rails > 7.0
  ruby > 2.7.0
  nodejs 
  yarn
  mariadb
  git
~~~

 - The versions procure was tested with:

~~~
  $ rbenv version
  2.7.5 (set by /home/yoder/.ruby-version)

  $ ruby --version
  ruby 2.7.5p203 (2021-11-24 revision f69aeb8314) [x86_64-linux]

  $ node --version
  v16.14.0

  $ yarn --version
  1.22.17

  $ mysql --version
  mysql  Ver 15.1 Distrib 5.5.68-MariaDB, for Linux (x86_64) using readline 5.1
~~~


 - Since RHEL7 package versions are old, we will need to install ruby and nodejs outside of RHEL so we can have better features.

 - You will need the RHEL7 repository enabled, as well as the EPEL repository.

### Install EPEL

~~~
  $ cd /tmp
  $ curl -O https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpmls 
  $ sudo yum install epel-release-latest-7.noarch.rpm
~~~

### Install the necessary packages:

~~~
  $ sudo yum install git git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl mariadb mariadb-server mysql-devel nodejs npm
~~~

### Install a higher version of Ruby.  One option is to use rbenv.

~~~
  <a href="https://github.com/rbenv/rbenv">https://github.com/rbenv/rbenv</a>
~~~

 - Had to add shims to the PATH:

~~~
  $ echo 'export PATH="$HOME/.rbenv/shims:$PATH"' >> ~/.bashrc
~~~

 - rbenv requires the ruby-build plugin which can be installed from this link:

~~~
  <a href"https://github.com/rbenv/ruby-build#readme">https://github.com/rbenv/ruby-build#readme</a>
~~~

 - commands to install ruby-build:

~~~
  $ mkdir -p "$(rbenv root)"/plugins
  $ git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
~~~

### Install ruby 2.7.5

~~~
  $ rbenv install 2.7.5
  $ echo "2.7.5" > ~/.ruby-version
~~~

### Install yarn

~~~
  $ npm install --global yarn
~~~

### Install rails:

~~~
  $ gem install rails
~~~

### Start MariaDB server and create database:

~~~
  $ sudo systemctl start mariadb
  $ mysql -u root
  > create procure_development database in mysql:
  > create database if not exists brocure_development;
  > grant all privileges on brocure_development.* to 'user_name'@'host.example.com' identified by 'password';
  > flush privileges;
~~~

### Download procure into the directory of your choice:

~~
  $ git clone https://github.com/math3matical/procure.git
~~~

### cd into the procure directory

~~~
  $ bundle install
  $ bundle exec rake webpacker:install
  $ bin/rails db:schema:load
  $ bin/rails s -b 192.168.0.15
~~~

### Necessary changes before rails can start:

In order to for rails to run, you will need to edit the config/database.yml file with the user/password for the mysql database.  Also, change the ip address (or use localhost if your application is running on the same system accessing the Web Browser)

~~~
  - config/database.yaml
  - background location   <=== this will be wrong.  The default pathway
~~~

 - The credentials.yml.enc file will not have the master.key.  Delete the one located at:

~~~
  $ rm ./procure/app/config/credentials.yml.enc
~~~

 - Then run this rails command to regenerate it:

~~~
  $ rails credentials:edit
~~~

 - Finally you will be need to edit the credentials that are necessary to make API calls from within procure.  To edit the credentials that will be stored on your rails application (and will be secure as long as you don't share the procure/app/config/master.key:

~~~
  EDITOR="vim" rails credentials:edit
~~~

 - In order to access the api, the format you will need to follow is this (note: the quotation marks should be used):
                                                                     
~~~
rhn:
  user: 'rhn-user-name'
  password: 'pa55w0rd'
bug:
  key: 'bugzilla-token'
~~~


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
