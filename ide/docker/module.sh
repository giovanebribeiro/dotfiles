source $PWD/__setup/util.sh

install(){

    printSection "DOCKER"

    printSubsection "The install commands for docker are per OS and will not be covered here. Aliasing some useful commands"
    sleep 5

    aliasit "mysql_start" "'docker run -d -p 3306:3306 --name db_mysql -e MYSQL_ROOT_PASSWORD=root mysql'"
    aliasit "mysql_stop" "'docker stop db_mysql && docker rm db_mysql'"
    aliasit "docker_clean" "'docker image prune -a && docker container prune && docker volume prune && docker network prune'"

}

uninstall(){
    echo "To be implemented"
}
