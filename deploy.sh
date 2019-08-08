docker build -t careys/client-multi:latest -t careys/client-multi:$SHA -f ./client/Dockerfile ./client
docker build -t careys/multi-server:latest -t careys/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t careys/multi-worker:latest -t careys/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push careys/client-multi:latest
docker push careys/multi-server:latest
docker push careys/multi-worker:latest

docker push careys/client-multi:$SHA
docker push careys/multi-server:$SHA
docker push careys/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=careys/multi-server:$SHA
kubectl set image deployments/client-deployment client=careys/client-multi:$SHA
kubectl set image deployments/worker-deployment worker=careys/multi-worker:$SHA