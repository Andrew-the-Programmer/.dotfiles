from utils2 import config, get_cwd_path, get_system_config_path

register = config.register("tmux")


@register.links()
def tmux_links():
    cwd = get_cwd_path(__file__)
    config = get_system_config_path() / "tmux"
    return [(cwd / "tmux.conf", config / "tmux.conf")]
