.PHONY: *

install:
	curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.10.0/kind-darwin-amd64
	chmod +x ./kind
	$(MAKE) setup-cluster

setup-cluster:
	./kind create cluster --config ./kind-config/kind-config.yaml

deploy-tooling:
	kustomize build deploy | kubectl apply -f-

configure-gatekeeper:
	kubectl apply -f ./gatekeeper-config/config.yaml
	kubectl apply -f ./gatekeeper-config/rule-template.yaml
	sleep 2
	kubectl apply -f ./gatekeeper-config/constraint.yaml

clean:
	./kind delete cluster
