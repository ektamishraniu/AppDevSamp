#!/usr/bin/env bash

install_spark_2.4.3()
{
    wget -O ~/Downloads/spark-2.4.3-bin-hadoop2.7.tgz https://archive.apache.org/dist/spark/spark-2.4.3/spark-2.4.3-bin-hadoop2.7.tgz
    mkdir -p ~/spark && tar -xf ~/Downloads/spark-2.4.3-bin-hadoop2.7.tgz -C ~/spark
    echo "export SPARK_HOME=${HOME}/spark/spark-2.4.3-bin-hadoop2.7" >> ~/.bash_profile
    echo "export PATH=\$SPARK_HOME/bin:\$PATH" >> ~/.bash_profile

    if [ -n "${PYTHONPATH}" ]; then
        sed -i '' 's/export PYTHONPATH.*/export PYTHONPATH=\$SPARK_HOME\/python\/:\$PYTHONPATH/g' ~/.bash_profile
    else
        echo "export PYTHONPATH=\$SPARK_HOME/python/:\$PYTHONPATH" >> ~/.bash_profile
    fi

    rm -f ~/Downloads/spark-2.4.3-bin-hadoop2.7.tgz
    source ~/.bash_profile
}

install_conda_4.6.14()
{
    echo Downloading Miniconda3-4.6.14-MacOSX-x86_64
    wget http://repo.continuum.io/miniconda/Miniconda3-4.6.14-MacOSX-x86_64.sh -O miniconda.sh
    chmod 755 miniconda.sh

    if [ -n  $1 ]; then
        ./miniconda.sh -b -p $HOME/miniconda
    else
        ./miniconda.sh -b -p -u $HOME/miniconda
    fi

    echo "export PATH=~/miniconda/bin:\$PATH" >> ~/.bash_profile
    rm ./miniconda.sh
    source ~/.bash_profile
}

if [ "$(command -v brew)" ]; then
    echo brew version "$(brew --version)"
else
    # Homebrew Script for OSX
    echo "Installing brew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    if ! [ "$(command -v brew)" ]; then
        echo Install Homebrew failed, please install Homebrew manually and running setup.sh again
        exit 1
    fi
fi

# setup brew cask
brew tap caskroom/cask

# setup Java environment
if [ -n "${JAVA_HOME}" ]; then
    _java="${JAVA_HOME}/bin/java"
else
    if [ "$(command -v java)" ]; then
        _java="java"
    else
        brew cask install java
    fi
fi

java_version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')

echo "Java version: $java_version"

if [[ "$java_version" < "1.8" ]]; then
  echo "Upgrade Java version to 1.8"
  brew tap caskroom/versions
  brew cask install java8
  sed -i '' 's/export JAVA_HOME.*/export JAVA_HOME=\$(\/usr\/libexec\/java_home -v 1.8)/g' ~/.bash_profile
  source ~/.bash_profile
fi


if [ "$(command -v wget)" ]; then
    echo wget already installed
    brew link wget
else
    brew install wget
fi

if ! [ "$(command -v wget)" ]; then
    echo please install wget manually using: brew install wget and brew link wget,  and running setup.sh again
    exit 1
fi

echo "Check for Conda"
if [ "$(command -v conda)" ]; then
    echo Conda version is:
    conda --version
    conda_version=$(conda --version | awk '{print $2}')    
    if [[ "$conda_version" < "4.6.14" ]]; then
        echo "Update Conda"
        install_conda_4.6.14 update
    else
        echo "Conda Up-to-date"
    fi
else
    echo "Conda not found, Installing.."
    install_conda_4.6.14
fi

echo "Check for Spark"
if [ "$(command -v spark-submit)" ]; then
    spark_version=$(spark-submit --version 2>&1 | grep  -m 1 "version" | awk '{print $NF}')
    echo Spark version is: $spark_version
    if [[ "$spark_version" < "2.4.3" ]]; then
        echo "Installing spark"
        install_spark_2.4.3
    else
        echo "Spark Up-to-date"
    fi
else
    echo "Spark not found , Installing.."
    install_spark_2.4.3
fi

echo "$SPARK_HOME"
echo "$PYTHONPATH"
echo "$PATH"

echo "Please make sure SPARK_HOME is set and added to PATH"
echo "Please make sure PYTHONPATH has SPARK_HOME/python"
echo "Please make sure PATH has SPARK_HOME and miniconda/bin added to it"

if [[ -z "${PYTHONPATH+set}" || -z "${SPARK_HOME+set}" ]]; then
    echo "Setup Unsuccessful , Please make sure you install Spark2.4, MiniConda4.6 and set SPARK_HOME, PYTHONPATH and PATH variables as expected"
else
    echo "Setup Successful"
fi

