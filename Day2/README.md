Composition

We have NoSQL-xrd.yml- defines schema, NoSQL-xr.yaml- something which will/can supply by end user, composition- combining s3, dynamoDB into single composition resource.

PatchSets: allows to use patches with reuse.

Crossplane CLI:

```
jeet@Jeet-Desai:~/crossplane-learning/Day2$ crossplane beta trace NoSQL my-nosql-xr
NAME                          SYNCED   READY   STATUS
NoSQL/my-nosql-xr             True     True    Available
├─ Bucket/my-nosql-xr-qzcx8   True     True    Available
└─ Table/my-nosql-xr-pgr9c    True     True    Available
```

Que:
-Crossplane ignores any transforms or policies in a PatchSet. But I was able to use transform.
-Have modify s3 permission from console, but cp didnot detect drift.
-Tags not working on compositions?