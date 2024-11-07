all:
	docker-compose up -d --build

down:
	docker-compose down

re:
	docker-compose down
	docker-compose up -d --build
