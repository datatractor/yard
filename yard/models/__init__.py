"""The files in this package are automatically generated
from the schemas repository with LinkML and should not
be edited by hand.
"""

from pydantic import validator

from .extractor import Extractor as AutoGenExtractor
from .filetype import FileType


class Extractor(AutoGenExtractor):
    """A wrapper for the automatically generated Extractor class
    that includes some additional validators.

    """

    @validator("usage")
    def check_usage_filetypes(cls, v, values):
        """Check that any filetype instructions in the usage
        are defined at the top-level, and that all supported_filetypes
        values have instructions (or that there is a catch-all).

        """

        if not v:
            return v

        supported_filetypes: set[str] = set(
            d.id for d in values.get("supported_filetypes")
        )
        usage_to_fts: dict[str, dict] = {}

        bad_fts: list[str] = []
        for instruction in v:
            if not instruction.supported_filetypes:
                for t in supported_filetypes:
                    if t not in usage_to_fts:
                        usage_to_fts[t] = instruction
            else:
                for t in instruction.supported_filetypes:
                    usage_to_fts[t] = instruction
                    if t not in supported_filetypes:
                        bad_fts.append("Bad filetype {t} found in instruction")

        for t in supported_filetypes:
            if t not in usage_to_fts:
                bad_fts.append(f"No instruction for {t}")

        if bad_fts:
            raise ValueError("Unsupported filetypes: " + "\n".join(bad_fts))

        return v


__all__ = ("Extractor", "FileType")
