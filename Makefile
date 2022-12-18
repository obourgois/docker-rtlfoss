# Docker for FOSS RTL tools
# Note for running on MAC with XQuarz you need to use the run_mac recipe
all: build

# launch the docker container creation
build: 
	@echo "Building rtlfoss:base image"
	@docker build --platform linux/amd64 -f Dockerfile -t rtlfoss:base .

run:
	@echo "Starting Base RTL FOSS Docker"
	@xhost +
	docker run -it --rm  \
--user $$(id -u):$$(id -g) \
--platform linux/amd64 \
--workdir /home/$(USER) \
--env=DISPLAY=$(DISPLAY) \
--volume /tmp/.X11-unix/:/tmp/.X11-unix:rw \
--volume="/home/$(USER):/home/$(USER)" \
rtlfoss:base

run_mac:
	@echo "Starting Base RTL FOSS Docker"
	@xhost +
	docker run -it --rm \
--user $$(id -u):$$(id -g) \
--platform linux/amd64 \
--workdir /home/$(USER) \
--env=DISPLAY=host.docker.internal:0 \
--volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
--volume="/Users/$(USER):/home/$(USER)" \
rtlfoss:base

clean:
	@echo "Cleaning up"
	@docker system prune

.PHONY: all build run clean
