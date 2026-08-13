import subprocess

from utils2 import config, get_cwd_path, get_system_config_path

register = config.register("tmux")


@register.links()
def tmux_links():
    cwd = get_cwd_path(__file__)
    config = get_system_config_path() / "tmux"
    _ = subprocess.run(
        [
            "git",
            "clone",
            "https://github.com/tmux-plugins/tpm",
            config / "plugins/tpm",
        ]
    )
    return [(cwd / "tmux.conf", config / "tmux.conf")]
