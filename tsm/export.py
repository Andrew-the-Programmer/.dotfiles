from utils2 import config, get_cwd_path, get_system_config_path

register = config.register("tsm")

@register.links()
def tsm_links():
    cwd = get_cwd_path(__file__)
    config = get_system_config_path() / "tsm"
    return [(cwd / "config.toml", config)]
