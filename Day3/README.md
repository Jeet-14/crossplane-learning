## Day 3

This is about distributions of providers, xr, xrds using OCI using xp
All resources in config/ and app/ are admin/sre/pe sides.

-Files from config/ were used to create, build,puish pkg to OCI
-File from app/ is something needs to be apply on newly created cluster, that will install everthing needed to let user to create xr
-Create a secret on new cluster: 
```
kubectl create secret generic aws-secret -n crossplane-system --from-file=creds=../Day1/aws-credentials.txt
```
-Check on new cluster:
```
kubectl get providers
NAME                            INSTALLED   HEALTHY   PACKAGE                                                AGE
upbound-provider-aws-dynamodb   True        True      xpkg.upbound.io/upbound/provider-aws-dynamodb:v1.9.0   7m14s
upbound-provider-aws-s3         True        True      xpkg.upbound.io/upbound/provider-aws-s3:v1.9.0         7m7s
upbound-provider-family-aws     True        True      xpkg.upbound.io/upbound/provider-family-aws:v1.9.0     7m19s
```
and install providerconfig

```
kubectl apply -f ../../Day1/providerconfig.yaml
```

-From now on, user should be able to req claim/xr

```
jeet@Jeet-Desai:~/crossplane-learning/Day3/user$ kubectl apply -f NoSQL-xr.yaml 
nosql.database.example.com/my-nosql-xr created
jeet@Jeet-Desai:~/crossplane-learning/Day3/user$ kubectl get managed
NAME                                              SYNCED   READY   EXTERNAL-NAME       AGE
table.dynamodb.aws.upbound.io/my-nosql-xr-cmj5z   False            my-nosql-xr-cmj5z   5s

NAME                                         SYNCED   READY   EXTERNAL-NAME       AGE
bucket.s3.aws.upbound.io/my-nosql-xr-9wxwm   False            my-nosql-xr-9wxwm   5s
```
---

Build and push OCI packages

```
crossplane xpkg login --token="<tokenID>"
crossplane xpkg build
crossplane xpkg push xpkg.upbound.io/jeet-14/cp-test-101:v0.0.1
```

Create a new cluster with give kind-cluster.yaml and install crossplane using helm chart.
Install xp using
```
kubectl apply -f xp-configuration.yaml
```
This will install required things

---


Failed to build pkg with provider file in dir

```
crossplane xpkg build
crossplane: error: failed to build package: failed to parse package: {path:/home/jeet/crossplane-learning/Day3/provider-dydb-aws.yaml position:0}: no kind "Provider" is registered for version "pkg.crossplane.io/v1" in scheme "pkg/runtime/scheme.go:100"
```