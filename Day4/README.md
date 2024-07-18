This is for check reconsiliation and drift effects with terraform vs crossplane:

-To check we'll modify resource once it is created via console and check the impact and add remarks if any

Have create two s3 bucket one with [crossplane](./managed-s3-bucket.yaml) another with [terraform](./s3-main.tf)


Now we have toggle versioning property of both the bucket and disabled the block public access:

Neither of CP or TF were able to capture drift!


### cp

```
jeet@Jeet-Desai:~/crossplane-learning/Day4$ kubectl describe bucket
Name:         cp-bucket-9wjxt
Namespace:    
Labels:       <none>
Annotations:  crossplane.io/external-create-pending: 2024-07-18T01:13:55Z
              crossplane.io/external-create-succeeded: 2024-07-18T01:13:55Z
              crossplane.io/external-name: cp-bucket-9wjxt
API Version:  s3.aws.upbound.io/v1beta2
Kind:         Bucket
Metadata:
  Creation Timestamp:  2024-07-18T01:13:54Z
  Finalizers:
    finalizer.managedresource.crossplane.io
  Generate Name:     cp-bucket-
  Generation:        2
  Resource Version:  91467
  UID:               3e2a8e55-1f4a-4cb4-9547-124ac7cd684b
Spec:
  Deletion Policy:  Delete
  For Provider:
    Region:  ap-south-1
    Tags:
      Environment:                  Dev
      Crossplane - Kind:            bucket.s3.aws.upbound.io
      Crossplane - Name:            cp-bucket-9wjxt
      Crossplane - Providerconfig:  default
  Init Provider:
  Management Policies:
    *
  Provider Config Ref:
    Name:  default
Status:
  At Provider:
    Acceleration Status:          
    Arn:                          arn:aws:s3:::cp-bucket-9wjxt
    Bucket Domain Name:           cp-bucket-9wjxt.s3.amazonaws.com
    Bucket Regional Domain Name:  cp-bucket-9wjxt.s3.ap-south-1.amazonaws.com
    Force Destroy:                false
    Grant:
      Id:  fa2e55ed56754da5a64fb090eb19221a7f08252ab24da10d8c4fe35da244741a
      Permissions:
        FULL_CONTROL
      Type:               CanonicalUser
      Uri:                
    Hosted Zone Id:       Z11RGJOFQNVJUP
    Id:                   cp-bucket-9wjxt
    Object Lock Enabled:  false
    Policy:               
    Region:               ap-south-1
    Request Payer:        BucketOwner
    Server Side Encryption Configuration:
      Rule:
        Apply Server Side Encryption By Default:
          Kms Master Key Id:  
          Sse Algorithm:      AES256
        Bucket Key Enabled:   false
    Tags:
      Environment:                  Dev
      Crossplane - Kind:            bucket.s3.aws.upbound.io
      Crossplane - Name:            cp-bucket-9wjxt
      Crossplane - Providerconfig:  default
    Tags All:
      Environment:                  Dev
      Crossplane - Kind:            bucket.s3.aws.upbound.io
      Crossplane - Name:            cp-bucket-9wjxt
      Crossplane - Providerconfig:  default
    Versioning:
      Enabled:     false
      Mfa Delete:  false
  Conditions:
    Last Transition Time:  2024-07-18T01:14:02Z
    Reason:                Available
    Status:                True
    Type:                  Ready
    Last Transition Time:  2024-07-18T01:13:56Z
    Reason:                ReconcileSuccess
    Status:                True
    Type:                  Synced
    Last Transition Time:  2024-07-18T01:13:59Z
    Reason:                Success
    Status:                True
    Type:                  LastAsyncOperation
```

### tf
```
 terraform plan
aws_s3_bucket.example: Refreshing state... [id=tf-jd-bucket]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are
needed.
```

Que:

Why none of the methods were able to capture drift?
-Maybe as these properties were never part of desired state, they don;t have track of these properties!!

As am trying to destroy resource with terraform destroy it pick current value of propety:

```
 terraform destroy
aws_s3_bucket.example: Refreshing state... [id=tf-jd-bucket]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_s3_bucket.example will be destroyed
  - resource "aws_s3_bucket" "example" {
      - arn                         = "arn:aws:s3:::tf-jd-bucket" -> null
      - bucket                      = "tf-jd-bucket" -> null
...

      - versioning {
          - enabled    = true -> null
          - mfa_delete = false -> null
        }
    }
```