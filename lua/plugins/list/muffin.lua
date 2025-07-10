MiniDeps.add("metafates/muffin.nvim")

require("muffin").setup({})

require("util.keymap").set("n", "T", Muffin.toggle)
