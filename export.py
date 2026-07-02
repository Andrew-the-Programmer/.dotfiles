import argparse
import importlib
import subprocess

from pathlib import Path

from utils import get_cwd_path


CONFIRM_YES=None

def Link(refs: list[tuple[Path, Path]]) -> None:
    """refs=[(dst,src)]
    ln -sdfn { src } { dst }"""

    for dst, src in refs:
        Path(dst).parent.mkdir(parents=True, exist_ok=True)
        if dst.exists() and input(f"Override {dst}? y/n: ") != "y":
            continue
        subprocess.run(["ln", "-sdfn", src, dst])


def Export(package_name: str):
    module = importlib.import_module(f"{package_name}.export")
    refs = module.getRefs()
    Link(refs)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Export package configurations")
    parser.add_argument("packages", nargs="*", help="Packages to export")
    parser.add_argument("--all", action="store_true", help="Export all packages")
    parser.add_argument("--yes", action="store_true", help="Yes for confirm")

    args = parser.parse_args()

    if args.yes:
        CONFIRM_YES = True

    packages_to_export = []

    cwd = get_cwd_path(__file__)

    if args.all:
        packages_to_export = [
            item.name
            for item in cwd.iterdir()
            if item.is_dir() and (item / "export.py").exists()
        ]
    else:
        packages_to_export = args.packages

    for package_name in packages_to_export:
        print(package_name)
        Export(package_name)
