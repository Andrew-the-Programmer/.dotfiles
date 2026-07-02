from utils import get_system_config_path, get_cwd_path


def getRefs():
    cwd = get_cwd_path(__file__)
    config = get_system_config_path() / "rofi"
    return [
        (
            config / "config.rasi",
            cwd / "config.rasi",
        ),
        (
            config / "themes",
            cwd / "themes",
        ),
    ]
