# cdk8s Java CMP

This generates kubernetes manifests using cdk8s in Java language. [Read more about cdk8s Java](https://cdk8s.io/docs/latest/get-started/java/)

## Use-case

When you have kubernetes manifests written in cdk8s Java and you want to turn it into raw YAML and provide ArgoCD to manage resources.

Basically it requires 2 commands when generating raw YAML manifests

1. Import cdk8s objects defined in cdk8s configuration YAML file and compile java

```sh
cdk8s import && mvn compile
```

2. Generate manifests and print to stdout

```sh
cdk8s synth --stdout
```

## Install and Use

Register the plugin sidecar to `argocd-repo-server`

```yaml
containers:
- name: cdk8s-java
  image: ghcr.io/akuity/cdk8s-cmp-java:latest
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
      name: cdk8s-java
```
