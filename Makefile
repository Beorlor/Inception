all:
	docker-compose up -d --build

down:
	docker-compose down

re:
	docker-compose down
	docker-compose up -d --build

cleanv:
	docker-compose down -v

hugo:
	docker-compose down hugo
	docker-compose up -d --build hugo

fixv:
	docker-compose down --volumes --remove-orphans
