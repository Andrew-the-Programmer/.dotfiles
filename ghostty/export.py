from utils2 import config, get_cwd_path, get_system_config_path

register = config.register("ghostty")


@register.links()
def links():
    cwd = get_cwd_path(__file__)
    config = get_system_config_path() / "ghostty"
    return [(cwd / f, config / f) for f in ["config.ghostty", "themes"]]
