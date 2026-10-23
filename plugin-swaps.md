# Plugin Swaps

Suggested replacements that keep the same workflow but add features. None of
these are applied. Snippets use `vim.pack` and `which-key`, matching the rest of
this config.

| Current                              | Replacement                                                                | File(s) affected                                 |
| ------------------------------------ | -------------------------------------------------------------------------- | ------------------------------------------------ |
| toggleterm.nvim (terminal + lazygit) | [snacks.nvim](https://github.com/folke/snacks.nvim) `terminal` / `lazygit` | `lua/plugins/terminal.lua`                       |
| `:bdelete`                           | snacks.nvim `bufdelete`                                                    | `lua/plugins/buffer.lua`                         |
| nvim-notify                          | snacks.nvim `notifier`                                                     | `lua/plugins/ui.lua`                             |
| yazi inside toggleterm               | [yazi.nvim](https://github.com/mikavilpas/yazi.nvim)                       | `lua/plugins/terminal.lua`                       |
| codex inside toggleterm              | [sidekick.nvim](https://github.com/folke/sidekick.nvim)                    | `lua/plugins/terminal.lua`, `lua/plugins/ai.lua` |
| nvim-dap-ui (+ nvim-nio)             | [nvim-dap-view](https://github.com/igorlfs/nvim-dap-view)                  | `lua/plugins/debug.lua`                          |
| nvim-autopairs                       | [blink.pairs](https://github.com/saghen/blink.pairs)                       | `lua/plugins/qol.lua`                            |
| `jk` / `kj` keymaps                  | [better-escape.nvim](https://github.com/max397574/better-escape.nvim)      | `lua/plugins/qol.lua`                            |

**Keep as-is:** fzf-lua, oil.nvim, bufferline, lualine, grug-far, flash,
gitsigns, which-key, noice, blink.cmp, lazydev. They're still the best (or
equal-best) at what they do.

---

## 1. snacks.nvim: one plugin replacing toggleterm, nvim-notify and `:bdelete`

**Why:** You already use four folke plugins (which-key, flash, noice, lazydev),
and snacks is designed to work with them. It replaces three separate
pieces with one dependency:

- **`Snacks.lazygit()`** generates a lazygit theme from your colorscheme
  (earthshine) and sets `editPreset = "nvim-remote"`. Pressing `e` on a file in
  lazygit then opens it **in the current Neovim** instead of a nested editor.
  The toggleterm version can't do either.
- **`Snacks.lazygit.log_file()`** opens lazygit's log for just the current file.
- **`Snacks.terminal`** toggles terminals keyed by command/cwd, so `2<leader>tt`
  gives you a second terminal. It has `gf` (open the file under the cursor) and
  double-`<Esc>` to leave terminal mode.
- **`Snacks.bufdelete()`** deletes a buffer **without closing its window/split**.
  Plain `:bdelete` collapses your layout when the buffer is in a split.
- **`Snacks.notifier`** replaces nvim-notify. noice's `notify` view already
  prefers a snacks backend (`backend = { "snacks", "notify" }` in
  `noice/config/views.lua`), so noice keeps working with no extra config. You
  also get `Snacks.notifier.show_history()`.

### `lua/plugins/ui.lua`

```lua
vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/folke/snacks.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/folke/noice.nvim" },
})

local colors = {
	ERROR = "#e35659",
	WARN = "#f8cc5a",
	INFO = "#409cff",
	DEBUG = "#aeaeae",
}

-- Snacks highlight groups are SnacksNotifier{Border,Icon,Title}{Level}
-- (level is Title-case: Error, Warn, Info, Debug)
for level, color in pairs(colors) do
	local name = level:sub(1, 1) .. level:sub(2):lower()
	for _, part in ipairs({ "Border", "Icon", "Title" }) do
		vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. name, { fg = color })
	end
end

-- Set up snacks early; it defines the global `Snacks`.
require("snacks").setup({
	notifier = {
		enabled = true,
		timeout = 1000,
		date_format = "%-I:%M:%S %p",
	},
	-- terminal / lazygit / bufdelete are utility modules: no `enabled` needed
	lazygit = {},
	terminal = {},
})

require("noice").setup()
```

> **Check after swapping:** `lua/utils/conventional-commits.lua` passes
> `replace = record` to `vim.notify`. That goes through noice (not nvim-notify
> directly), so it should keep working, but run `<leader>ac` once to confirm
> the "Generating commit message..." notification gets replaced.

### `lua/plugins/terminal.lua` (terminal + lazygit part)

```lua
local wk = require("which-key")

wk.add({
	mode = "n",
	{ "<leader>t", group = "Terminal" },
	{
		"<leader>tt",
		function()
			Snacks.terminal.toggle(nil, { win = { position = "float" } })
		end,
		desc = "Toggle Terminal",
	},
	{
		"<leader>tg",
		function()
			Snacks.lazygit()
		end,
		desc = "Toggle Lazygit",
	},
	{
		"<leader>tl",
		function()
			Snacks.lazygit.log_file()
		end,
		desc = "Lazygit Log (current file)",
	},
})
```

### `lua/plugins/buffer.lua` (buffer close)

```lua
{
	"<leader>bd",
	function()
		Snacks.bufdelete()
	end,
	desc = "Close",
},
{
	"<leader>bD",
	function()
		Snacks.bufdelete.other()
	end,
	desc = "Close Others",
},
```

`reopen_current_file()` can also use `Snacks.bufdelete(buf)` instead of
`vim.cmd("bdelete " .. buf)` so the window isn't closed for a moment.

---

## 2. yazi.nvim: replaces yazi in toggleterm

**Why:** When yazi runs as a raw terminal, picking a file opens it _inside the
terminal_ (a nested editor), not in your Neovim session. yazi.nvim fixes that,
and adds:

- Open the selected file(s) in the current window, a split (`<c-v>` / `<c-x>`),
  a tab (`<c-t>`), or send several to the quickfix list (`<c-q>`).
- Files renamed, moved or deleted in yazi stay in sync with open buffers **and
  with the running LSP servers** (so imports get updated on rename).
- Buffers open in Neovim are highlighted in yazi; `<tab>` jumps between them.
- `<c-s>` greps the hovered directory or selected files (works with fzf-lua);
  `<c-g>` opens **grug-far** scoped to them (you already have grug-far).
- `<f1>` shows all keymaps. `:checkhealth yazi` checks your setup.

```lua
vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" }, -- required dependency
	{ src = "https://github.com/mikavilpas/yazi.nvim", version = vim.version.range("*") },
})

require("yazi").setup({
	open_for_directories = false, -- keep oil as the directory handler
	integrations = {
		grep_in_directory = function(directory)
			require("fzf-lua").live_grep({ cwd = directory })
		end,
	},
})

wk.add({
	mode = { "n", "x" },
	{ "<leader>ty", "<cmd>Yazi<cr>", desc = "Yazi (current file)" },
	{ "<leader>tY", "<cmd>Yazi cwd<cr>", desc = "Yazi (cwd)" },
})
```

---

## 3. sidekick.nvim: replaces codex in toggleterm

**Why:** It's still a terminal running `codex`, but integrated with the editor:

- Send context straight into the CLI: `{file}`, `{selection}`, `{position}`,
  `{diagnostics}`, `{quickfix}`, `{function}`/`{class}` (treesitter), `{this}`.
- A prompt library ("explain {this}", "fix the diagnostics in {file}",
  "write tests for {this}", ...) that you can extend.
- Watches files and reloads buffers when the AI CLI edits them.
- Optional session persistence with tmux/zellij (the CLI survives restarting Neovim).
- Works with codex, claude, gemini, opencode, copilot CLI and others, and you
  can switch between them with `select()`.
- **Optional:** Copilot "Next Edit Suggestions" (multi-line refactor suggestions
  shown as diffs). This needs the `copilot` LSP enabled (see the
  `fix(completion)` stash). Turn it off with `nes = { enabled = false }`
  if you only want the CLI part.

```lua
vim.pack.add({
	{ src = "https://github.com/folke/sidekick.nvim" },
})

require("sidekick").setup({
	nes = { enabled = false }, -- set true once copilot-language-server is installed
	cli = {
		picker = "fzf-lua", -- you use fzf-lua; default is snacks
		win = { layout = "float" }, -- matches your current floating codex window
	},
})

wk.add({
	{ "<leader>tc", function() require("sidekick.cli").toggle({ name = "codex", focus = true }) end, desc = "Toggle Codex" },
	{ "<leader>aa", function() require("sidekick.cli").toggle() end, desc = "Toggle AI CLI" },
	{ "<leader>as", function() require("sidekick.cli").select() end, desc = "Select AI CLI" },
	{ "<leader>ap", function() require("sidekick.cli").prompt() end, mode = { "n", "x" }, desc = "AI Prompt" },
	{ "<leader>at", function() require("sidekick.cli").send({ msg = "{this}" }) end, mode = { "n", "x" }, desc = "Send This" },
	{ "<leader>af", function() require("sidekick.cli").send({ msg = "{file}" }) end, desc = "Send File" },
	{ "<leader>av", function() require("sidekick.cli").send({ msg = "{selection}" }) end, mode = "x", desc = "Send Selection" },
})
```

These fit under your existing `<leader>a` "AI" group next to `<leader>ac`
(commit message). If you enable NES, add
`function() return require("sidekick").nes_jump_or_apply() end` to blink's
`<Tab>` keymap list before `"select_next"`.

---

## 4. nvim-dap-view: replaces nvim-dap-ui

**Why:** It's a newer, lighter debugging UI. Instead of dap-ui's fixed
multi-pane layout, it uses one panel with winbar tabs (Watches, Scopes,
Breakpoints, Threads/call stack, REPL), so it takes less screen space. It
also has **inline virtual-text variable values** and hover built in, so you
don't need nvim-dap-virtual-text. It doesn't need nvim-nio either. `g?` in any
section shows its keymaps.

```lua
vim.pack.add({
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/igorlfs/nvim-dap-view", version = vim.version.range("1.*") },
	{ src = "https://github.com/jbyuki/one-small-step-for-vimkind" },
	{ src = "https://github.com/leoluz/nvim-dap-go" },
})

require("dap-view").setup({
	auto_toggle = true, -- open when a session starts, close when it ends
	virtual_text = { enabled = true }, -- inline variable values (off by default)
})
require("dap-go").setup()

-- keymap changes:
--   <leader>dt -> require("dap-view").toggle()
--   <leader>dq -> require("dap").terminate()  (dap-view closes itself with auto_toggle)
```

See `:help dap-view.txt` for the full option list.

---

## 5. blink.pairs: replaces nvim-autopairs

**Why:** It's from the blink.cmp author and built to run alongside it. It adds:

- **Rainbow highlighting** of brackets, with mismatched pairs highlighted.
- Indent-aware pair matching, and a built-in matchparen replacement.
- Wrapping: `<C-b>` moves the closing pair over the next motion
  (`foo(|)bar` + `<C-b>w` -> `foo(bar|)`), and it's dot-repeatable.
- Very fast (~0.2ms per keystroke, Rust parser).

**Caveat:** it's younger than nvim-autopairs and uses a prebuilt binary
(downloaded the same way blink.cmp does). `mini.pairs` is a simpler, stable
alternative if you'd rather not depend on a binary.

```lua
vim.pack.add({
	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.pairs", version = vim.version.range("*") },
})

require("blink.pairs").download():pwait(60000) -- prebuilt binary from GitHub releases
require("blink.pairs").setup()
```

nvim-ts-autotag stays. It handles HTML/JSX tags, which blink.pairs doesn't.

---

## 6. better-escape.nvim: replaces the `jk`/`kj` keymaps

**Why:**

1. **No typing delay.** With a plain `jk` mapping, every `j` you type waits
   `timeoutlen` (400ms) before appearing, because Neovim is waiting to see
   whether `k` follows. better-escape inserts the `j` immediately and only
   undoes it if `k` follows quickly. Pickers and completion filter instantly.
2. **Fixes a real bug in the current mapping.** A _mapped_ `<Esc>` in
   command-line mode **executes** the command instead of cancelling it.
   Tested: typing `:let g:x = 1` then `jk` set `g:x = 1`. better-escape uses
   `<C-c>` in cmdline, which cancels.

   (If you skip this swap, at least change the `c` mode rhs in
   `lua/plugins/qol.lua` to `<C-c>`.)

```lua
vim.pack.add({
	{ src = "https://github.com/max397574/better-escape.nvim" },
})

require("better_escape").setup({
	timeout = vim.o.timeoutlen,
	default_mappings = false, -- reproduce exactly your jk/kj in i, s, c
	mappings = {
		i = { j = { k = "<Esc>" }, k = { j = "<Esc>" } },
		s = { j = { k = "<Esc>" }, k = { j = "<Esc>" } },
		c = { j = { k = "<C-c>" }, k = { j = "<C-c>" } },
	},
})
-- then delete the esc_keys loop in lua/plugins/qol.lua
```

---

## After swapping

Remove the old plugins from disk and from `nvim-pack-lock.json`:

```vim
:lua vim.pack.del({ "toggleterm.nvim", "nvim-notify", "nvim-dap-ui", "nvim-nio", "nvim-autopairs" })
```

Then run `:checkhealth snacks yazi sidekick` to confirm the new plugins are set up.

Net change: **-5 plugins** (toggleterm, nvim-notify, nvim-dap-ui, nvim-nio,
nvim-autopairs), **+8** (snacks, yazi.nvim, plenary, sidekick, nvim-dap-view,
blink.pairs, blink.lib, better-escape). That's 3 more plugins, but snacks covers
three jobs, and the terminal, file manager and AI tools each get real editor
integration instead of being a raw shell.
