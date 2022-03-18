## README

 - This application was built and tested on RHEL 7.9.  Other systems may work, but this guide is for configuring a RHEL 7.9 server to run the procure rails application, requiring the following packages:

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

 - procure was initially developed with sqlit3, but sqlite3 lacked certain features other databases such as mysql or postgresql had.  Other databases can be use, however, sqlite3 will not be compatible with some of the procure features.

 - RHEL7 doesn't offer ruby higher than 2.0, or nodejs higher than 4.0.  As such, we will need to install ruby and nodejs outside of the Red Hat repositories so we can have newer features.

 - You will need the RHEL7 repository enabled, as well as the EPEL repository.

<br>
### 1) Install EPEL

~~~
  $ cd /tmp
  $ curl -O https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm 
  $ sudo yum install -y epel-release-latest-7.noarch.rpm
~~~

<br>
### 2) Install the necessary packages

~~~
  $ sudo yum install git git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl mariadb mariadb-server mysql-devel nodejs npm vim
~~~

<br>
### 3) Install a version of Ruby > 2.7.0.  One option is to use `rbenv`

 > https://github.com/rbenv/rbenv

 - To install `rbenv` with the `Basic GitHub Checkout` method, run these commands:

~~~
  $ git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  $ cd ~/.rbenv && src/configure && make -C src
  $ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  $ ~/.rbenv/bin/rbenv init
~~~

 - At this point, the instructions say to restart the shell and try the `rbenv-doctor` script, but it will fail.  You will first need to add `shims` to the `$PATH` variable:

~~~
  $ echo 'export PATH="$HOME/.rbenv/shims:$PATH"' >> ~/.bashrc
~~~

 - And then need to install the `ruby-build` plugin which can be installed from this link:

 > <a href="https://github.com/rbenv/ruby-build#readme">https://github.com/rbenv/ruby-build#readme</a>

 - Commands to install ruby-build plugin (make sure you start a new shell, i.e. logout and back in first):

~~~
  $ mkdir -p "$(rbenv root)"/plugins
  $ git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
~~~

 - Then make sure the shell is restarted, and make sure the `rbenv-doctor` script returns successful:

~~~
  $ curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-doctor | bash
~~~

<br>
### 4) Install ruby 2.7.5

~~~
  $ rbenv install 2.7.5
  $ echo "2.7.5" > ~/.ruby-version
~~~

<br>
### 5) Install yarn

~~~
  $ sudo npm install --global yarn
~~~

<br>
### 6) Install rails

~~~
  $ gem install rails
~~~

<br>
### 7) Start MariaDB server and create database.  Be sure to substitute for `user_name`, `host.ip` and `password` in the 2 `grant` sql queries below.  The `user_name`, `password` and `host.ip` used here will be the same ones used for the `config/database.yml` file set up in step 9

~~~
  $ sudo systemctl start mariadb; sudo systemctl enable mariadb
  $ mysql -u root
  > create database if not exists procure_development;
  > create database if not exists procure_test;
  > grant all privileges on procure_development.* to 'user_name'@'host.ip' identified by 'password';
  > grant all privileges on procure_test.* to 'user_name'@'host.ip' identified by 'password';
  > flush privileges;
  > exit
~~~

<br>
### 8) Download procure into the directory of your choice

~~~
  $ git clone https://github.com/math3matical/procure.git
~~~

<br>
### 9) Edit the `procure/config/database.yml` and update the `username`, `password`, and `host` to the values used in step 7

<br>
### 10) Navigate to the procure directory (substituting for the correct pathway to the procure directory for the `/PATH/TO`).  Then execute the rest of the commands

~~~
  $ cd /PATH/TO/procure/
  $ bundle install
  $ bundle exec rake webpacker:install
  $ bin/rails db:schema:load
~~~

<br>
### 11) Double check firewall port 3000 is open

~~~
  $ sudo firewall-cmd --add-port=3000/tcp --permanent; sudo firewall-cmd --reload
~~~

<br>
### 12) To verify if rails can start successfully run this command and then navigate to the address of your server at port 3000 in a browser, e.g `192.168.0.1:3000`

~~~
  $ bin/rails s -b <host.ip>
~~~

<br>
### 13) Necessary changes before procure can make API calls and change background colors.  You will need to stop the rails console and start it again for the changes to take affect.  To stop the rails server, type `ctrl+c` in the same terminal as the `bin/rails s -b <host.ip>` command was ran

 - The css profiles for the background colors is hardcoded to `/home/user/procure/app/assets/stylesheets/backups/`.  This will change depdening on the name of the user, as well as where the procure app is installed.  This setting can be changed in the `procure/app/services/color_change.rb` file.  Be sure to update both file locations used in the `color_change.rb` script.

 - In order to leverage the API calls procure uses, you must update the rails credentials file.  Run this rails command while in the `procure` directory to generate a `config/credentials.yml.enc` and `config/master.key` file.

~~~
  $ rails credentials:edit
~~~

 - To add credentials to the rails credentials file, run this command from the `procure` directory of the rails application:

~~~
  $ EDITOR="vim" rails credentials:edit
~~~ 

 - These credentials will be safe as long as the `procure/app/config/master.key` is not shared with anyone.  In addition, both the `master.key` and `credentials.yml.enc` have been added to the `.gitignore` file.

 - In order to access the API from procure, you will need your rhn id and password (e.g. rhn-support-myoder), and also a Bugzilla API token.  The format you will need to follow is this (note: the quotation marks should stay, just change the value for the `user`, `password` and `key`)
                                                                     
~~~
rhn:
  user: 'rhn-user-name'
  password: 'pa55w0rd'
bug:
  key: 'bugzilla-token'
~~~

 - To obtain a Bugzilla API token, login to <a href="https://bugzilla.redhat.com/userprefs.cgi?tab=apikey">https://bugzilla.redhat.com/userprefs.cgi?tab=apikey</a>


<br>
### 14) Populating the Tag Group and Tag Item tables.  This process is currently manual, but will be added into the UI

 - From the procure directory, login to the rails console:

~~~
  $ bin/rails conosole
~~~

 - To create a new Tag Group:

~~~
   TagGroup.new(name: "Example Group").save
~~~

 - To create a new Tag Item, use this command, replacing <ID> for the Tag Group id:

~~~
   TagItem.new(name: "Example Item", tag_group_id: <ID>).save
~~~

 - The Tag Group id can be found many ways.  One such way:

~~~
   TagGroup.find_by_name("Example Group").id
~~~

 - To exit the console

~~~
  > exit
~~~

 - It is best to create a template for these commands in a text editor by creating however many you need.  Fill in the values for the `:name` and `:tag_group_id` values.  Copy them to the `rails console` to save them.  

 - These values should help you tag objects in the procure application.  Tags can be filtered on with the `filter` button.  The filter logic is currently an `inclusive or`.  An example tag group with associated tag items:

~~~
  Tag Group: Networking

  TAG Items: IPv4, IPv6, Bridge, VLAN, Bond, Proxy, Firewall, TCPdump 
~~~
