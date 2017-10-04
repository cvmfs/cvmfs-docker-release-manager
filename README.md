CVMFS Release Manager Container
===============================

CVMFS Release Manager Container (part of the CernVM File System)

Usage
-----

To build the container, run:

```
$ ./build.sh [NAME:TAG]
```

To use the container, the start script expects three paths, which will be bind mounted into the
container environment:

1. The config directory

    This directory is expected to contain a `repo_config.json` file with the following fields:

    * `repo_name` - the name of the CVMFS repository
    * `stratum0` - the Stratum0 URL of the repo
    * `upstream` - the upstream storage configuration string, same as in the `server.conf`
    repository configuration file
    * `key_dir` - the path of the repository key files

    See `doc/repo_config.json.example` for an example.

2. The data directory

    Any data to be published in the repo can be made available to the container in this repository.

3. A spool directory

    This directory is bind mounted into the container at `/var/spool/cvmfs`. For technical reasons,
    this directory must not be on the same partition as the container root. By mounting it form the
    host, it is also ensured that the repository cache is persisted between uses of the container.

To start the container:

```
$ ./start.sh <CONFIG_DIR> <DATA_DIR> <SPOOL_DIR> [<CONTAINER_NAME:TAG>]
```

The container runs by default in interactive mode, dropping the user into an interactive bash
shell. To use the container in non-interactive mode, create the file `<DATA_DIR>/transaction.sh`
containing the desired operations. This file will be executed instead of the interactive shell.

License and copyright
---------------------

See LICENSE in the project root.

