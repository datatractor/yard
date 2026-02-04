# Developer instructions

These instructions are for those wishing to contribute to the development of the Datatractor yard registry itself.

## Development setup

Clone repository with submodules and install deps in a fresh Python virtualenv:

```
git clone git@github.com:datatractor/yard --recurse-submodules
pip install -r requirements.txt
```

Use `invoke` and the tasks in `tasks.py` to generate pydantic models for all
schemas defined in the schema repo:

```
invoke regenerate-models
```

From the repository root directory, launch the server with uvicorn:

```
uvicorn yard.app:app
```

then navigate to http://localhost:5000 to test.

## Deployment

The registry app can be easily deployed via the given [Dockerfile](./Dockerfile).
After cloning the repository (with submodules, following the instructions above), the image can be built for a given schema version by running

```shell
docker build . -t datatractor-yard
```

and then launched with

```shell
docker run -p 8080 --env PORT=8080 datatractor-yard
```

or equivalent command.
