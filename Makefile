#!make

DOCKER?=docker
DOCKER_BUILD_FLAGS?=
DOCKER_REGISTRY?=docker.io
DOCKER_TAG?=1.1.2

define HELP_MENU
    Usage: make [<env>] <target> [<target> ...]

    Main targets:
        all (default)   call the default target(s)
        build           build the Docker image
        clean           remove all default artifacts
        help            show this help
        save            save the Docker image to an archive

    Refer to the documentation for use cases and examples.
endef

.PHONY: all build clean help save

all: clean

build:
ifndef DOCKER
    $(error Docker (https://docs.docker.com/install/) is required. Please install it first)
endif
    $(DOCKER) image build \
        --rm \
        --tag $(DOCKER_REGISTRY)/wagga40/zircolite:$(DOCKER_TAG) \
        $(DOCKER_BUILD_FLAGS) \
        .

help:
    $(info $(HELP_MENU))

clean:
    rm -rf "detected_events.json"
    rm -rf ./tmp-*
    rm -f zircolite.log
    rm -f fields.json
    rm -f zircolite.tar

save:
ifndef DOCKER
    $(error Docker (https://docs.docker.com/install/) is required. Please install it first)
endif
    $(DOCKER) image save \
        --output zircolite.tar \
        $(DOCKER_REGISTRY)/wagga40/zircolite:$(DOCKER_TAG)
