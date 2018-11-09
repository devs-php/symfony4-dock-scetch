
composer:
	docker-compose exec php composer $(args)

console:
	docker-compose exec php ./bin/console $(args)

yarn:
	docker-compose exec php yarn $(args)

analyze:
	docker-compose exec php ./vendor/bin/phpstan analyze src --level max
	docker-compose exec php ./vendor/bin/php-cs-fixer fix -v --diff

phpunit:
	docker-compose exec php ./bin/phpunit $(args)
