MiniDeps.add("file:///Users/vzbarashchenko/code/github/muffin.nvim")

require("muffin").setup({})

require("util.keymap").set("n", "T", Muffin.toggle)
