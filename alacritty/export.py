from utils2 import config, get_cwd_path, get_system_config_path

register = config.register("alacritty")


@register.links()
def links():
    cwd = get_cwd_path(__file__)
    config = get_system_config_path() / "alacritty"
    return [(cwd / f, config / f) for f in ["alacritty.toml", "themes"]]
