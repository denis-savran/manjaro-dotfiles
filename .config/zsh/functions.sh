# Docker
function docker-backup () {
    DIR=`pwd`
    docker run --rm -v $1:/volume -v $DIR:/backup alpine sh -c "cd /volume && tar -czf /backup/$1.tar.gz ."
    ls -lh $DIR/$1.tar.gz
}

function docker-restore () {
    DIR=`pwd`
    docker run --rm -v $1:/volume -v $DIR:/backup alpine sh -c "cd /volume && find . -maxdepth 1 -not -path . -exec rm -rf {} \; && tar -xf /backup/$1.tar.gz && ls -lah"
}
