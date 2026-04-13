# Neovim Keybinds Reference

**Leader key:** `<Space>`

---

## General

| Keybind | Mode | Description |
|---------|------|-------------|
| `jk` | Insert | Exit insert mode |
| `<leader>nh` | Normal | Clear search highlights |
| `<leader>+` | Normal | Increment number under cursor |
| `<leader>-` | Normal | Decrement number under cursor |
| `<leader>ut` | Normal | Toggle transparent background (terminal shows through); state persists across restarts until you turn it off |

---

## Windows & Splits

| Keybind | Mode | Description |
|---------|------|-------------|
| `<leader>sv` | Normal | Split window vertically |
| `<leader>sh` | Normal | Split window horizontally |
| `<leader>se` | Normal | Make splits equal size |
| `<leader>sx` | Normal | Close current split |

---

## Tabs

| Keybind | Mode | Description |
|---------|------|-------------|
| `<leader>to` | Normal | Open new tab |
| `<leader>tx` | Normal | Close current tab |
| `<leader>tn` | Normal | Go to next tab |
| `<leader>tp` | Normal | Go to previous tab |
| `<leader>tf` | Normal | Open current buffer in new tab |

---

## File Explorer (Nvim-Tree)

| Keybind | Mode | Description |
|---------|------|-------------|
| `<leader>ee` | Normal | Toggle file explorer |
| `<leader>ef` | Normal | Toggle file explorer on current file |
| `<leader>ec` | Normal | Collapse file explorer |
| `<leader>er` | Normal | Refresh file explorer |

---

## Telescope (Find)

| Keybind | Mode | Description |
|---------|------|-------------|
| `<leader>ff` | Normal | Fuzzy find files in cwd |
| `<leader>fr` | Normal | Fuzzy find recent files |
| `<leader>fs` | Normal | Find string in cwd (live grep) |
| `<leader>fc` | Normal | Find string under cursor in cwd |
| `<leader>ft` | Normal | Find todos |
| `<leader>fk` | Normal | Find keymaps |

### Telescope (inside picker)

| Keybind | Mode | Description |
|---------|------|-------------|
| `<C-k>` | Insert | Move to previous result |
| `<C-j>` | Insert | Move to next result |
| `<C-q>` | Insert | Send selected to quickfix list (opens Trouble) |
| `<C-t>` | Insert | Open in Trouble |

---

## LSP (when attached to buffer)

| Keybind | Mode | Description |
|---------|------|-------------|
| `gR` | Normal | Show LSP references (Telescope) |
| `gD` | Normal | Go to declaration |
| `gd` | Normal | Show LSP definitions (Telescope) |
| `gi` | Normal | Show LSP implementations |
| `gt` | Normal | Show LSP type definitions |
| `K` | Normal | Show documentation (hover) for symbol under cursor |
| `<leader>ca` | Normal, Visual | Code actions (in visual mode applies to selection) |
| `<leader>rn` | Normal | Smart rename |
| `<leader>D` | Normal | Show buffer diagnostics (Telescope) |
| `<leader>d` | Normal | Show line diagnostics (float) |
| `[d` | Normal | Go to previous diagnostic |
| `]d` | Normal | Go to next diagnostic |
| `<leader>rs` | Normal | Restart LSP |

---

## Diagnostics (see also LSP)

| Keybind | Mode | Description |
|---------|------|-------------|
| `<leader>d` | Normal | Show line diagnostics (float) |
| `[d` | Normal | Previous diagnostic |
| `]d` | Normal | Next diagnostic |
| `<leader>D` | Normal | Show buffer diagnostics (Telescope) |

---

## Git (Gitsigns, in git buffers)

| Keybind | Mode | Description |
|---------|------|-------------|
| `]h` | Normal | Next hunk |
| `[h` | Normal | Previous hunk |
| `<leader>hs` | Normal, Visual | Stage hunk (in visual: stage selection) |
| `<leader>hr` | Normal, Visual | Reset hunk (in visual: reset selection) |
| `<leader>hS` | Normal | Stage buffer |
| `<leader>hR` | Normal | Reset buffer |
| `<leader>hu` | Normal | Undo stage hunk |
| `<leader>hp` | Normal | Preview hunk |
| `<leader>hb` | Normal | Toggle line blame / diff this (first press sets up) |
| `<leader>hB` | Normal | Toggle line blame (after `<leader>hb`) |
| `<leader>hd` | Normal | Diff this (after `<leader>hb`) |
| `ih` | Operator, Visual | Text object: select hunk (e.g. `vih`, `dih`) |

---

## Substitute (gbprod/substitute.nvim)

| Keybind | Mode | Description |
|---------|------|-------------|
| `<leader>r` | Normal | Substitute with motion |
| `<leader>rr` | Normal | Substitute line |
| `<leader>R` | Normal | Substitute to end of line |
| `<leader>r` | Visual | Substitute selection |

---

## Formatting (Conform)

| Keybind | Mode | Description |
|---------|------|-------------|
| `<leader>mp` | Normal, Visual | Format file or selected range (visual mode) |

