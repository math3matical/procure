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

### 1) Install EPEL

~~~
  $ cd /tmp
  $ curl -O https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm 
  $ sudo yum install -y epel-release-latest-7.noarch.rpm
~~~

### 2) Install the necessary packages

~~~
  $ sudo yum install git git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl mariadb mariadb-server mysql-devel nodejs npm
~~~

### 3) Install a higher version of Ruby.  One option is to use rbenv

 > https://github.com/rbenv/rbenv

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

 > <a href="https://github.com/rbenv/ruby-build#readme">https://github.com/rbenv/ruby-build#readme</a>

 - Commands to install ruby-build plugin (make sure you start a new shell, i.e. logout and back in):

~~~
  $ cd
  $ mkdir -p "$(rbenv root)"/plugins
  $ git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
~~~

 - Then make sure the shell is restarted, and try the `rbenv-doctor` script:

~~~
  $ curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-doctor | bash
~~~

### 4) Install ruby 2.7.5

~~~
  $ rbenv install 2.7.5
  $ echo "2.7.5" > ~/.ruby-version
~~~

### 5) Install yarn

~~~
  $ sudonpm install --global yarn
~~~

### 6) Install rails

~~~
  $ gem install rails
~~~

### 7) Start MariaDB server and create database.  Be sure to substitute for `user_name`, `host.ip` and `password` in the 2 grant sql queries.  The `user_name` and `password` used here will be the same ones used for the `config/database.yml` file set up in step 9

~~~
  $ sudo systemctl start mariadb
  $ mysql -u root
  > create database if not exists procure_development;
  > create database if not exists procure_test;
  > grant all privileges on procure_development.* to 'user_name'@'host.ip' identified by 'password';
  > grant all privileges on procure_test.* to 'user_name'@'host.ip' identified by 'password';
  > flush privileges;
  > exit
~~~

### 8) Download procure into the directory of your choice

~~~
  $ git clone https://github.com/math3matical/procure.git
~~~

### 9) Edit the `procure/config/database.yml` and update the `username`, `password`, and `host` to the values used in step 7.

### 10) cd into the procure directory and execute the following commands substituting your servers ip for the `<host.ip>` value

~~~
  $ bundle install
  $ bundle exec rake webpacker:install
  $ bin/rails db:schema:load
  $ bin/rails s -b <host.ip>
~~~

### 11) Necessary changes before rails can start

 - The css profiles for the background colors is hardcoded to `/home/user/procure/app/assets/stylesheets/backups/`.  This will change depdening on the name of the user, as well as where the procure app is installed.  This setting is hardcoded and can be changed in the `procure/app/services/color_change.rb` file.

 - In order to leverage the api aspects of the procure application, you must update the rails credentials file.  First, we need to remove the current `credentials.yml.enc` file, as you won't have the `master.key` for it:

~~~
  $ rm ./procure/config/credentials.yml.enc
~~~

 - Then run this rails command while in the `procure` directory to regenerate it:

~~~
  $ rails credentials:edit
~~~

 - Finally you will be need to edit the credentials that are necessary to make API calls from within procure.  To edit the credentials that will be stored on your rails application (and will be secure as long as you don't share the `procure/app/config/master.key`:

~~~
  $ EDITOR="vim" rails credentials:edit
~~~

 - In order to access the api, the format you will need to follow is this (note: the quotation marks should stay, just change the value for the `user`, `password` and `key`)
                                                                     
~~~
rhn:
  user: 'rhn-user-name'
  password: 'pa55w0rd'
bug:
  key: 'bugzilla-token'
~~~

 - To obtain a bugzilla api token, login to <a href="https://bugzilla.redhat.com/userprefs.cgi?tab=apikey">https://bugzilla.redhat.com/userprefs.cgi?tab=apikey</a>


### 12) Populating the Tag Group and Tag Item tables

 - From the procure directory, login to the rails console:

~~~
  $ bin/rails conosole
~~~

 - To create a new Tag Group:

~~~
  > TagGroup.new(name: "Example Group").save
~~~

 - To create a new Tag Item (replacing <ID> for the Tag Group id:

~~~
  > TagItem.new(name: "Example Item", tag_group_id: <ID>).save
~~~

 - The Tag Group id can be found many ways.  One such way:

~~~
  > TagGroup.find_by_name("Example Group").id
~~~

 - It is best to create a template for these commands in a text editor.  Copy them as many as you need, and insert the values for the Tag Groups and Tag Items.  These values should help you tag objects in the procure application.  An example tag group with associated tag items:

~~~
  Tag Group: Networking

  TAG Items: IPv4, IPv6, Bridge, VLAN, Bond, Proxy, Firewall, TCPdump 
~~~
