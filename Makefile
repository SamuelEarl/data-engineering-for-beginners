# ---------------------
# NiFi
# ---------------------
nifi-start:
	docker compose -f docker-compose.nifi.yml up
	# pwd; cd ~/nifi-1.19.1; pwd; bin/nifi.sh start

# nifi-status:
# 	pwd; cd ~/nifi-1.19.1; pwd; sudo bin/nifi.sh status

# nifi-stop:
# 	pwd; cd ~/nifi-1.19.1; pwd; bin/nifi.sh stop

nifi-bash:
	docker container exec -it nifi bash


# ---------------------
# Airflow
# ---------------------
airflow-init:
	docker compose -f docker-compose.airflow.yml up airflow-init

airflow-start:
	docker compose -f docker-compose.airflow.yml up

airflow-stop:
	docker compose -f docker-compose.airflow.yml down


# ---------------------
# Elasticsearch
# ---------------------
elastic-start:
	docker compose -f docker-compose.elastic.yml up

elastic-stop:
	docker compose -f docker-compose.elastic.yml down

elastic-delete:
	docker compose -f docker-compose.elastic.yml down -v


# ---------------------
# Postgres & pgAdmin
# ---------------------
postgres-start:
	docker compose -f docker-compose.postgres.yml up

postgres-logs:
	docker logs -f local_pgdb
