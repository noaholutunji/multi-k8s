docker build -t noalistic/multi-client:latest -t noalistic/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t noalistic/multi-server:latest -t noalistic/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t noalistic/multi-worker:latest -t noalistic/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push noalistic/multi-client:latest
docker push noalistic/multi-server:latest
docker push noalistic/multi-worker:latest

docker push noalistic/multi-client:$SHA
docker push noalistic/multi-server:$SHA
docker push noalistic/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=noalistic/multi-server:$SHA
kubectl set image deployments/client-deployment client=noalistic/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=noalistic/multi-worker:$SHA
