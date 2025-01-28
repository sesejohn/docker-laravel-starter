ifneq (,$(wildcard ./.env))
    include .env
    export
endif

.PHONY: start reload restart stop shutdown reset health logs ps system-prune

start: docker-start
	@echo "Container starting... Done."

reload: docker-down docker-start docker-recache
	@echo "Container reloaded and Laravel cache refreshed."

restart:
	@echo "Restarting container $(HOST_NAME)..."
	@docker restart $(HOST_NAME)
	@echo "Container restarted."

stop:
	@echo "Stopping container $(HOST_NAME)..."
	@docker stop $(HOST_NAME)
	@echo "Container stopped."

shutdown: docker-down
	@echo "All containers shut down."

reset: docker-down docker-image-remove docker-start
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

system-prune:
	@echo "Checking Docker system disk usage..."
	@docker system df

docker-start:
	@docker-compose up -d

docker-down:
	@docker-compose down

docker-image-remove:
	@docker rmi laravel-php:11 || true

docker-recache:
	@echo "Refreshing Laravel cache..."
	@docker exec $(HOST_NAME) bash -c "php artisan cache:clear && php artisan config:clear && \
	php artisan route:clear && php artisan view:clear && \
	php artisan config:cache && php artisan route:cache && \
	php artisan view:cache && php artisan event:cache && php artisan optimize"
	@echo "Laravel cache refreshed."
