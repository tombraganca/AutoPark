init:
	pip install -r requirements.txt

train:
	./setup.sh

mqtt-start:
	docker start server-eclipse-mqtt-container

mqtt-stop:
	docker stop server-eclipse-mqtt-container

mqtt-server-install:
	docker build -t eclipse-mqtt-img .
	docker stop server-eclipse-mqtt-container || true && docker rm server-eclipse-mqtt-container || true
	docker run -d --name server-eclipse-mqtt-container -p 1883:1883 eclipse-mqtt-img

start:
	/bin/python3 src/main.py

publish:
	/bin/python3 src/mqtt_mock.py

test0:
	/bin/python3 src/test.py 0

test1:
	/bin/python3 src/test.py 1

test2:
	/bin/python3 src/test.py 2