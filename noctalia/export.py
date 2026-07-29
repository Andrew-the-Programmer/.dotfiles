from utils2 import config, get_cwd_path, get_system_config_path

register = config.register("noctalia")


@register.links()
def links():
    cwd = get_cwd_path(__file__)
    config = get_system_config_path() / "noctalia"
    return [
        (cwd / filename, config / filename)
        for filename in ["colors.json", "settings.json", "plugins.json"]
    ]
