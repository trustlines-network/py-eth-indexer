|Build Status| |Code style: black|

eth-index
=========

eth-index is an indexer for events on the ethereum blockchain. It
imports events into a postgresql database. It's a companion to the
trustlines project relay server component.

Installation
------------

Before trying to install py-eth-index, make sure you have the postgresql
development header files and library installed. On debian based systems
this can be done by running:

::

    apt install libpq-dev

eth-index uses python 3.6 or up. Please make sure you have the required
version installed.

Please checkout the source code from github, cd into the checked out
repo and run the folllowing pip command with a fresh virtualenv:

::

    pip install -c constraints.txt  .

Development
-----------

A complete development environment can be installed with:

::

    pip install -c constraints.txt -r requirements.txt
    pip install -c constraints.txt -e .

This installs black, flake8, mypy and tox among other things.

black
~~~~~
The source code is formatted with `black <https://github.com/ambv/black>`__. If
you choose not to use the pre-commit hook, you should be able to format the
source code with ``black setup.py ethindex``.

flake8
~~~~~~
We use flake8 to check for errors. Run ``flake8 ethindex`` to check for errors.

mypy
~~~~
mypy is used to check for type errors. Run ``mypy --ignore-missing-imports
ethindex`` to check manually.

tox
~~~
Running ``tox`` will run black, flake8, mypy and pytest locally.

Since we also do run some tests for postgres, the postgres database server must
be installed on the local machine. It doesn't have to be started though, since
the tests do start postgres with a temporary data directory.

On a debian based system ``apt install postgresql`` will install the postgresql
database.

pre-commit
~~~~~~~~~~

The repository comes with a configuration file for
`pre-commit <https://pre-commit.com/>`__. We recommend using pipsi for
installation of pre-commit. After installation of pre-commit, the git
commit hooks can be activated with ``pre-commit install`` inside the
py-eth-index repository.

Initializing the database
-------------------------

Please setup a working postgres environment, i.e. set the PG\*
environment variables and configure ~/.pgpass.

Then run

::

    psql -f create-table.sql

to create the database tables.

ethindex
--------

ethindex is a command line program that is being used to run the actual
syncing process. It also uses the PG\* variables in order to determine
the postgres server to connect to.

ethindex importabi
~~~~~~~~~~~~~~~~~~

Before importing events into the postgres database, the ABIs must be
known.

``ethindex importabi`` can be used to import ABIs into the postgres
database. By default it reads two json files ``addresses.json`` and
``contracts.json`` from the current directory and adds them to the abis
table. These files are the exact files that the relay server also reads.
Their location can be specified via the ``--addresses`` and
``-contracts`` command line arguments.

Usgae:

::

    Usage: ethindex importabi [OPTIONS]

    Options:
      --addresses TEXT
      --contracts TEXT
      --help            Show this message and exit.

ethindex runsync
~~~~~~~~~~~~~~~~

``ethindex runsync`` will start the actual synchronization process. On
the first start it will read all of the abis and create one entry in the
sync table containing all contract addresses. It then imports all of the
events into the postgres table ``events``.

Usage

::

    Usage: ethindex runsync [OPTIONS]

    Options:
      --jsonrpc TEXT      jsonrpc URL to use
      --waittime INTEGER  time to sleep in milliseconds waiting for a new block
      --help              Show this message and exit.

Status and Limitations
----------------------

- ethindex is alpha software.
- ethindex currently does not handle chain reorgs
- there currently is no way to add more contracts to index

Change log
----------

See `CHANGELOG <https://github.com/trustlines-network/py-eth-index/blob/develop/CHANGELOG.rst>`_.


.. |Build Status| image:: https://travis-ci.org/trustlines-network/py-eth-index.svg?branch=develop
   :target: https://travis-ci.org/trustlines-network/py-eth-index
.. |Code style: black| image:: https://img.shields.io/badge/code%20style-black-000000.svg
   :target: https://github.com/ambv/black
