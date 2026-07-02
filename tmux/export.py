from utils import get_cwd_path, get_system_config_path


def getRefs():
    cwd = get_cwd_path(__file__)
    config = get_system_config_path() / "tmux"
    return [(config / "tmux.conf", cwd / "tmux.conf")]
