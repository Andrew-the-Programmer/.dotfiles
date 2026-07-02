from utils import get_cwd_path, get_system_config_path, get_home_path


def getRefs():
    cwd = get_cwd_path(__file__)
    config = get_system_config_path() / "zsh"

    return [
        (get_home_path() / ".zshenv", cwd / "zshenv"),
        (config / ".zshrc", cwd / "zshrc"),
        *[
            (config / s, cwd / s)
            for s in [
                "source",
                "plugins-config",
                "p10k-configs",
                "plugin-functions.sh",
                "zshrc.sh",
            ]
        ],
    ]
