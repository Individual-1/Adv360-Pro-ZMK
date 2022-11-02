TIMESTAMP := $(shell date -u +"%Y%m%d%H%M%S")
DOCKER := "$(shell { command -v podman || command -v docker; })"
PWD := $(shell pwd)

.PHONY: clean setup

all: setup build

build: firmware/$$(TIMESTAMP)-left.uf2 firmware/$$(TIMESTAMP)-right.uf2

clean:
	rm -f firmware/*.uf2

firmware/%-left.uf2 firmware/%-right.uf2: config/adv360.keymap
	$(DOCKER) compose run --env TIMESTAMP=$(TIMESTAMP) zmk

setup: Dockerfile bin/build.sh config/west.yml
	$(DOCKER) compose build zmk
