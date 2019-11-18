#!/usr/bin/env python3

import sys
import os

from medusa.translator import Translator
from medusa.polyfill import polyfill

def main():
    content = sys.stdin.read()
    translator = Translator()
    error, result = translator.translate(content)

    exit_code = 1 if error else 0
    print(result)

    return exit_code

def get_polyfill(filename="pypolyfill.lua"):
    """Get python lua polyfill code."""
    script_name = os.path.realpath(__file__)
    folder = os.path.dirname(script_name)
    path = os.path.join(folder, filename)

    with open(path, encoding="utf-8") as f:
        return f.read()

if __name__ == "__main__":
     sys.exit(main())
