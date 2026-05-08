-- ######### INSTALLATION #########
vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/zbirenbaum/copilot.lua" },
	{ src = "https://github.com/CopilotC-Nvim/CopilotChat.nvim" },
})

-- ######### CONFIG #########
require("CopilotChat").setup()

local commit_prompt = [[
You are an expert software engineer helping write Git commit messages using the Commitizen / Conventional Commits standard.

Generate a concise, professional commit message based on the provided code changes.

Rules:
- Use format: <type>(optional-scope): <short summary>
- Keep the summary under 72 characters
- Use lowercase except for proper nouns
- Use imperative mood ("add" not "added" or "adds")
- Do not end with punctuation
- Make the message easy to scan quickly
- Focus on the WHY and primary outcome, not implementation details
- If appropriate, include a body with bullet points
- Prefer clarity over cleverness

Allowed types:
- feat: new feature
- fix: bug fix
- refactor: code restructuring without behavior changes
- perf: performance improvement
- docs: documentation only
- style: formatting or lint-only changes
- test: adding or updating tests
- build: build system or dependency changes
- ci: CI/CD related changes
- chore: maintenance tasks
- revert: reverting previous commit

Good examples:
- feat(auth): add jwt refresh token handling
- fix(api): prevent duplicate invoice creation
- refactor(ui): simplify modal state management
- docs(readme): update local setup instructions
]]

-- ######### KEYMAPS #########
local wk = require("which-key")

wk.add({
	mode = "n",
	{
		"<leader>a",
		group = "AI",
	},
	{
		"<leader>ac",
		function()
			require("utils.ai-helpers").commit(commit_prompt)
		end,
		desc = "Git Commit Message",
	},
})
