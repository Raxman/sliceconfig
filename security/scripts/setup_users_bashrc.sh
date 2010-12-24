# Copyright (c) 2008-2009, the Flatsoft, LLC.
# All rights reserved


# sliceconfig dir
sliceconfig=`cd ..; cd ..; pwd`
path_secint="$path_parent/security/interactive"
. /$path_secint/functions

for user in $( user_unlock ); do
  if [ ${user} == "root" ]; then
    HOMEDIR="/root"
  else
    HOMEDIR="/home/${user}"
  fi

  if [ -e "${HOMEDIR}/.bashrc" ]; then
    mv ${HOMEDIR}/.bashrc ${HOMEDIR}/.bashrc.orig
  fi

  cat $sliceconfig/config/home/admin/.bashrc > ${HOMEDIR}/.bashrc
  chown -R ${user} ${HOMEDIR}/
done
