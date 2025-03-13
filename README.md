# DAsoftware

# Deploying a Scalable Web Application Using Kubernetes

## Prerequisites
Ensure you have the following tools installed:
- [Docker](https://docs.docker.com/get-docker/)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/)

- Check if correctly installed:
docker --version
minikube version
kubectl version --client


## Step 1: Set Up Kubernetes Cluster
1. Start Minikube:
   minikube start --nodes=2
   
2. Verify the cluster is running:
   kubectl get nodes

## Step 2: Containerize the Web Application
1. Build the Docker image:
   docker build -t <your-dockerhub-username>/software:v1 .

2. Push the image to Docker Hub:
   docker push <your-dockerhub-username>/software:v1

## Step 3: Deploy Kubernetes Resources
1. Apply the Deployment:
   kubectl apply -f deployment.yaml

2. Apply the Service:
   kubectl apply -f service.yaml

3. Verify pods are running:
   kubectl get pods -o wide

4. Get service details:
   kubectl get services

## Step 4: Implement Auto-scaling
1. Apply the Horizontal Pod Autoscaler (HPA):
   kubectl apply -f hpa.yaml

2. Verify HPA:
   kubectl get hpa

## Step 5: Persistent Storage (Optional)
1. Apply the Persistent Volume (PV):
   kubectl apply -f persistent-volume.yaml

2. Apply the Persistent Volume Claim (PVC):
   kubectl apply -f persistent-volume-claim.yaml

## Step 6: Rolling Updates & Rollbacks
1. Update the application:
   kubectl set image deployment/software-deployment software=<your-dockerhub-username>/software:v2

2. Rollback if needed:
   kubectl rollout undo deployment/software-deployment

## Step 7: Testing the Deployment

### Application Availability Test
kubectl get services
curl http://<EXTERNAL-IP>:<PORT>

### Scaling Test
kubectl run --rm -it --image=busybox stress-test -- /bin/sh
while true; do wget -q -O- http://<SERVICE-IP>:<PORT>; done

Verify scaling with:
kubectl get pods -w

### Pod Failure and Self-Healing Test
kubectl delete pod <POD_NAME>
kubectl get pods -w


### Persistent Storage Test
kubectl exec -it <POD_NAME> -- sh -c "echo 'Hello Kubernetes' > /mnt/data/testfile.txt"
kubectl delete pod <POD_NAME>
kubectl exec -it <NEW_POD_NAME> -- sh -c "cat /mnt/data/testfile.txt"

### Logging Test
kubectl logs <POD_NAME>

## Cleanup
To delete all Kubernetes resources:
kubectl delete -f deployment.yaml -f service.yaml -f hpa.yaml -f persistent-volume.yaml -f persistent-volume-claim.yaml

To stop Minikube:
minikube stop