---

## Linting (nvim-lint)

| Keybind | Mode | Description |
|---------|------|-------------|
| `<leader>l` | Normal | Trigger linting for current file |

---

## Sessions (auto-session)

| Keybind | Mode | Description |
|---------|------|-------------|
| `<leader>wr` | Normal | Restore session for cwd |
| `<leader>ws` | Normal | Save session for current auto-session root dir |

---

## Todo Comments

| Keybind | Mode | Description |
|---------|------|-------------|
| `]t` | Normal | Next todo comment |
| `[t` | Normal | Previous todo comment |

---

## Notifications / Messages (Noice + Notify)

| Keybind | Mode | Description |
|---------|------|-------------|
| `<leader>md` | Normal | Dismiss all notifications |
| `<leader>mh` | Normal | View message history |

---

## Flash (quick jump / search)

| Keybind | Mode | Description |
|---------|------|-------------|
| `s` | Normal, Visual, Operator | Flash jump (label-based jump) |
| `S` | Normal, Visual, Operator | Flash Treesitter (jump to TS node) |
| `r` | Operator | Remote Flash (from another window) |
| `R` | Operator, Visual | Treesitter search |
| `<C-s>` | Command-line | Toggle Flash search in cmdline |

---

## Treesitter (incremental selection)

| Keybind | Mode | Description |
|---------|------|-------------|
| `<C-space>` | Normal | Init / expand incremental selection (node) |
| `<BS>` | Normal | Shrink incremental selection (node) |

---

## Treesitter Text Objects (select)

Use with `v`, `d`, `c`, etc. (e.g. `vaf`, `dim`).

| Keybind | Description |
|---------|-------------|
| `a=` / `i=` | Assignment outer / inner |
| `l=` / `r=` | Assignment LHS / RHS |
| `a:` / `i:` | Object property outer / inner |
| `l:` / `r:` | Property LHS / RHS |
| `aa` / `ia` | Parameter/argument outer / inner |
| `ai` / `ii` | Conditional outer / inner |
| `al` / `il` | Loop outer / inner |
| `af` / `if` | Function call outer / inner |
| `am` / `im` | Function/method definition outer / inner |
| `ac` / `ic` | Class outer / inner |

---

## Treesitter Text Objects (swap)

| Keybind | Description |
|---------|-------------|
| `<leader>na` | Swap parameter/argument with next |
| `<leader>n:` | Swap object property with next |
| `<leader>nm` | Swap function with next |
| `<leader>pa` | Swap parameter/argument with previous |
| `<leader>p:` | Swap object property with previous |
| `<leader>pm` | Swap function with previous |

---

## Treesitter Text Objects (move / goto)

| Keybind | Description |
|---------|-------------|
| `]f` / `[f` | Next / previous function call start |
| `]F` / `[F` | Next / previous function call end |
| `]m` / `[m` | Next / previous method/function def start |
| `]M` / `[M` | Next / previous method/function def end |
| `]c` / `[c` | Next / previous class start |
| `]C` / `[C` | Next / previous class end |
| `]i` / `[i` | Next / previous conditional start |
| `]I` / `[I` | Next / previous conditional end |
| `]l` / `[l` | Next / previous loop start |
| `]L` / `[L` | Next / previous loop end |
| `]s` | Next scope (locals) |
| `]z` | Next fold |

---

## Treesitter Repeatable Move

| Keybind | Mode | Description |
|---------|------|-------------|
| `;` | Normal, Visual, Operator | Repeat last move (same direction) |
| `,` | Normal, Visual, Operator | Repeat last move (opposite direction) |
| `f` / `F` / `t` / `T` | Normal, Visual, Operator | Built-in char search (repeatable with `;` and `,`) |

---

---

## Updating nvim-treesitter

- **Update the plugin:** In Neovim run `:Lazy update nvim-treesitter nvim-treesitter-textobjects` (or `:Lazy update` for all plugins).
- **Update language parsers:** After updating the plugin, run `:TSUpdate` so parsers match the plugin version. Your config runs `TSUpdate` on first install via `build = ":TSUpdate"`.

---

## Quick reference by leader prefix

| Prefix | Area |
|--------|------|
| `<leader>f` | Telescope / find (files, recent, grep, todos, keymaps) |
| `<leader>e` | File explorer (Nvim-Tree) |
| `<leader>s` | Splits & windows |
| `<leader>t` | Tabs |
| `<leader>h` | Git (hunks, stage, reset, blame, diff) |
| `<leader>w` | Sessions (save/restore) |
| `<leader>n` / `<leader>p` | Treesitter swap next/prev |
| `<leader>r` | Substitute; `<leader>rs` = LSP restart |
| `<leader>c` | Code actions (`<leader>ca`) |
| `<leader>m` | Messages/notify (`<leader>md`, `mp`, `mh`) |
| `<leader>u` | UI (e.g. `<leader>ut` = toggle transparent background) |
| `<leader>l` | Lint |
| `<leader>d` / `<leader>D` | Diagnostics (line / buffer) |
