#!/usr/bin/env bash

# ${HOME}/.query example:
# # Connection
# user="root"
# password="root"
# host="127.0.0.1"
# port="3306"
# database="store"
# MYSQL_URL="mysql://${user}:${password}@${host}:${port}/${database}"
#
# # Query
# query="select count(*) USERS from users"

source ${HOME}/.query

if [ -n "${query}" ]
then
  result=$(/usr/local/bin/mysql \
    --host="${host}" \
    --user="${user}" \
    --password="${password}" \
    --database="${database}" \
    -e "${query}" \
    2>/dev/null)
  result="$(echo ${result:-FAIL} | tr '\n' ' ')"

  echo "${result} | size=12"
  echo "---"
  echo "MYSQL_URL: ${MYSQL_URL}"
  echo "query: ${query}"
fi
