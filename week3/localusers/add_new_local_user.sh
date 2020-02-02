#!/bin/bash

if [[ ${UID} -ne 0 ]]
then
	echo "you are not a root user"
	exit 1
fi
if [[ ${#} -le 1 ]]
then
	echo "please enter username and password"
	exit 1
fi

USERNAME=${1}
COMMENT="${2}${3}${4}${5}${6}"
SPCHAR=$(echo '!@#$%^&()_+=-' | fold -w1 | shuf | head -c1)
PASWD=$(date +%s%n${RANDOM} | sha256sum | head -c24)
PASSWORD="${SPCHAR}${PASWD}"
useradd -c ${COMMENT} -m ${USERNAME}
if [[ "${?}" -ne 0 ]]
then
  echo 'useradd error'
  exit 1
fi
echo ${PASSWORD} | passwd --stdin ${USERNAME}
if [[ "${?}" -ne 0 ]]
then
  echo 'password setting error'
  exit 1
fi
passwd -e ${USERNAME}
echo "USERNAME is ${USERNAME}"
echo "PASSWORD is ${PASSWORD}"
echo "HOSTNAME is ${HOSTNAME}"

