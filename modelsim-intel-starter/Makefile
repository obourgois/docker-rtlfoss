# Docker for Modelsim Intel Edition

all: build

# launch the docker container creation
build: 
	@echo "Building rtlfoss:modelsim_ie image"
	@docker build -f modelsim-intel-starter.dk -t rtlfoss:modelsim_ie .

run:
	@echo "Starting Modelsim Intel Starter Docker"
	@xhost +
	docker run -it --rm --workdir /home/$(USER) \
--volume="/home/$(USER):/home/$(USER)" \
-e DISPLAY=$(DISPLAY) -v /tmp/.X11-unix/:/tmp/.X11-unix \
rtlfoss:modelsim_ie

clean:
	@echo "Cleaning up"
	@docker system prune

.PHONY: all build run clean
