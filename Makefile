init:
	docker compose -f docker-compose.yml up --build -d

run-mobile:
	cd ./mobile && flutter run

run-dev-api:
	cd ./server && npm run dev

run-dev-python:
	cd ./&& python3 main.py