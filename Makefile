IMAGE="jahrik/docker-jenkins-ansible"
TAG="latest"
STACK="jenkins"

all: build

build:
	@docker build -t ${IMAGE}:${TAG} -f Dockerfile .

pull:
	@docker pull ${IMAGE}:${TAG}

push:
	@docker push ${IMAGE}:${TAG}

deploy:
	@mkdir -p /var/jenkins
	@docker stack deploy -c docker-compose.yml ${STACK}

.PHONY: all build push deploy
