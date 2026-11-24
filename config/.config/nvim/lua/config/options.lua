local opt = vim.opt

opt.laststatus = 3 -- Ensure global statusline
opt.number = true
opt.relativenumber = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

opt.termguicolors = true
opt.signcolumn = "yes"

opt.splitright = true
opt.splitbelow = true

opt.clipboard = "unnamedplus"

opt.updatetime = 250
opt.timeoutlen = 300

-- Modern defaults
opt.scrolloff = 8
opt.cursorline = true
opt.wrap = false
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Custom native Neovim tabline formatting
function _G.MyTabLine()
	local s = ""
	for i = 1, vim.fn.tabpagenr("$") do
		if i == vim.fn.tabpagenr() then
			s = s .. "%#TabLineSel#"
		else
			s = s .. "%#TabLine#"
		end

		s = s .. "%" .. i .. "T"

		local buflist = vim.fn.tabpagebuflist(i)
		local winnr = vim.fn.tabpagewinnr(i)
		local bufnr = buflist[winnr]
		local bufname = vim.fn.bufname(bufnr)

		local file = "[No Name]"
		if bufname ~= "" then
			file = vim.fn.fnamemodify(bufname, ":t")
		end

		local modified = vim.fn.getbufvar(bufnr, "&modified") == 1
		local mod_char = modified and " ●" or ""

		s = s .. " " .. i .. ": " .. file .. mod_char .. " "
	end

	s = s .. "%#TabLineFill#%T"
	return s
end

vim.o.tabline = "%!v:lua.MyTabLine()"

-- Folding
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
