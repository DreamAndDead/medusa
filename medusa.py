#!/usr/bin/env python3

import sys
import os

from medusa.translator import Translator

def main():
    content = sys.stdin.read()
    translator = Translator()
    error, result = translator.translate(content)

    exit_code = 1 if error else 0
    print(result)

    return exit_code

if __name__ == "__main__":
     sys.exit(main())
