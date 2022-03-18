## README

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

### Install the necessary packages

~~~
  $ sudo yum install git git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl mariadb mariadb-server mysql-devel nodejs npm
~~~

### Install a higher version of Ruby.  One option is to use rbenv

<a href="https://github.com/rbenv/rbenv">https://github.com/rbenv/rbenv</a>

 - Used the `Basic GitHub Checkout` method to install rbenv.  Commands for `Basic GitHub Checkout`:

~~~
  $ git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  $ cd ~/.rbenv && src/configure && make -C src
  $ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  $ ~/.rbenv/bin/rbenv init
~~~

 - At this point, the instructions say to restart the shell and try the `rbenv-doctor` script, but it will fail.  You will first need to add shims to the $PATH variable:

~~~
  $ echo 'export PATH="$HOME/.rbenv/shims:$PATH"' >> ~/.bashrc
~~~

 - And then need to install the ruby-build plugin which can be installed from this link:

<a href="https://github.com/rbenv/ruby-build#readme">https://github.com/rbenv/ruby-build#readme</a>

 - Commands to install ruby-build plugin:

~~~
  $ mkdir -p "$(rbenv root)"/plugins
  $ git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
~~~

 - Then make sure the shell is restarted, and try the `rbenv-doctor` script:

~~~
  $ curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-doctor | bash
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

### Install rails

~~~
  $ gem install rails
~~~

### Start MariaDB server and create database

~~~
  $ sudo systemctl start mariadb
  $ mysql -u root
  > create database if not exists procure_development;
  > grant all privileges on procure_development.* to 'user_name'@'host.example.com' identified by 'password';
  > flush privileges;
~~~

### Download procure into the directory of your choice

~~~
  $ git clone https://github.com/math3matical/procure.git
~~~

### cd into the procure directory

~~~
  $ bundle install
  $ bundle exec rake webpacker:install
  $ bin/rails db:schema:load
  $ bin/rails s -b 192.168.0.15
~~~

### Necessary changes before rails can start

 - In order to for rails to run, you will need to edit the config/database.yml file with the user/password for the mysql database.  Also, change the ip address (or use localhost if your application is running on the same system accessing the Web Browser).

 - The css profiles for the background colors is hardcoded to `/root/home/user/procure/app/assets/stylesheets/backups/`.  This will change depdening on the name of the user, as well as where the procure app is installed.

 - The credentials.yml.enc file will not have the master.key.  Delete the one located at:

~~~
  $ rm ./procure/app/config/credentials.yml.enc
~~~

 - Then run this rails command to regenerate it:

~~~
  $ rails credentials:edit
~~~

 - Finally you will be need to edit the credentials that are necessary to make API calls from within procure.  To edit the credentials that will be stored on your rails application (and will be secure as long as you don't share the `procure/app/config/master.key`:

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

 - To obtain a bugzilla api token, login to <a href="https://bugzilla.redhat.com/userprefs.cgi?tab=apikey">https://bugzilla.redhat.com/userprefs.cgi?tab=apikey</a>


* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
