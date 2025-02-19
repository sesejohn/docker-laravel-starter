ifneq (,$(wildcard ./.env))
    include .env
    export
endif

.PHONY: run-prune start reload restart stop shutdown reset health logs ps system-prune

start:
	@echo "Container starting..."
	@docker-compose up -d
	@echo "Container started: $(HOST_NAME)"

reload:
	@docker-compose down
	@docker-compose up -d
	@docker exec $(HOST_NAME) bash -c "php artisan cache:clear && php artisan config:clear && \
	php artisan route:clear && php artisan view:clear && \
	php artisan config:cache && php artisan route:cache && \
	php artisan view:cache && php artisan event:cache && php artisan optimize"
	@echo "Container reloaded and Laravel cache refreshed."

restart:
	@echo "Container restarting..."
	@docker restart $(HOST_NAME)
	@echo "Container restarted: $(HOST_NAME)"

stop:
	@echo "Container stopping..."
	@docker stop $(HOST_NAME)
	@echo "Container stopped: $(HOST_NAME)"

shutdown:
	@docker-compose down
	@echo "All containers shut down."

reset:
	@docker-compose down
	@docker rmi laravel-php:11 || true
	@docker-compose up -d
	@echo "Application reset: containers stopped, image removed, and restarted."

health:
	@echo "Checking health status of container $(HOST_NAME)..."
	@docker inspect --format='{{json .State.Health.Status}}' $(HOST_NAME)

logs:
	@echo "Showing logs for container $(HOST_NAME)..."
	@docker logs -f $(HOST_NAME)

ps:
	@echo "Listing running containers..."
	@docker ps

check-prune:
	@echo "Checking Docker system disk usage..."
	@docker system df

run-prune:
	docker system prune -a --volumes -f
