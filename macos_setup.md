### Local development prerequisites:
* Java 1.8
* Conda 4.6.14
* Spark 2.4

### Install using setup.sh script.

The following instructions will run a shell script to ensure you have installed the following:

#### Note:
* If you have **already installed the same version of the application**, this shell script will skip and not overwrite your previous installation.
* If you have **already installed an earlier version of this application**, this shell script will upgrade the respective application to the latest version. E.g. Java 1.7 will be upgraded to Java 1.8, and JAVA_HOME will point to Java 1.8.

#### Run Shell Script to setup environment
 1. Clone this repository
 2. Open terminal and go to repository folder
 3. Run in terminal to make setup.sh executable

    ```
    chmod +x setup.sh
    ```
 4. Run in terminal to install all local development prerequisites

    ```
    ./setup.sh
    ```
 5. Run in terminal to update the environment profile

    ```
    source ~/.bash_profile
    ```
 6. Run in terminal to run Spark application locally. **This may take some time to run completely, please be patient. When completed, you will return to the command prompt.**

    ```
    make submit
    ```

### Manual installation to setup environment

1. Install Java 1.8
http://www.oracle.com/technetwork/java/javase/downloads/index.html
Set JAVA_HOME

2. Install Spark 2.4
   * https://archive.apache.org/dist/spark/spark-2.4.3/spark-2.4.3-bin-hadoop2.7.tgz 
   * Place spark-2.1.1-bin-hadoop2.7.tgz in folder /Users/john/spark (*Note*: change the folder according to your username in local machine)
   * Go to Spark folder to uncompress the Spark file:
     ```
     cd /Users/john/spark && tar -xvf spark-2.1.1-bin-hadoop2.7.tgz
     ```
   * Update ~/.bash_profile to include the installation path for SPARK_HOME. This path should be updated whenever you install an updated Spark version. Example:
     ```
     export SPARK_HOME=/Users/john/spark/spark-2.1.1-bin-hadoop2.7
     export PATH=$SPARK_HOME/bin:$PATH
     ```
3. Install Miniconda 4.6
    * Download appropriate version from http://repo.continuum.io/miniconda
    * Extract under /Users/john/miniconda (*Note*: change the folder according to your username in local machine)
    * Add /Users/john/miniconda/bin to PATH (Similar to Spark installation)
      export PATH=/Users/john/miniconda/bin:$PATH"

Running instructions
======================================================
### How to run on local?

Go to terminal of this repository and submit the command:
```
make submit
```

### How to run unit test ?

Go to terminal of this repository and submit the command:
```
make test
```

### Running on IDE
[TO BE ADDED]



