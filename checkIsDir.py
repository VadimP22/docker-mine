import os
import sys


def main():
    directory = ""
    try:
        directory = sys.argv[1]
    except:
        print("checkIsDir.py: fatal error: not enought arguments")
        sys.exit(1)


    if os.path.isdir(directory):
        sys.exit(0)
    else:
        sys.exit(1)


if __name__ == "__main__":
    main()