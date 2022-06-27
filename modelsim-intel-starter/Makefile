# Docker for Modelsim Intel Edition
# Note for running on MAC with XQuarz you need to use the run_mac recipe
all: build

# launch the docker container creation
build: 
	@echo "Building rtlfoss:modelsim_ie image"
	@docker build --platform linux/amd64 -f modelsim-intel-starter.dk -t rtlfoss:modelsim_ie .

run:
	@echo "Starting Modelsim ie RTL FOSS Docker"
	@xhost +
	docker run -it --rm  \
--platform linux/amd64 \
--workdir /home/$(USER) \
--env=DISPLAY=$(DISPLAY) \
--volume /tmp/.X11-unix/:/tmp/.X11-unix:rw \
--volume="/home/$(USER):/home/$(USER)" \
rtlfoss:modelsim_ie

run_mac:
	@echo "Starting Modelsim ie RTL FOSS Docker"
	@xhost +
	docker run -it --rm \
--platform linux/amd64 \
--workdir /home/$(USER) \
--env=DISPLAY=host.docker.internal:0 \
--volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
--volume="/Users/$(USER):/home/$(USER)" \
rtlfoss:modelsim_ie

clean:
	@echo "Cleaning up"
	@docker system prune

.PHONY: all build run clean
