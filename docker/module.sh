source $PWD/__setup/util.sh
OS=`uname`

install(){

    printSection "DOCKER"

    printSubsection "The install commands for docker are per OS and will not be covered here."
    sleep 5

    aliasit "mysql_start" "'docker run -d -p 3306:3306 --name db_mysql -e MYSQL_ROOT_PASSWORD=root mysql'"
    aliasit "mysql_stop" "'docker stop db_mysql && docker rm db_mysql'"

}

uninstall(){
    echo "To be implemented"
}