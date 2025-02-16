lang="en"

# args 1 for language
if [ $# -ge 1 ]; then
    lang=$1
fi

echo ${lang}

# get current dir
CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "${CUR_DIR}/sql/${lang}/pg/*.sql"

docker rm -f datagpt-example-pg

docker run -it \
    --rm \
    --name datagpt-example-pg \
    -e POSTGRES_DB=datagpt \
    -e POSTGRES_HOST_AUTH_METHOD=trust \
    -v ${CUR_DIR}/sql/${lang}/pg/:/docker-entrypoint-initdb.d/ \
    -p 5432:5432 \
    postgres:14
