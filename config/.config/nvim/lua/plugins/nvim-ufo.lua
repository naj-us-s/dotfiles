return {
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		event = "BufReadPost",
		keys = {
			{
				"zR",
				function()
					require("ufo").openAllFolds()
				end,
				desc = "Open all folds",
			},
			{
				"zM",
				function()
					require("ufo").closeAllFolds()
				end,
				desc = "Close all folds",
			},
			{
				"zr",
				function()
					require("ufo").openFoldsExceptKinds()
				end,
				desc = "Open folds except kinds",
			},
			{
				"zm",
				function()
					require("ufo").closeFoldsWith()
				end,
				desc = "Close folds with",
			},
			{
				"K",
				function()
					local winid = require("ufo").peekFoldedLinesUnderCursor()
					if not winid then
						vim.lsp.buf.hover()
					end
				end,
				desc = "Peek fold or hover docs",
			},
		},
		config = function()
			local ufo = require("ufo")

			local function handleFallbackException(bufnr, err, providerName)
				if type(err) == "string" and err:match("UfoFallbackException") then
					return ufo.getFolds(bufnr, providerName)
				else
					return require("promise").reject(err)
				end
			end

			ufo.setup({
				provider_selector = function(bufnr, filetype, buftype)
					return function(bufnr)
						return ufo.getFolds(bufnr, "lsp")
							:catch(function(err)
								return handleFallbackException(bufnr, err, "treesitter")
							end)
							:catch(function(err)
								return handleFallbackException(bufnr, err, "indent")
							end)
					end
				end,
			})
		end,
	},
}
