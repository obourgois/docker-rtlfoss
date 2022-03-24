# Docker for FOSS RTL tools

all: build

# launch the docker container creation
build: 
	@echo "Building rtlfoss:base image"
	@docker build -f rtlfoss.dk -t rtlfoss:base .

run:
	@echo "Starting Base RTL FOSS Docker"
	@xhost +
	docker run -it --rm \
--volume="/home/$$USER:/home/$$USER" \
-e DISPLAY=$(DISPLAY) -v /tmp/.X11-unix/:/tmp/.X11-unix \
rtlfoss:base

clean:
	@echo "Cleaning up"
	@docker system prune

.PHONY: all build run clean
