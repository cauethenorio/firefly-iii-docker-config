.PHONY: up down build log reload reset backup restore-backup update-images

up: .app-env
	@docker-compose up -d
	@./scripts/lock-images-digests.sh
	@docker-compose logs -f

.app-env:
	@./scripts/create-app-env.sh

down:
	@docker-compose down

build:
	@docker-compose build

log:
	@docker-compose logs -f

reload: down up log

reset:
	@./scripts/reset.sh

backup:
	@./scripts/backup.sh

restore-backup:
	@BACKUP_FILE=$(file) ./scripts/restore-backup.sh

update-images: backup
	@./scripts/update-images.sh
