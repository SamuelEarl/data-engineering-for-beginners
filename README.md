# Install & Run Dagster

We are going to install Dagster using a virtual environment.

<br>

## Step 1: Install Anaconda3

I am going to use Anaconda with the Conda package manager to create and manage my virtual environments. You are welcome to use Pip, if you prefer.

1. Go to Anaconda's website and install Anaconda for your operating system.
2. After Anaconda is installed, then make sure that Python3 and Pip3 are on your PATH variable. In a terminal run `which python3` and then `which pip3`. Those commands should return a file path to your Anaconda installation.
3. `conda` is Anaconda's package manager. Make sure that your conda installation worked: `conda --version`. If that returns a version number, then you have installed Anaconda3 and conda correctly.

<br>

## Step 2: Create an `environment.yml` file in your project root directory

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
