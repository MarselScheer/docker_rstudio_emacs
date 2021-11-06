IMAGE_NAME := rstudio_emacs_ng
IMAGE_VERSION := v1

start: image
	sudo docker run --rm -d -p 8787:8787 -e DISABLE_AUTH=true \
	  -v ~/docker_fs:/tmp/hostfs \
	  -v /tmp/.X11-unix:/tmp/.X11-unix \
	  $(IMAGE_NAME):$(IMAGE_VERSION)

start-with-sshX: image
	sudo docker run --rm -d -p 8787:8787 -e DISABLE_AUTH=true \
	  --net=host \
	  -e DISPLAY \
	  -v ~/.Xauthority:$$HOME/.Xauthority:rw \
	  -v ~/docker_fs:/tmp/hostfs \
	  $(IMAGE_NAME):$(IMAGE_VERSION)

image:
	sudo docker build -t $(IMAGE_NAME):$(IMAGE_VERSION) .

help:
	@echo start: runs the image
	@echo start-with-sshX: runs the image that allows the GUI
	@echo                  also to be forwarded via an ssh connection
	@echo image: builds the image
