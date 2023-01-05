local notify = require("notify")
notify.setup(
    {
        stages = "fade_in_slide_out",
        max_width = 50,
        render = "minimal",
        background_colour = "#000000",
        icons = {
            ERROR = "",
            WARN = "",
            INFO = "",
            DEBUG = "",
            TRACE = "✎"
        }
    }
)
vim.notify = notify;
