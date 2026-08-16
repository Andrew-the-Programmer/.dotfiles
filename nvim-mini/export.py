from utils2 import config, get_cwd_path, get_system_config_path

register = config.register("nvim-mini")


@register.links()
def nvim_links():
    cwd = get_cwd_path(__file__)
    config = get_system_config_path() / "nvim"

    return [
        (cwd / s, config / s)
        for s in [
            "lua",
            "init.lua",
            "plugin",
            "spell",
            ".neoconf.json",
            "lazy-lock.json",
            "lazyvim.json",
            "stylua.toml",
        ]
    ]
