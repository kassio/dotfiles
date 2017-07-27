#!/usr/bin/env bash

# active=1
#
# _query() {
#   result=$(/usr/local/bin/mysql \
#     --host="127.0.0.1" \
#     --user="root" \
#     --password="root" \
#     --database="dbtest" \
#     -e "${1}" \
#     2>/dev/null)
#
#   echo ${result}
# }
#
# main() {
#   _query \
#     "SELECT count(*) AS VIEWS \
#      FROM rules \
#      WHERE type = 'View'" | tr "\n" " "
# }
#
# others() {
#   _query \
#     "SELECT \
#      table_name as NAME, \
#      table_rows as ROWS\
#      FROM information_schema.tables \
#      WHERE table_schema = 'zendesk_test' \
#      ORDER BY table_rows desc \
#      LIMIT 20" | column -t
# }

source="${HOME}/.query"

if [ ! -f "${source}" ]
then
  exit 0
fi

IFS="  "
source ${HOME}/.query

if [ ${active} -ne 0 ]
then
  echo "$(main) | size=12"
  echo "---"
  echo "$(others | sed -e 's/$/| size=12 font=Monaco/')"
fi
