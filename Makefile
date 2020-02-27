export PYTHONPATH := $(SPARK_HOME)/python/:$(PYTHONPATH)

help:
	@echo "clean - remove all build, test, coverage and Python artifacts"
	@echo "clean-pyc - remove Python file artifacts"
	@echo "test - run tests quickly with the default Python"
	@echo "build - package"

all: default

default: clean test build

clean: clean-build clean-pyc

clean-build:
	rm -fr dist/

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

test: update-env
	source activate my-second-test-app-em  && nose2

submit: build-libs update-env
	source activate my-second-test-app-em && spark-submit --master local[1] --archives dist/env.zip --py-files dist/app.egg dist/app.py -env dev 

update-env:
	conda env update -f=environment.yml

build: clean
	mkdir ./dist
	cd ./src && zip  -x "*tests*" -x "app.py"  -r ../dist/app.egg .
	cp ./src/app.py ./dist

build-libs: clean
	mkdir ./dist
	cd ./src && zip  -x "*tests*" -x "app.py"  -r ../dist/app.egg .
	cp ./src/app.py ./dist
	chmod 755 ./zipenv.sh
	./zipenv.sh $(CURDIR)/dist
	cd ./dist && zip -r my-second-test-app-em.zip app.py app.egg env.zip
