# pylint: disable=C0111
from qutebrowser.config.configfiles import ConfigAPI # noqa: F401
from qutebrowser.config.config import ConfigContainer # noqa: F401
config: ConfigAPI = config #noqa F821 pylint: disable=E0602,C0103
c: ConfigContainer = c #noqa F821 pylint: disable=E0602,C0103

config.load_autoconfig(False)

c.aliases = {
        "q": "close",
        "qa": "quit",
        "w": "save-session",
        "wqa": "quit --save",
        "pass": 'spawn --userscript qute-pass -M gopass -U secret -u "login: (.+)"',
}

config.set("colors.webpage.preferred_color_scheme", "dark")
# config.set("colors.webpage.darkmode.enabled", True)

# config.set("auto_save.session", True)
c.auto_save.session = True

# config.set("downloads.position", "bottom")
c.downloads.position = "bottom"

config.bind("<Ctrl-n>", "completion-item-focus next", mode="command")
config.bind("<Ctrl-p>", "completion-item-focus prev", mode="command")
config.bind("<Ctrl-p>", "completion-item-focus prev", mode="command")

c.editor.command = ["kitty", "-e", "nvim", "{}", "+call cursor({line},{column0})"]

c.confirm_quit = ["downloads"]

c.spellcheck.languages = ["en-US"]
# c.scrolling.smooth = True

c.fileselect.handler = "external"
c.fileselect.folder.command = ["kitty", "-e", "ranger", "--choosedir={}"]
c.fileselect.multiple_files.command = ["kitty", "-e", "ranger", "--choosefiles={}"]
c.fileselect.single_file.command = ["kitty", "-e", "ranger", "--choosefile={}"]

c.content.blocking.method = "both"
c.content.blocking.adblock.lists = [
        "https://easylist.to/easylist/easylist.txt",
        "https://easylist.to/easylist/easyprivacy.txt",
        "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
        "https://easylist-downloads.adblockplus.org/antiadblockfilters.txt",
        "https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt",
]

c.downloads.location.directory = "~/downloads"

c.tabs.position = "left"
c.tabs.width = 200

c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com?q={}",
    "rdoc": "https://docs.rs/releases/search?query={}",
    "rlib": "https://lib.rs/search?q={}",
    "yt": "https://www.youtube.com/results?search_query={}"
}

c.content.autoplay = False
c.content.default_encoding = "utf-8"

c.content.headers.user_agent = "Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101 Firefox/68.0"

c.content.cookies.accept = "no-3rdparty"
