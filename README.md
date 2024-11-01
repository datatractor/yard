<div align="center" style="padding-bottom: 1em;">
<img width="100px" align="center" src="https://avatars.githubusercontent.com/u/166528759">
</div>

# <div align="center">Datatractor Yard: Metadata Extractor Registry</div>

<div align="center">


[![Documentation](https://badgen.net/badge/docs/yard.datatractor.org/blue?icon=firefox)](https://yard.datatractor.org)
![Github status](https://badgen.net/github/checks/datatractor/yard/?icon=github)

</div>

A place to develop and discuss the Datatractor Yard (formerly the MaRDA Extractors WG registry).
The idea is to collect various file formats used in materials science and chemistry, describe them with metadata, and provide links to software projects that can parse them.

By providing this data in a web API, it hoped that users can discover new extractors more easily and metadata standards can be developed for the output of extractors to enable schemas to proliferate throughout the field.

The state of the `main` branch is deployed to https://yard.datatractor.org/, with API docs (and built-in client) accessible at https://yard.datatractor.org/redoc.

For more information, see the preprint:

> **Datatractor: Metadata, automation, and registries for extractor interoperability in the chemical and materials sciences**  
> Matthew L. Evans, Gian-Marco Rignanese, David Elbert & Peter Kraus  
> [arXiv:2410.18839](https://arxiv.org/abs/2410.18839) (2024)


## Contributing

You are welcome to contribute file type and extractor entries to this registry, by opening a pull request. Please see the [contributing guidelines](./CONTRIBUTING.md) for detailed steps. After submitting a pull request, this data will be validated and added to the deployed database once it is merged.

## Development

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

## Registry Maintainers

- Matthew Evans, [@ml-evs](https://github.com/ml-evs)
- Peter Kraus, [@PeterKraus](https://github.com/PeterKraus)
