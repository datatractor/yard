from importlib.metadata import version

__version__ = version("datatractor-yard")
__api_version__ = ".".join(__version__.split(".")[0:2])
