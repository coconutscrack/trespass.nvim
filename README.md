# trespass.nvim
Trespass highlights the part of a line that goes past your column limit. Instead of drawing a ruler down the whole window the way colorcolumn does, it marks only the text that actually crosses the line, so you see overflow when it happens and nothing the rest of the time.

It’s a small Neovim plugin written in Lua. The highlight uses the Trespass group, which links to ErrorMsg by default, so any colorscheme can restyle it.

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
})
```

| Option     | Type    | Default      | Description                                                                 |
| ---------- | ------- | ------------ | --------------------------------------------------------------------------- |
| `enabled`  | boolean | `true`       | Turn the highlight on or off. `false` removes it from every window.         |
| `column`   | integer | `80`         | Text past this column is highlighted.                                       |
| `priority` | integer | `100`        | Priority of the match (see `:help matchadd()`). Higher wins over other matches. |
| `color`    | string  | `"ErrorMsg"` | Name of the highlight group that `Trespass` links to, e.g. `"WarningMsg"`.  |

Options are not validated. Pass the types listed above; a wrong type may raise
an error or be silently ignored, and unknown keys (such as a typo like
`colum`) are ignored.

### Changing the color

Set `color` to the name of any existing highlight group, including one you
define yourself:

```lua
vim.api.nvim_set_hl(0, "MyOverflow", { fg = "#ff5f5f", underline = true })

require("trespass").setup({ color = "MyOverflow" })
```

The link is resolved by name, so it doesn't matter whether your group is
defined before or after `setup()`. A group that doesn't exist at all is not
reported; the highlight just won't show.

The `Trespass` group is defined with `default = true`, so it survives
`:highlight clear` from a colorscheme, but that also means it is only set on
the first `setup()` call in a session. Restart Neovim to apply a new `color`.
