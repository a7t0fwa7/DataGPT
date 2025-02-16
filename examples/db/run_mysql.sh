lang="en"

# args 1 for language
if [ $# -ge 1 ]; then
    lang=$1
fi

# get current dir
CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

docker rm -f datagpt-example-mysql

docker run -it \
    --rm \
    --name datagpt-example-mysql \
    -e MYSQL_DATABASE=datagpt \
    -e MYSQL_ALLOW_EMPTY_PASSWORD=yes \
    -v ${CUR_DIR}/sql/${lang}/mysql/:/docker-entrypoint-initdb.d/ \
    -p 3306:3306 \
    mariadb \
    --character-set-server=utf8mb4
