# Nushell Environment Config File
#
# version = "0.84.0"

$env.EDITOR = "helix"

$env.MOZ_ENABLE_WAYLAND = 1
$env.MOZ_DBUS_REMOTE = 1
$env.GTK_CSD = 1

$env.QT_QPA_PLATFORM = "wayland"
$env.QT_QPA_PLATFORMTHEME = "qt5ct"
$env.QT_WAYLAND_DISABLE_WINDOWDECORATION = 1

$env._JAVA_AWT_WM_NONREPARENTING = 1

$env.SHELL = "/usr/bin/nu"
$env.ZEIT_DB = "$HOME/config/zeit.db"

$env.XDG_CONFIG_HOME = $"($env.HOME)/.config"
$env.XDG_CACHE_HOME = $"($env.HOME)/.cache"
$env.XDG_DATA_HOME = $"($env.HOME)/.local/share"
$env.XDG_STATE_HOME = $"($env.HOME)/.local/state"

$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
$env.NU_LIB_DIRS = [
    # ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
]

# Directories to search for plugin binaries when calling register
$env.NU_PLUGIN_DIRS = [
    # ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
$env.PATH = ($env.PATH | split row (char esep) | prepend '/home/ama/.cargo/bin')
$env.PATH = ($env.PATH | split row (char esep) | prepend '/home/ama/.local/bin')
$env.PATH = ($env.PATH | split row (char esep) | prepend '/bin')
$env.MANPAGER = "nvim +Man!"

mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu
