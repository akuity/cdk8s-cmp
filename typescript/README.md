# cdk8s Typescript CMP

This generates kubernetes manifests using cdk8s in Typescript language. [Read more about cdk8s Typescript](https://cdk8s.io/docs/latest/get-started/typescript/)

## Use-case

When you have kubernetes manifests written in cdk8s Typescript and you want to turn it into raw YAML and provide ArgoCD to manage resources.

Basically it requires 2 commands when generating raw YAML manifests

1. Install dependencies

```sh
npm install
```

2. Generate manifests and print to stdout

```sh
cdk8s synth --stdout
```

## Install and Use

Register the plugin sidecar to `argocd-repo-server`

```yaml
containers:
- name: cdk8s-typescript
  image: ghcr.io/akuity/cdk8s-cmp-typescript:latest
  ....
```

Apply [this plugin.yaml](./plugin.yaml) configuration. You can modify depending on your use-case (ie. for example injecting static or dynamic parameters).

Use the plugin when you create an application.

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: guestbook
spec:
  source:
    plugin:
      name: cdk8s-typescript
```
