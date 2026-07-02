from pathlib import Path


def get_cwd_path(file):
    """get_cwd_path(__file__)"""
    return Path(file).parent.resolve()


def get_home_path():
    return Path.home()


def get_system_config_path():
    return Path.home() / ".config"
