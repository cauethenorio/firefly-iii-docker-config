.PHONY: up down build log reload

up: .env
	@docker-compose up -d
	@docker-compose exec db bash /scripts/wait-for-postgres.sh

	@docker-compose exec app php artisan migrate --seed
	@docker-compose exec app php artisan firefly:upgrade-database
	@docker-compose exec app php artisan firefly:verify
	@docker-compose exec app php artisan cache:clear

.env:
	@./scripts/create-env.sh

down:
	@docker-compose down

build:
	@docker-compose build

log:
	@docker-compose logs -f

reload: down up log