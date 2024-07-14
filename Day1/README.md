## Day1

This is aws-quick start from [Crossplane docs](https://docs.crossplane.io/latest/getting-started/provider-aws/)


Software versions used:

```
kind version
kind v0.23.0 go1.21.10 linux/amd64

kubectl version
Client Version: v1.30.2
Kustomize Version: v5.0.4-0.20230601165947-6ce0bf390ce3
```
Create a kind cluster with:

```
kind create cluster --config kind-cluster.yaml
```

Install CP with helm chart:

```
helm repo add \
crossplane-stable https://charts.crossplane.io/stable
helm repo update

helm install crossplane \
crossplane-stable/crossplane \
--namespace crossplane-system \
--create-namespace
```

At time of writing Chart Version: 1.16.0 is installed.

-The family provider manages authentication to AWS across all AWS family Providers.

Need to install provider: that install related CRDs, providerconfig to auth, managed resource yaml.

Que:
```
kubectl apply -f managed-s3-bucket.yaml 
error: from cp-bucket-jd-: cannot use generate name with apply
```