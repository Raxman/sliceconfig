#!/bin/bash
# Copyright (c) 2008-2009, the Flatsoft, LLC.
# All rights reserved

# sliceconfig dir

printf "\n\tВыбирите тип установки: \n
\t1. Базовый сервер
\t2. MySQL сервер 
\t3. Веб-сервер для RoR
\t4. Веб-сервер для PHP \n
Выбирите тип установки: "
read settype

#path_parent=`cd ..; pwd`
#path_secsc="$path_parent/security/scripts"
#path_inssc="$path_parent/install/scripts" 
#. "$path_inssc/configuration.sh"


##############################################
setbase_() {
# sliceconfig dir
sliceconfig=`dirname $0`/..
sliceconfig=`readlink -f $sliceconfig`

# clean yum database
yum clean all

# copy private files from another host
sh $sliceconfig/security/scripts/copy_private_files.sh

# setup valid perms on sliceconfigs
sh $sliceconfig/security/scripts/setup_perms_sliceconfig.sh 


# yum configuration
sh $sliceconfig/security/scripts/update_yum.sh
sh $sliceconfig/install/scripts/setup_yum.sh

# remove unused rpms
sh $sliceconfig/install/scripts/erase_i386.sh
#sh $sliceconfig/install/scripts/erase_hal.sh 

# install required software
sh $sliceconfig/install/scripts/install_perl.sh
sh $sliceconfig/install/scripts/install_sendmail.sh
sh $sliceconfig/install/scripts/install_security_base.sh
sh $sliceconfig/install/scripts/install_tools_editors.sh
sh $sliceconfig/install/scripts/install_tools_system.sh
sh $sliceconfig/install/scripts/install_tools_build.sh
sh $sliceconfig/install/scripts/install_tools_network_debug.sh
sh $sliceconfig/install/scripts/install_tools_net_utils.sh
sh $sliceconfig/install/scripts/install_vsftpd.sh

sh $sliceconfig/install/scripts/install_ruby_enterprise.sh
sh $sliceconfig/install/scripts/install_git.sh
sh $sliceconfig/install/scripts/install_rdup.sh
sh $sliceconfig/install/scripts/install_s3sync.sh
sh $sliceconfig/install/scripts/install_munin_node.sh
sh $sliceconfig/install/scripts/install_monit.sh
sh $sliceconfig/install/scripts/install_image_magick.sh

# user configuration
sh $sliceconfig/install/scripts/setup_users_root.sh
sh $sliceconfig/install/scripts/setup_users_admin.sh


# system configuration
sh $sliceconfig/install/scripts/setup_motd.sh
sh $sliceconfig/install/scripts/setup_i18n.sh
sh $sliceconfig/install/scripts/setup_hosts.sh
sh $sliceconfig/install/scripts/setup_aliases.sh
sh $sliceconfig/install/scripts/setup_crond.sh
sh $sliceconfig/install/scripts/setup_ssh.sh
sh $sliceconfig/install/scripts/setup_logwatch.sh
sh $sliceconfig/install/scripts/setup_ruby_enterprise_path.sh
#sh $sliceconfig/install/scripts/setup_ssh_logger.sh
sh $sliceconfig/install/scripts/setup_iptables.sh
sh $sliceconfig/install/scripts/setup_sudo.sh
sh $sliceconfig/install/scripts/setup_sendmail.sh
sh $sliceconfig/install/scripts/setup_vsftpd.sh
sh $sliceconfig/install/scripts/setup_rkhunter.sh
sh $sliceconfig/install/scripts/setup_monit.sh
sh $sliceconfig/install/scripts/setup_munin_node.sh
sh $sliceconfig/install/scripts/setup_rdup.sh
sh $sliceconfig/install/scripts/setup_s3sync.sh


# erase unused users
sh $sliceconfig/security/scripts/erase_users.sh


# overwrite users bashrc
sh $sliceconfig/security/scripts/setup_users_bashrc.sh


# setup perm on several dirs
sh $sliceconfig/security/scripts/setup_perms_root.sh
sh $sliceconfig/security/scripts/setup_perms_home.sh
sh $sliceconfig/security/scripts/setup_perms_etc.sh
sh $sliceconfig/security/scripts/setup_perms_logs.sh
sh $sliceconfig/security/scripts/setup_perms_backups.sh
sh $sliceconfig/security/scripts/setup_perms_tools.sh
sh $sliceconfig/security/scripts/setup_perms_suid.sh


# upgrade system
sh $sliceconfig/security/scripts/update_yum.sh
sh $sliceconfig/security/scripts/update_rkhunter_db.sh
sh $sliceconfig/security/scripts/update_rkhunter_hash.sh


# erase history
sh $sliceconfig/security/scripts/erase_history.sh
}
##############################################

setmysql_() {
# sliceconfig dir
sliceconfig=`dirname $0`/..
sliceconfig=`readlink -f $sliceconfig`


# install required software
sh $sliceconfig/install/scripts/install_mysqld.sh
sh $sliceconfig/install/scripts/install_ruby_mysql.sh


# setup mysql
sh $sliceconfig/install/scripts/setup_mysqld.sh
sh $sliceconfig/install/scripts/setup_automysqlbackup.sh
sh $sliceconfig/install/scripts/setup_munin_node_mysqld.sh
sh $sliceconfig/install/scripts/setup_monit_mysqld.sh

# setup perm on several dirs
sh $sliceconfig/security/scripts/setup_perms_etc.sh
sh $sliceconfig/security/scripts/setup_perms_backups.sh


# erase history
sh $sliceconfig/security/scripts/erase_history.sh 
}
##############################################

setror_() {
echo empty
}
##############################################

setphp_() {
# sliceconfig dir
sliceconfig=`dirname $0`/..
sliceconfig=`readlink -f $sliceconfig`


# install required software
sh $sliceconfig/install/scripts/install_httpd.sh
sh $sliceconfig/install/scripts/install_php.sh


# software configuration
sh $sliceconfig/install/scripts/setup_httpd.sh
sh $sliceconfig/install/scripts/setup_php.sh
sh $sliceconfig/install/scripts/setup_munin_node_httpd.sh
sh $sliceconfig/install/scripts/setup_monit_httpd.sh


# setup perm on several dirs
sh $sliceconfig/security/scripts/setup_perms_php.sh
sh $sliceconfig/security/scripts/setup_perms_httpd.sh
sh $sliceconfig/security/scripts/setup_perms_etc.sh


# erase history
sh $sliceconfig/security/scripts/erase_history.sh 
}


case "$settype" in
    1)
	setbase_
	;;
    2)
	setmysql_
	;;
    3)
	setror_
	;;
    4)
	setphp_
	;;
    *)
	printf "\nВведено неправильное значение установки $settype\n\n"
	exit 1
esac


