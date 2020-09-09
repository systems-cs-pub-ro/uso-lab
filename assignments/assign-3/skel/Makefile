# Makefile with Docker install targets
# vim: set ft=make:
SHELL=/bin/bash

IMAGE_PREFIX ?= ropubuso/
IMAGE_TAG?=latest
BRIDGE_NAME=usobr0
SUBNET=192.168.1.0/24

.PHONY: install create_containers
install: create_network create_containers
create_containers: create_carol create_ferdinand create_cantacuzino create_titulescu

install_src: IMAGE_TAG=src
install_src: install

# container specific targets
REC_ARGS= --no-print-directory "IMAGE_TAG=$(IMAGE_TAG)" 
create_carol:
	@$(MAKE) $(REC_ARGS) name=carol create_container

create_ferdinand:
	@$(MAKE) $(REC_ARGS) name=ferdinand create_container

create_cantacuzino:
	@$(MAKE) $(REC_ARGS) name=cantacuzino create_container

create_titulescu:
	@$(MAKE) $(REC_ARGS) name=titulescu create_container

.PHONY: create_carol create_ferdinand create_cantacuzino create_titulescu

install_solved: IMAGE_TAG=solved
install_solved: install
.PHONY: install_solved

clean_containers:
	@docker rm -f carol ferdinand cantacuzino titulescu
.PHONY: clean_containers

# macro target to create a named container
name=dummy
create_container:
	@if [[ -z "$$(docker container ls -a -q -f 'name=$(name)')" ]]; then \
		docker create --name $(name) --hostname=$(name) \
			--network $(BRIDGE_NAME) --stop-signal SIGRTMIN+3 \
			--privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
			$(IMAGE_PREFIX)$(name):$(IMAGE_TAG) && \
		echo "Container $(name) created."; \
	fi
.PHONY: create_container

create_network:
	@if [[ -z "$$(docker network ls -q -f 'name=$(BRIDGE_NAME)')" ]]; then\
		docker network create -d bridge --subnet="$(SUBNET)" \
			-o "com.docker.network.bridge.name"="$(BRIDGE_NAME)" \
			"$(BRIDGE_NAME)"  && \
			echo "Network $(BRIDGE_NAME) created!"; \
	fi

clean_network:
	@docker network rm "$(BRIDGE_NAME)"

self_destruct:
	# prevent accidental source code deletion
	@if [[ ! -f "Makefile.build" ]]; then \
		rm -f Makefile.install; \
	else echo "Oops, you are using the source! Not deleting anything..."; exit 1; \
	fi


