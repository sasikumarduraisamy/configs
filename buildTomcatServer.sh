#!/bin/sh
ServerParam=$1
TAG="tomcat:tomcat"
echo TAG: ${TAG}
eval $(minikube docker-env)
#docker login -u ${NexusUserName} -p ${NexusPassword} ${NexusUrl}
docker build . -t ${TAG}
#docker tag ${TAG} ${NexusUrl}/${TAG}
#docker push ${NexusUrl}/${TAG}
#docker logout ${NexusUrl}

docker ps -a | grep "bin/catalina.sh"* | awk '{print $1}'
if [ $? -eq 0 ]
then
docker ps -a | grep "bin/catalina.sh"* | awk '{print $1}' |xargs docker rm -f
fi

docker run --name tomcat-server -it -d -p 8888:8080 ${TAG} bin/catalina.sh $ServerParam

# Clean up local docker registry on Jenkins Slave node.

#echo "########################################"
#echo "# Check for images with ${TAG} in them #"
#echo "########################################"

#docker images --no-trunc | grep ${TAG}
#if [ $? -eq 0 ]
#then
 # docker rmi --force `docker images -q --no-trunc ${TAG}`
 # docker images --no-trunc | grep ${TAG}
#fi
exit 0
