#!/usr/bin/env bash

set -euo pipefail

db_name='plants'
table_name='genuses'
temp_dir="$(mktemp -d -t 'plants_db')"

all_file="${temp_dir}/all.txt"
daeh_file="${temp_dir}/daeh.txt"
liat_file="${temp_dir}/liat.txt"
query_file="${temp_dir}/query.sql"

# setup db
createdb "${db_name}" || ( dropdb "${db_name}" && createdb "${db_name}" )
echo '-q' | xargs -t psql -d "${db_name}" -c "CREATE TABLE ${table_name} (name TEXT);"

# load data
echo "INSERT INTO ${table_name} (name) VALUES" > "${query_file}"

curl -s -H "Authorization: Bearer ${TREFLE_API_TOKEN}" "https://trefle.io/api/genuses?page_size=10" \
  | jq -r '.[].slug' \
  > "${all_file}"

tail -n1 "${all_file}" > "${daeh_file}"
sed \$d  "${all_file}" > "${liat_file}"

while read -r genus; do
  echo "  ('${genus}')," >> "${query_file}"
done < "${liat_file}"

while read -r genus; do
  echo "  ('${genus}')" >> "${query_file}"
done < "${daeh_file}"

echo ';' >> "${query_file}"

echo '-q' | xargs -t  psql -q -d "${db_name}" -f "${query_file}"

# connect to the db
psql -d "${db_name}"
