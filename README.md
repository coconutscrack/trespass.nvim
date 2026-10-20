# trespass.nvim
Trespass highlights the part of a line that goes past your column limit. Instead of drawing a ruler down the whole window the way colorcolumn does, it marks only the text that actually crosses the line, so you see overflow when it happens and nothing the rest of the time.

It’s a small Neovim plugin written in Lua. The highlight uses the Trespass group, which links to ErrorMsg by default, so any colorscheme can restyle it.
