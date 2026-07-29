from utils2 import config, get_system_config_path

register = config.register("rofi")


@register.links()
def rofi_links():
    config = get_system_config_path() / "rofi"
    return [
        (
            "config.rasi",
            config / "config.rasi",
        ),
        (
            "themes",
            config / "themes",
        ),
    ]
