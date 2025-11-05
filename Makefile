# Variables
IMAGE_NAME ?= chaos-db
CONTAINER_NAME ?= chaos-db
DB_NAME ?= chaos
DB_USER ?= admin
DB_PASSWORD ?= admin
DB_PORT ?= 5432

.PHONY: help build run stop clean clean-all logs shell psql status test-connection test-db

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

build:  ## Build the Docker image
	docker build -t $(IMAGE_NAME) .

run:  ## Run the Docker container
	docker run -d \
		--name $(CONTAINER_NAME) \
		-p $(DB_PORT):5432 \
		-e POSTGRES_DB=$(DB_NAME) \
		-e POSTGRES_USER=$(DB_USER) \
		-e POSTGRES_PASSWORD=$(DB_PASSWORD) \
		-v postgres_data:/var/lib/postgresql/data \
		$(IMAGE_NAME)

stop:  ## Stop the container
	docker stop $(CONTAINER_NAME) || true

clean: stop  ## Stop and remove container and volumes
	docker rm $(CONTAINER_NAME) || true
	docker volume rm postgres_data || true

clean-all: clean  ## Remove container, volumes and image
	docker rmi $(IMAGE_NAME) || true

logs:  ## Show container logs
	docker logs -f $(CONTAINER_NAME)

shell:  ## Access container shell
	docker exec -it $(CONTAINER_NAME) /bin/bash

psql:  ## Connect to PostgreSQL with psql
	docker exec -it $(CONTAINER_NAME) psql -U $(DB_USER) -d $(DB_NAME)

status:  ## Check container status
	@docker ps -a | grep $(CONTAINER_NAME) || echo "Container $(CONTAINER_NAME) not found"

test-connection:  ## Test PostgreSQL connection
	@echo "Testing PostgreSQL connection..."
	@docker exec $(CONTAINER_NAME) pg_isready -U $(DB_USER)

test-db:  ## Test database access
	@echo "Testing database access..."
	@docker exec $(CONTAINER_NAME) psql -U $(DB_USER) -d $(DB_NAME) -c "SELECT version();"