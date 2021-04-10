# OPA gatekeeper example for ingresses with duplicate hosts

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
 kubectl apply -f samples/duplicate-ingress-hosts.yaml
ingress.networking.k8s.io/ingress-host-example2 created
Error from server (BadRequest): error when creating "samples/duplicate-ingress-hosts.yaml": admission webhook "validate.nginx.ingress.kubernetes.io" denied the request: host "example-host.example.com" and path "/" is already defined in ingress default/ingress-host-example2
```