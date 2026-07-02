from utils import get_cwd_path, get_system_config_path


def getRefs():
    cwd = get_cwd_path(__file__)
    config = get_system_config_path() / "noctalia"
    return [
        (config / filename, cwd / filename)
        for filename in ["colors.json", "settings.json", "plugins.json"]
    ]
