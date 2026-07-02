from utils import get_cwd_path, get_system_config_path, get_home_path


def getRefs():
    cwd = get_cwd_path(__file__)
    config = get_system_config_path() / "niri"
    return [
        (config / "config.kdl", cwd / "config.kdl"),
        (
            get_home_path() / ".local/share/omarchy/bin/omarchy-menu-custom-niri",
            cwd / "omarchy-menu-custom-niri",
        ),
    ]
