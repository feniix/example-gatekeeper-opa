# OPA gatekeeper example for ingresses with duplicate hosts

## Why?

This is a demo to show how to use gatekeeper, generally speaking all modern deployments of nginx ingress come with a validation webhook prevents duplicate hosts out of the box, so this is completely unneeded.

## Install local tooling

```shell
asdf plugin-add kustomize
asdf plugin-add kubectl
asdf install
```

## Create local cluster

```shell
make install
```

## Deploy tooling

```shell
make deploy-tooling
# and wait until all pods are started by doing `kubectl get pod -A -w`
```

## Deploy gatekeeper configuration

```shell
make configure-gatekeeper
```

## Test the policy

```shell
$ kubectl apply -f samples
ingress.extensions/ingress-host-example2 created
Error from server ([unique-ingress-host] ingress host conflicts with an existing ingress <example-host.example.com>
[unique-ingress-host] ingress host conflicts with an existing ingress <example-host.example.com>): error when creating "samples/separate2-duplicate-ingress-hosts.yaml": admission webhook "validation.gatekeeper.sh" denied the request: [unique-ingress-host] ingress host conflicts with an existing ingress <example-host.example.com>
[unique-ingress-host] ingress host conflicts with an existing ingress <example-host.example.com>
```