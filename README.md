This repository demonstrates GitOps-driven Infrastructure on Nutanix Kubernetes Platform (NKP). It allows developers to request object storage buckets and access keys simply by committing YAML files—no tickets or manual intervention required.

# Repository Structure
```
├── cosi/
│   ├── infrastructure/           # Platform Team managed
│   │   ├── kustomization.yaml    
│   │   ├── bucketclass.yaml      
│   │   └── bucketaccessclass.yaml    
│   │
│   └── storage/                  # Developer Self-Service folder
│       ├── bucketclaim.yaml      # Request for a new bucket instance
│       └── bucketaccess.yaml     # Request for S3 credentials/keys
```
---
The platform team defines the Flux Kustomizations in the NKP cluster. We use a Dependency to ensure the Infrastructure (BucketClasses) is ready before the Storage requests are processed.

```
apiVersion: source.toolkit.fluxcd.io/v1
kind: GitRepository
metadata:
  name: forrester-demo
  namespace: default
spec:
  interval: 1m
  url: https://github.com/nkunnath/forrester-demo
  ref:
    branch: main
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: forrester-infra
  namespace: default
spec:
  interval: 1m
  sourceRef:
    kind: GitRepository
    name: forrester-demo
  path: "./cosi/infrastructure"      
  prune: true
  wait: true                   # This is critical for dependsOn to work
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: forrester-storage
  namespace: default
spec:
  dependsOn:
    - name: forrester-infra    # This ensures infra finishes first
  interval: 1m
  sourceRef:
    kind: GitRepository
    name: forrester-demo
  path: "./cosi/storage"       
  prune: true
```
