# [Based on image] resin/rpi-raspbian
# that supports qemu-arm-static
# meaning the built images can be hosted on any machine, not just on ARM.
#
# Commented the CMD line (the last line), so append the following to 'docker run' command.
# If to run the containers on ARM, add 
# /usr/sbin/sshd -D
# right after owner/dockerImage:tag as part of the command.
#
# Or if to run the containers on x86, add
# /usr/bin/qemu-arm-static /usr/sbin/sshd -D
# right after owner/dockerImage:tag as part of the command.
#
#
# VERSION	0.0.7
# Last updated	2017-MARCH-11

FROM resin/rpi-raspbian
MAINTAINER vincetseng

RUN apt-get update && apt-get install ssh
RUN mkdir /var/run/sshd

RUN echo 'root:raspbian' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN test -d /root/.ssh || mkdir -p /root/.ssh
RUN cp /etc/ssh/ssh_host_rsa_key.pub /root/.ssh/authorized_keys
RUN echo 'IdentityFile /etc/ssh/ssh_host_rsa_key' >> /etc/ssh/ssh_config

#CMD ["/usr/bin/qemu-arm-static", "/usr/sbin/sshd", "-D"]
