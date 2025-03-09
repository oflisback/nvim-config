# Neovim config

This is my "from scratch" style neovim-config where all the fundamentals are based on [Josean Martinez' excellent walkthrough](https://www.youtube.com/watch?v=6pAG3BHurdM) and then I've added some of my own favorite plugins.

Josean's [reference config](https://github.com/josean-dev/dev-environment-files/tree/main/.config/nvim).

## Good to know

I'd prefer to have all leader-prefixed keybinds in `after.lua` but some plugins require them to be defined in the `keys` section to enable lazy loading. Even setting `event = "VeryLazy"` and defining binding in `after.lua` does not accomplish it.

## Keybinds I need to internalize

| Keybind        | Function                             | Provider     |
| -------------- | ------------------------------------ | ------------ |
| {CTRL-Space}   | Expand text object aware selection   | Treesitter   |
| {Backspace}    | Contract text object aware selection | Treesitter   |
| ih             | Expand text object selection to hunk | Gitsigns     |
| <h             | Jump to next hunk                    | Gitsigns     |
| >h             | Jump to previous hunk                | Gitsigns     |
| <leader>sm     | Toggle maximize current split        | vim-maximize |
| gc<motion>     | Comment out code                     | comment.nvim |
| gc visual mode | Comment out selection                | comment.nvim |

## Telescope specific keybinds

{Ctrl-space} fuzzy_refine current search results, so if I was searching for a word, after <C-space> I can search among the current results!
