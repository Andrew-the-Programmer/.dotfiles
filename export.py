import argparse

from utils2 import config

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Export package configurations")
    parser.add_argument("packages", nargs="*", help="Packages to export")
    parser.add_argument("--all", "-a", action="store_true", help="Export all packages")

    args = parser.parse_args()

    config.load_all()

    for pkg in args.packages:
        config.export(pkg)
