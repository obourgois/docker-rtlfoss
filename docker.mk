# -----------------------------------------------------------------------------
# Copyright (c) 2023 All rights reserved
# -----------------------------------------------------------------------------
# Description :
#
#   This makefile allows to build Dockerfile in the current directory. It also
#   allows to modify the image to change the docker RUNNER user to map to 
#   host USER's UID and GID.  Then the container can safely be run non-root as 
#   the local USER and the RUNNER's $HOME volume in the docker maps to the 
#   USER's $HOME volume on the host
# -----------------------------------------------------------------------------

DKIMAGE = $(DKNAME):$(DKTAG)
UID = $(shell id -u)
GID = $(shell id -g)

# dockerfile template for modifying the runner to be $(USER)
define USERMOD_DK =
FROM $(DKIMAGE)

RUN \
    groupmod -g $(GID) $${RUNNER} && \
    usermod -u $(UID) $${RUNNER}

USER $${RUNNER}

WORKDIR /home/$(USER)
endef

USERIMAGE_CREATE = docker build -f mapmyuser.dk -t $(DKIMAGE)_$(USER) .
USERIMAGE_EXISTS = docker images | grep -E '$(DKNAME).*$(DKTAG)_$(USER)'
USERIMAGE_REMOVE = docker image rm $(DKIMAGE)_$(USER)

all: run

# Build the docker image
build: 
	@echo "Building $(DKIMAGE) image"
	@docker build \
--platform linux/amd64 \
--build-arg RUNNER_NAME=$(RUNNER) \
-f $(DOCKERFILE) -t $(DKIMAGE) .

# build a slightly modified image for user
mapuser:
	@$(file > mapmyuser.dk,$(USERMOD_DK))
	@if ! $(USERIMAGE_EXISTS); then $(USERIMAGE_CREATE); fi
	@rm mapmyuser.dk

# remove the modified image for user
unmapuser:
	@if $(USERIMAGE_EXISTS); then $(USERIMAGE_REMOVE); fi

# run the image as user with home directory mapped
run: mapuser
	@echo "Starting $(DKIMAGE) image"
	@xhost +
	docker run -it --rm \
--platform linux/amd64 \
--env=DISPLAY=$(DISPLAY) \
--volume /tmp/.X11-unix/:/tmp/.X11-unix:rw \
--volume="/home/$(USER):/home/$(USER)" \
$(DKIMAGE)_$(USER)

clean: unmapuser
	@echo "Cleaning up"
	@docker system prune
	@rm -f mapmyuser.dk

.PHONY: all run build mapuser unmapuser clean
