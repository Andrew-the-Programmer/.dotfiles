from utils import get_cwd_path, get_system_config_path


def getRefs():
    cwd = get_cwd_path(__file__)
    config = get_system_config_path() / "nvim"

    return [
        *[
            (config / s, cwd / s)
            for s in [
                "lua",
                "init.lua",
            ]
            + [
                "plugin",
                "spell",
                ".neoconf.json",
                "lazy-lock.json",
                "lazyvim.json",
                "stylua.toml",
            ]
        ],
    ]
