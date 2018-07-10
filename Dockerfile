# 设置继承镜像
FROM ubuntu:16.04

# 作者信息
MAINTAINER from ljohn

# 运行命令，更改ubuntu的apt源为国内的163源
RUN echo "deb http://mirrors.163.com/ubuntu/ xenial main restricted" > /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ xenial-updates main restricted" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ xenial universe" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ xenial-updates universe" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ xenial multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ xenial-updates multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN apt-get update

# 安装SSH服务
RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh

# 取消 pam 限制
RUN sed -ri 's@session    required     pam_loginuid.so@#session    required     pam_loginuid.so@g' /etc/pam.d/sshd

# 复制配置文件，并赋予执行权限
ADD authorized_keys /root/.ssh/authorized_keys
ADD run.sh /run.sh
RUN chmod 755 /run.sh

# 开放端口
EXPOSE 22

# 设置自启动命令
CMD ["/run.sh"] 
