# README

### 部署须知: 
该项目是一个个人主页
* Rails 5.0.2    
* Ruby 2.3.1

=====================以下为平台部署详细步骤==================================
### 1. 初始化Ubuntu机器
##### 1.1 更新机器环境
```
$ sudo apt-get update 
$ sudo apt-get upgrade
```
##### 1.2 安装插件
```
$ sudo apt-get install build-essential bison openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev libcurl4-openssl-dev
```
##### 1.3 安装RVM(Ruby Version Manager,Ruby版本管理器)
```
$ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
```
执行成功后会显示(加载了一个key):
> gpg: requesting key D39DC0E3 from hkp server keys.gnupg.net <br>
gpg: /root/.gnupg/trustdb.gpg: trustdb created <br>
gpg: key D39DC0E3: public key "Michal Papis (RVM signing) <mpapis@gmail.com>" imported <br>
gpg: no ultimately trusted keys found <br>
gpg: Total number processed: 1 <br>
gpg:               imported: 1  (RSA: 1) <br>

接下来执行
```
$ curl -L https://raw.githubusercontent.com/wayneeseguin/rvm/master/binscripts/rvm-installer | bash -s stable
```
成功后会显示:
> Creating group 'rvm' <br>
Installing RVM to /usr/local/rvm/
Installation of RVM in /usr/local/rvm/ is almost complete: <br>
\* First you need to add all users that will be using rvm to 'rvm' group, and logout - login again, anyone using rvm will be operating with \`umask u=rwx,g=rwx,o=rx\`. <br>
\* To start using RVM you need to run `source /etc/profile.d/rvm.sh` in all your open shell windows, in rare cases you need to reopen all shell windows. <br>
\# Administrator, <br>
\# <br>
\# Thank you for using RVM! <br>
\# We sincerely hope that RVM helps to make your life easier and more enjoyable!!! <br>
\# <br>
\# ~Wayne, Michal & team. <br>
In case of problems: https://rvm.io/help and https://twitter.com/rvm_io

##### 1.4 安装完成后重新打开终端，输入以下指令检查是否安装正确
```
$ rvm -v
```
显示结果可能如下：
> rvm 1.29.1 (latest) by Michal Papis, Piotr Kuczynski, Wayne E. Seguin [https://rvm.io/]

##### 1.5 安装Ruby(需要利用1.3、1.4步骤中安装好的RVM)
```
$ rvm install 2.3.1
```
##### 1.6 安装完成后，输入以下指令检查Ruby是否安装正确
```
$ ruby -v
```
显示结果可能如下：
> ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-darwin15]

```
$ gem -v
```
显示结果可能如下：
> 2.5.1

##### 1.7 修改gem源
```
$ gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/
```
##### 1.8 安装Bundler
```
$ gem install bundler
```
##### PS: 到此Rails相关功能已安装完毕
##### 1.9 安装git
```
===注意:请将下边大括号{}内的内容替换成你的信息===
$ sudo apt-get install git-core
$ git config --global user.name "{Your Name}"
$ git config --global user.email "{your@email.com}"
$ git config --global color.ui true
$ git config --global core.editor vi
```
##### 1.10 生成SSH Key
```
===注意:请将下边大括号{}内的内容替换成你的信息===
$ ssh-keygen -t rsa -C "{your_email@youremail.com}"
$ cat ~/.ssh/id_rsa.pub
```
##### 1.11 将ssh公钥复制到gitcode上
登录实施用gitcode账号 depoly@xjgreat.com <br>
进入<http://gitcode.aggso.com/profile/keys>页面,点击右上角`ADD SSH KEY`按钮,<br>
在Key栏中输入生成的SSH Key, Title栏中输入标题(可自行拟定), 点击左下角`ADD KEY`按钮提交即可。
##### 1.12 下载ImageMagick(平台项目需要的插件)
```
$ sudo apt-get -y install imagemagick
$ sudo apt-get -y install libmagic-dev
$ sudo apt-get -y install libmagickwand-dev
```
##### 1.13 安装redis
```
$ wget http://download.redis.io/releases/redis-2.8.24.tar.gz
$ tar -zxvf redis-2.8.24.tar.gz
$ cd redis-2.8.24
$ make
$ make install
```
进入redis项目路径后，通过如下指令启动：
```
$ redis-server &
```
通过执行以下指令进入redis命令行界面，用以查看redis是否启动:
```
$ redis-cli
```
### 2. 获取项目
##### 2.1 克隆正确的项目
```
===注意:请将下边大括号{}内的内容替换成项目路径===
$ git clone {project_path}
```
##### 2.2 切换分支(需进入项目路径)
获取项目后默认在master分支上，通过
```
$ git branch -a
```
查看远程仓库的所有分支，显示结果可能(视具体项目而定)如下:
> \* master <br>
  zhongguo_kuangyedaxue <br>
  remotes/origin/HEAD -> origin/master <br>
  remotes/origin/jiangnan_daxue <br>
  remotes/origin/master <br>
  remotes/origin/zhongguo_kuangyedaxue

其中，前边标识*的为现在的分支。
通过执行以下指令来切换分支，
```
===注意:请将下边大括号{}内的内容替换成分支名===
$ git checkout {branch_name}
```
##### 2.3 安装项目所需组件
在项目路径下，执行
```
$ bundle install
```
成功后应显示
> Bundle complete! 46 Gemfile dependencies, 118 gems now installed. <br>
  Use \`bundle show \[gemname]\` to see where a bundled gem is installed.

其中具体的数字会有所不同
### 3. 配置与启动项目
##### 3.1 配置数据库
配置数据库前，先利用项目下的`db/api.sql`与`db/xj_apps_platform.sql`两个数据库sql脚本生成平台的依赖库api(存储API基础配置数据)与xj_apps_platform(平台相关数据，如平台用户、开发者等等)。

复制项目中的数据库配置备份文件
```
cd config
cp database.yml.bak database.yml
```
修改`database.yml`中的数据库配置，将其中的development链接的库修改为刚刚生成的xj_apps_platform库，将api链接的库修改为刚刚生成的api库。
##### 3.2 修改基础配置
在项目中的`config/school_config/schools/`目录下，添加`{学校名}.rb`的配置文件，其内容可以复制诸如`xijiadaxue.rb`等基础配置文件。<br>
在文件的末尾，修改常量`LOCAL_API_DOMAIN`，改为该高校API项目的URL。<br>
接下来，在项目下的`config/initializers/`目录下，修改`base_config.rb`文件，其内容可能如下:<br>
```
require File.expand_path('../../school_config/schools/xijiadaxue',__FILE__)
```
将`xijiadaxue`修改为刚刚配置的学校的基础配置文件名即可。
##### 3.3 修改启动端口号
在启动之前,需要修改`config/puma.rb`文件中的端口号，对应下边这行代码:
```
port        ENV.fetch("PORT") { 8022 }
```
修改大括号中的数字，设为平台项目的端口号后保存即可(默认是8022端口)
##### 3.4 启动项目
以上步骤全部完成后，在项目路径下，通过puma来启动项目，执行
```
$ bundle exec puma -C config/puma.rb --daemon
```
=====================以上为项目大概部署详细步骤(其中redis没有用到)==================================
