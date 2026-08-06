# Change your SID to your own one
SID=17017615
NAME=cyberdelia_db

ALL:
	docker build -t $(SID)/$(NAME)_i .

run: params
	docker network create --subnet=203.0.113.0/24 $(SID)/cyberdelia_net
	docker run -d --net $(SID)/cyberdelia_net --ip 203.0.113.201 --hostname thegibson --privileged=true -e POSTGRES_PASSWORD="H4ckTh3Pl4n3t" -e POSTGRES_DB="gibson" -e POSTGRES_HOST_AUTH_METHOD="trust" --name $(SID)_$(NAME)_c $(SID)/$(NAME)_i
	echo "Waiting for THE GIBSON to spin up..."
	sleep 10
	docker exec -i $(SID)_$(NAME)_c psql -U postgres -d gibson < sqlconfig/cyberdelia.sql

clean:
	-docker kill $(SID)_$(NAME)_c
	-docker rm $(SID)_$(NAME)_c
	-docker network rm $(SID)/cyberdelia_net

# per-student build parameters (APP_UID / APP_PORT), derived from your SID
include ../params.mk
