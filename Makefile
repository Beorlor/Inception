all:
	docker-compose up -d --build

down:
	docker-compose down

re:
	docker-compose down
	docker-compose up -d --build

cleanv:
	docker-compose down -v

n:
	docker-compose down nginx
	docker-compose up -d --build nginx
