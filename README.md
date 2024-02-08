# cdk8s Config Management Plugins for ArgoCD

This repository contains individual and all-in-one Docker images for [cdk8s](https://cdk8s.io/) designed specifically for ArgoCD [CMP](https://argo-cd.readthedocs.io/en/stable/operator-manual/config-management-plugins/).

### Available Images

1. cdk8s Typescript
2. cdk8s Python
3. cdk8s Golang 
4. cdk8s Java
5. cdk8s with all of the above languages support (Coming Soon)

Read more in README in each individual folder.

### Release process

- Tags pushed in format of `cdk8s-cmp-<language>/v<major>.<minor>` will trigger release workflow for relevant package. Make sure to update the `CHANGELOG.md`

- Or you can run this command to simplify release.

```sh
make bump-version
```
