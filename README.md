# trespass.nvim
Trespass highlights the part of a line that goes past your column limit. Instead of drawing a ruler like colorcolumn, trespass marks only the text that actually crosses the line, so you see overflow when needed and nothing Otherwise.

Trespass is a small Neovim plugin written in Lua. The highlight uses the Trespass group, which links to ErrorMsg by default, so any colorscheme can restyle it.

## Installation

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "coconutscrack/trespass.nvim",
  opts = {},
}
```

`opts` is passed to `setup()`, so an empty table gives you the defaults below.

## Configuration

```lua
require("trespass").setup({
  enabled = true,
  column = 80,
  priority = 100,
  color = "ErrorMsg",
  ft = { "lua", "c", "javascript", "typescript", "asm" },
})
```

| Option     | Type    | Default      | Description                                                                 |
| ---------- | ------- | ------------ | --------------------------------------------------------------------------- |
| `enabled`  | boolean | `true`       | Turn the highlight on or off. `false` removes it from every window.         |
| `column`   | integer | `80`         | Text past this column is highlighted.                                       |
| `priority` | integer | `100`        | Priority of the match (see `:help matchadd()`). Higher wins over other matches. |
| `color`    | string  | `"ErrorMsg"` | Name of the highlight group that `Trespass` links to, e.g. `"WarningMsg"`.  |
| `ft`       | list of strings | `{ "lua", "c" }` | Filetypes to highlight. Windows showing any other filetype are left alone. |

Options are not validated. Please pass the types listed above; a wrong type may raise
an error or be ignored. Unknown keys (like
`colum`) are ignored.

### Choosing filetypes

`ft` is an allowlist of filetype names, as shown by `:set filetype?`.

```lua
require("trespass").setup({ ft = { "lua", "c", "python" } })
```

- Your list **replaces** the default; it is not added to it. To keep `lua`
  and `c`, include them.
- An empty list (`ft = {}`) allows no filetypes, so nothing is highlighted.
- If a window switches to a filetype that isn't in the list, its highlight is
  removed.

### Changing the color

Set `color` to the name of any existing highlight group, if you would like to customise this further, you may create your own highlight group. 

```lua
vim.api.nvim_set_hl(0, "MyOverflow", { fg = "#ff5f5f", underline = true })

require("trespass").setup({ color = "MyOverflow" })
```

The link is resolved by name, so it doesn't matter whether your group is
defined before or after `setup()`. A group that doesn't exist at all is not
reported; the highlight just won't show.

**Important:** Restart Neovim to apply a new color.
