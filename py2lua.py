"""Entry point to the translator"""

import sys
import os

from pythonlua.translator import Translator
from pythonlua.polyfill import polyfill

def main():
    """Entry point function to the translator"""
    content = sys.stdin.read()
    translator = Translator()
    lua_code = translator.translate(content)

#    print(polyfill)
    
    print(lua_code)
    return 0

def get_polyfill(filename="pypolyfill.lua"):
    """Get python lua polyfill code."""
    script_name = os.path.realpath(__file__)
    folder = os.path.dirname(script_name)
    path = os.path.join(folder, filename)

    with open(path, encoding="utf-8") as f:
        return f.read()

if __name__ == "__main__":
     sys.exit(main())
