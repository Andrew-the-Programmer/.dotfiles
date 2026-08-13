import argparse

from utils2 import config

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Export package configurations")
    _ = parser.add_argument("packages", nargs="*", help="Packages to export")
    _ = parser.add_argument(
        "--all", "-a", action="store_true", help="Export all packages"
    )

    args = parser.parse_args()

    config.load_all()

    for pkg in args.packages:
        print(f"Exporting: '{pkg}'")
        config.export(pkg)
