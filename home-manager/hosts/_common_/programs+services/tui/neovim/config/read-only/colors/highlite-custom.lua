local Highlite = require("highlite") --- @type Highlite

local palette, terminal_palette = Highlite.palette("highlite")
local groups = Highlite.groups("highlite", palette)

groups.CursorLineNr = { fg = palette.label }
groups.MsgSeparator = { fg = palette.text_contrast_bg_high }

groups.FlashColoramber500 = { bold = true, fg = 0xf59e0b }
groups.FlashColorblue500 = { bold = true, fg = 0x3b82f6 }
groups.FlashColorcyan500 = { bold = true, fg = 0x06b6d4 }
groups.FlashColorfuchsia500 = { bold = true, fg = 0xd946ef }
groups.FlashColorgreen500 = { bold = true, fg = 0x22c55e }
groups.FlashColorlime500 = { bold = true, fg = 0x84cc16 }
groups.FlashColorred500 = { bold = true, fg = 0xef4444 }
groups.FlashColorrose500 = { bold = true, fg = 0xf43f5e }
groups.FlashColorteal500 = { bold = true, fg = 0x14b8a6 }
groups.FlashColorviolet500 = { bold = true, fg = 0x8b5cf6 }

Highlite.generate("highlite-custom", groups, terminal_palette)
