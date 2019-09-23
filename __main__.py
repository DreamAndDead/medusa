#!/usr/bin/env python3

"""Entry point to the translator"""
import sys
from pythonlua.translator import Translator

def main():
    """Entry point function to the translator"""
    content = sys.stdin.read()
    translator = Translator()
    lua_code = translator.translate(content)

    print(lua_code)

    return 0

if __name__ == "__main__":
    sys.exit(main())
