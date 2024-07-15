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

```
kubectl describe bucket 
Name:         cp-bucket-jd-qpq6q
Namespace:    
Labels:       <none>
Annotations:  crossplane.io/external-name: cp-bucket-jd-qpq6q
API Version:  s3.aws.upbound.io/v1beta1
Kind:         Bucket
Metadata:
  Creation Timestamp:  2024-07-14T18:36:26Z
  Generate Name:       cp-bucket-jd-
  Generation:          2
  Resource Version:    6417
  UID:                 958bc716-6400-4bb3-8e34-efc2ebde0eff
Spec:
  Deletion Policy:  Delete
  For Provider:
    Region:  ap-south-1
    Tags:
      Crossplane - Kind:            bucket.s3.aws.upbound.io
      Crossplane - Name:            cp-bucket-jd-qpq6q
      Crossplane - Providerconfig:  default
  Init Provider:
  Management Policies:
    *
  Provider Config Ref:
    Name:  default
Status:
  At Provider:
  Conditions:
    Last Transition Time:  2024-07-14T18:36:26Z
    Message:               connect failed: cannot initialize the Terraform plugin SDK async external client: cannot get terraform setup: cannot get referenced Provider: default: ProviderConfig.aws.upbound.io "default" not found
    Reason:                ReconcileError
    Status:                False
    Type:                  Synced
Events:
  Type     Reason                   Age                  From                                            Message
  ----     ------                   ----                 ----                                            -------
  Warning  CannotConnectToProvider  22s (x8 over 2m24s)  managed/s3.aws.upbound.io/v1beta1, kind=bucket  cannot initialize the Terraform plugin SDK async external client: cannot get terraform setup: cannot get referenced Provider: default: ProviderConfig.aws.upbound.io "default" not found
```

```
kubectl delete -f managed-s3-bucket.yaml 
error: error when deleting "managed-s3-bucket.yaml": resource name may not be empty
```