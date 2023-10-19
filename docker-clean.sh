docker system prune -a -f --volumes
docker container stop $(docker container ls -aq)
docker container rm $(docker container ls -aq)
docker rmi $(docker images -aq)
docker volume prune -a -f
