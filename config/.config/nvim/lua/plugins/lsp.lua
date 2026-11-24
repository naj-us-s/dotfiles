return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"prettierd",
				"prettier",
				"black",
				"isort",
				"stylua",
				"shfmt",
				"sql-formatter",
				"taplo",

				"eslint_d",
				"ruff",
				"hadolint",

				"html-lsp",
				"emmet-language-server",
				"css-lsp",
			},
		},
	},

	-- JSON schemas (package.json, tsconfig, OpenAPI, etc.)
	{ "b0o/schemastore.nvim" },

	-- LSP Zero (utility)
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
	},

	-- LSP Config
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"b0o/schemastore.nvim",
		},

		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			vim.diagnostic.config({
				float = { border = "rounded" },
				severity_sort = true,
				underline = true,
				update_in_insert = false,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local buf = args.buf
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = buf, desc = desc })
					end

					map("gd", vim.lsp.buf.definition, "Go to definition")
					map("gr", vim.lsp.buf.references, "References")
					map("K", function()
						local ok, ufo = pcall(require, "ufo")
						local winid
						if ok then
							winid = ufo.peekFoldedLinesUnderCursor()
						end
						if not winid then
							vim.lsp.buf.hover()
						end
					end, "Hover docs / Peek fold")
					map("[d", vim.diagnostic.goto_prev, "Prev diagnostic")
					map("]d", vim.diagnostic.goto_next, "Next diagnostic")
					map("<leader>lr", vim.lsp.buf.rename, "Rename symbol")
					map("<leader>la", vim.lsp.buf.code_action, "Code actions")
					map("<leader>ld", vim.diagnostic.open_float, "Line diagnostics")
					map("<leader>lq", vim.diagnostic.setloclist, "Diagnostics list")
				end,
			})

			local servers = {
				"lua_ls",
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
				"emmet_ls",
				"pyright",
				"gopls",
				"sqlls",
				"eslint",
				"dockerls",
				"docker_compose_language_service",
				"bashls",
				"taplo",
				"prismals",
			}

			for _, server in ipairs(servers) do
				vim.lsp.config(server, { capabilities = capabilities })
				vim.lsp.enable(server)
			end

			vim.lsp.config("emmet_ls", {
				capabilities = capabilities,
				filetypes = {
					"html",
					"css",
					"scss",
					"sass",
					"less",
					"javascriptreact",
					"typescriptreact",
					"svelte",
					"vue",
					"xml",
				},
			})

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = { diagnostics = { globals = { "vim" } } },
				},
			})

			vim.lsp.config("jsonls", {
				capabilities = capabilities,
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})
			vim.lsp.enable("jsonls")

			vim.lsp.config("yamlls", {
				capabilities = capabilities,
				settings = {
					yaml = {
						schemaStore = { enable = false, url = "" },
						schemas = require("schemastore").yaml.schemas(),
					},
				},
			})
			vim.lsp.enable("yamlls")

			vim.lsp.config("eslint", {
				capabilities = capabilities,
				on_attach = function(_, buf)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = buf,
						command = "EslintFixAll",
					})
				end,
			})
		end,
	},
}
