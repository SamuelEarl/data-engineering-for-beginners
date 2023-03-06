# Install & Run Dagster

Since this is just for educational purposes, I am going to keep this simple by using a virtual environment (instead of a Docker container) for Dagster.

<br>

## Step 1: Install Anaconda3

I am going to use Anaconda with the Conda package manager to create and manage my virtual environments. You are welcome to use Pip, if you prefer.

1. Go to Anaconda's website and install Anaconda for your operating system.
2. After Anaconda is installed, then make sure that Python3 and Pip3 are on your PATH variable. In a terminal run `which python3` and then `which pip3`. Those commands should return a file path to your Anaconda installation.
3. `conda` is Anaconda's package manager. Make sure that your conda installation worked: `conda --version`. If that returns a version number, then you have installed Anaconda3 and conda correctly.

<br>

### Step 2: Create an `environment.yml` file in your project root directory

You can create and activate virtual environments with conda. (See [Managing environments](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html).)

First, create an `environment.yml` file in your project root directory. Here is an example of an `environment.yml` file:

```yml
name: dagster
channels:
  - conda
  - conda-forge
dependencies:
  - python=3.9.5
  - pip
  - pip:
    - pandas==1.2.0
    - dagster
    - dagit
    - requests
```

<br>

## Step 3: Create your virtual environment

In a terminal window `cd` into your project directory and run

```
conda env create -f environment.yml
```

This will install the virtual environment that is specified in your `environment.yml` file. In case you see a prompt asking you to confirm before proceeding, type `y` and press Enter to continue creating the environment. Depending on your system configuration, it may take a while for the process to complete.

<br>

## Step 4: Verify that the new virtual environment was installed correctly

In your terminal type:

```
conda env list
```

You should see the name `dagster` in that list, which is the `name` specified in your `environment.yml` file.

<br>

## Step 5: Activate your virtual environment

```
conda activate dagster
```

Once your virtual environment has been activated, your command prompt should be prefixed with the name of your virtual environment. For example:

```
(dagster) ~/code/data-engineering/...
```

<br>

## How to deactivate a virtual environment

When you are done working on a particular project you can deactivate the virtual environment with:

```
conda deactivate
```

See [Deactivating an environment](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#deactivating-an-environment)

<br>

## How to delete a virtual environment

First make sure your environment is deactivated. Then run this command:

```
conda env remove --name name-of-environment
```

You can verify that your virtual environment has been deleted by running

```
conda env list
```

<br>

---

# Install & Run Postgres & pgAdmin

Tutorial: [Run PostgreSQL and pgAdmin in docker for local development using docker compose](https://belowthemalt.com/2021/06/09/run-postgresql-and-pgadmin-in-docker-for-local-development-using-docker-compose/). See also [Running Postgres and pgAdmin with Docker Compose](https://www.pintonista.com/running-postgres-and-pgadmin-with-docker-compose/).

Start the containers: `make postgres-start`

View the logs: While the Postgres container is running, open another terminal window and type `make postgres-logs`.

## pgAdmin

Open a browser and go to http://localhost:5050/. Login with email address `sam@example.com` and password `admin`.

### Create a new server

After you are logged in, click the "Add New Server" icon.

In the dialog that opens, under the "General" tab give your database a name. I am using `DockerPostgres`

Under the "Connection" tab:

* Hostname/address: This is the name of the container where the Postgres database is running: `local_pgdb`
* Port: This is the port that is exposed in the host (the first port number under the `ports` variable in your Docker Compose file): `5432`
* Maintenance database: Keep this as the default value that is already populated: `postgres`
* Username: This is the `POSTGRES_USER` value: `user`
* Password: This is the `POSTGRES_PASSWORD` value: `admin`
* Save password? You can turn this on if you want.

Click the "Save" button.

### Connect to an existing server

1. In the left panel, click the arrow to the left of the "Servers" option to expand it.
2. Click on the arrow to the left of your database's name. You should see a "Connect to Server" dialog appear.
    1. If that dialog does not appear, then right-click on your database's name and select "Connect Server".
3. Enter the password for the database user (the `POSTGRES_PASSWORD` value): `admin`
4. You can select the checkbox for "Save Password".
5. Click "OK".

---

# NiFi

Follow these installation instructions: [Running NiFi in a Docker Container](https://nathanlabadie.com/running-nifi-in-a-docker-container/). I modified those instructions a bit.

After running `make nifi-start`, Docker will start the NiFi container. It will take a minute to be ready, but when it is ready open your web browser and go to https://localhost:8443/nifi/login. You will probably see a security alert, but since this is running on your local computer you can ignore that alert and continue.

---

# Airflow

Follow these installation instructions: [Running Airflow in Docker](https://airflow.apache.org/docs/apache-airflow/stable/howto/docker-compose/index.html).

## Initialize the database
See https://airflow.apache.org/docs/apache-airflow/stable/howto/docker-compose/index.html#initialize-the-database.

On all operating systems, you need to run database migrations and create the first user account. To do this, run.

```
make airflow-init
```

After initialization is complete, you should see a message like this:

```
airflow-init_1       | Upgrades done
airflow-init_1       | Admin user airflow created
airflow-init_1       | 2.5.1
start_airflow-init_1 exited with code 0
```

The account created has the login `airflow` and the password `airflow`.

## Running Airflow

Run `make airflow-start`. After Airflow has started, open a browser and navigate to http://localhost:8080.

**Troubleshooting**: I got an error saying that it couldn't connect to the network (or something like that). I stopped all the Docker containers, then removed all the containers (`docker container prune`), and then removed all the Docker images (`docker image prune -a`). Then I ran `make airflow-init` then `make airflow-start` and everything worked.

---

# Elasticsearch

Follow these installation instructions: [Start a multi-node cluster with Docker Compose](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#docker-compose-file).

Run `make elastic-start`. When the deployment has started, open a browser and navigate to http://localhost:5601 to access Kibana. Login with user `elastic` and the password that you set for `ELASTIC_PASSWORD` in the `.env` file. (Continue to the heading "Where to Start" below.)

Run `make elastic-delete` to stop the cluster and delete the network, containers, and volumes.


## Troubleshooting

When I try to run the Elasticsearch containers with `docker compose`, I get the following error:

```
ERROR: [1] bootstrap checks failed. You must address the points described in the following [1] lines before starting Elasticsearch.
<container-name> exited with code 78
```

The following post has a solution for that error: https://stackoverflow.com/a/56982026. Note that that is a temporary solution and it will be reset after rebooting your computer, which is good for learning purposes.


## Where to Start

1. After logging in, you can click "Explore on my own".
2. On the next screen, find the link for "Try sample data" and click it. 
3. Click the little link "Other sample data sets".
4. Under the "Sample eCommerce orders" data set, click "Add data".
5. Click the menu icon and start exploring.
