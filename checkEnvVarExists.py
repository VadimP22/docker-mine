import os
import sys


def main():
    environ = ""
    try:
        environ = sys.argv[1]
    except:
        print("checkEnvVarExists.py: fatal error: not enought arguments")
        sys.exit(1)

    try:
        os.environ[environ]
    except:
        sys.exit(1)

    sys.exit(0)

if __name__ == "__main__":
    main()