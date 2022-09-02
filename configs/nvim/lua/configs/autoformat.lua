local prettier = require("prettier")

prettier.setup({
	bin = "prettier", -- or `prettierd`
	filetypes = {
		"css",
		"graphql",
		"html",
		"svelte",
		"javascript",
		"javascriptreact",
		"json",
		"less",
		"markdown",
		"scss",
		"typescript",
		"typescriptreact",
		"yaml",
	},
})
