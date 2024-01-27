local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugins, opts)


-- enable mouse
vim.o.mouse = 'a'

-- remapping function
function r(mode, key, command, settings)
	
	settings = settings or {}
	
    local map_options = {
        noremap = settings.noremap or true,
        silent = settings.silent or true
    }

    vim.api.nvim_set_keymap(mode, key, command, map_options)
end

-- globals



-- normal mode --

-- [i] - start key -- to prefix all keybindings
r('n', 'i', ':')

-- [u] - leader key ('\') -- for custom keybindings
vim.g.mapleader = 'u'

-- cursor movement --
--[[
Prefix a cursor movement command with a number to repeat it. 
For example, 4j moves down 4 lines. 
]]

-- cursor - basic movements
	-- up
		-- [h] - k - move cursor up
		r('n', 'h', 'k')
		-- [H] - gk - move cursor up (multi-line text)
		r('n', 'H', 'gk')
	-- down
		-- [enter] j - move cursor down
		r('n', '<CR>', 'j')
		-- [ENTER] - gj - move cursor down (multi-line text)
		r('n', '<S-CR>', 'j')
	-- left
		-- [space] - h - move cursor left
		r('n', '<Space>', 'h')
		-- [^Space] - ^ - jump (left) to the first non-blank character of the line
		r('n', '<C-Space>', '^')
		-- [SPACE] 0 - jump (left) to the start of the line (left)
		r('n', '<S-Space>', '0')
	-- right
		-- [l] - l - move cursor right
		r('n', 'l', 'l')
		-- [^l] g_ - jump (right) to the last non-blank character of the line
		r('n', '<C-l>', 'g_')
		-- [L] $ - jump (right) to the end of the line 
		r('n', '<S-l>', '$')

-- cursor - small jumps
	-- right
		-- [s] - w - jump forwards (right) to the start of a word
		r('n', 's', 'w')
		-- [S] - W - jump forwards (right) to the start of a word (words can contain punctuation)
		r('n', 'S', 'W')
		-- [^s] - e - jump forwards (right) to the end of a word
		r('n', '<C-s>', 'e')
		-- [^S] - E - jump forwards (right) to the end of a word (words can contain punctuation)
		r('n', '<C-S>', 'E')
	--left 
		-- [t] - b - jump backwards (left) to the start of a word
		r('n', 't', 'b')
		-- [T] - B - jump backwards (left) to the start of a word (words can contain punctuation)
		r('n', 'T', 'B')
		-- [^t] - ge - jump backwards (left) to the end of a word
		r('n', '<C-t>', 'ge')
		-- [^T] - gE - jump backwards (left) to the end of a word (words can contain punctuation)
		r('n', '<C-T>', 'gE')
	-- search
		-- [g] - fx - jump to next occurrence of character x
		r('n', 'g', 'fx')
		-- [k] - Fx - jump to the previous occurrence of character x
		r('n', 'k', 'Fx')
		-- [G] - tx - jump to before next occurrence of character x
		r('n', 'G', 'tx')
		-- [K] - Tx - jump to after previous occurrence of character x
		r('n', 'K', 'Tx')
		
-- cursor - large jumps 
	-- up
		-- [w] - zt - position cursor on top of the screen -- move view to cursor
		r('n', 'w', 'zt')
		-- [^w] - H - move cursor to top of screen
		r('n', '<C-w>', 'H')
		-- [W] - gg - go to the first line of the document
		r('n', 'W', 'gg')
	-- middle
		-- [f] - zz - center cursor on screen -- move view to cursor
		r('n', 'f', 'zz')
		-- [^f] - M - move cursor to middle of screen
		r('n', '<C-f>', 'M')
		-- [F] - % - move cursor to matching character (default supported pairs: '()', '{}', '[]' - use :h matchpairs in vim for more info)
		r('n', 'F', '%')
	-- down
		-- [m] zb - position cursor on bottom of the screen -- move view to cursor
		r('n', 'm', 'zb')
		-- [^m] - L - move cursor to bottom of screen
		r('n', '<C-m>', 'L')
		-- [M] - G - go to the last line of the document
		r('n', 'M', 'G')

-- camera movement --
	-- up
		-- [o] - Ctrl + u - move cursor and screen up 1/2 page
		r('n', 'o', '<C-u>')
		-- [^o] - Ctrl + y - move screen up one line (without moving cursor)
		r('n', '<C-o>', '<C-y>')
		-- [O] - Ctrl + b - move screen up one page (cursor to last line)
		r('n', '<S-o>', '<C-b>')
	-- down
		-- [e] - Ctrl + d - move cursor and screen down 1/2 page
		r('n', 'e', '<C-d>')
		-- [^e] - Ctrl + e - move screen down one line (without moving cursor)
		r('n', '<C-e>', '<C-e>')
		-- [E] - Ctrl + f - move screen down one page (cursor to first line)
		r('n', '<S-e>', '<C-f>')

-- special movement --
	-- repeat
		-- [r] - ; - repeat previous f, t, F or T movement
		r('n', 'r', ';')
		-- [R] - , - repeat previous f, t, F or T movement, backwards
		r('n', 'R', ',')
	
	-- paragraphs
		-- [n] - } - jump to next paragraph (or function/block, when editing code)
		r('n', 'n', '}')
		-- [N] - { - jump to previous paragraph (or function/block, when editing code)
		r('n', 'N', '{')

	-- declarations
		-- [d] - gd - move to local declaration
		r('n', 'd', 'gd')
		-- [D] - gD - move to global declaration
		r('n', 'D', 'gD')

-- insert mode -- (x/c)
	-- entering insert mode
		-- [x] - i - insert before the cursor
		r('n', 'x', 'i')
		-- [X] - I - insert at the beginning of the line
		r('n', 'X', 'I')
		-- [unused] - o - insert after the cursor
		-- [^x] - ea - insert at the end of the word
		r('n', '<C-x>', 'ea')
		-- [^X] O - insert at the end of the line
		r('n', '<C-X>', 'O')
		-- [c] - o - append (open) a new line below the current line
		r('n', 'c', 'o')
		-- [C] - O - append (open) a new line above the current line
		r('n', 'C', 'O')
		-- [^c] -- insert at the top of the document
		r('n', '<C-c>', 'ggO')
		-- [^C] -- insert at the bottom of the document
		r('n', '<C-C>', 'Go')
	-- exiting insert mode
		-- [ctrl+x] - Esc or Ctrl + c - exit insert mode
		r('i', '<C-x>', '<Esc>')

	-- during insert mode
		-- [] - Ctrl + h - delete the character before the cursor during insert mode
		
		-- [] - Ctrl + w - delete word before the cursor during insert mode
		-- Ctrl + j - add a line break at the cursor position during insert mode
		-- Ctrl + t - indent (move right) line one shiftwidth during insert mode
		-- Ctrl + d - de-indent (move left) line one shiftwidth during insert mode
		-- Ctrl + n - insert (auto-complete) next match before the cursor during insert mode
		-- Ctrl + p - insert (auto-complete) previous match before the cursor during insert mode
		-- [unchanged] - Ctrl + rx - insert the contents of register x during insert mode
		-- [ctrl + n] - Ctrl + ox - Temporarily enter normal mode to issue one normal-mode command x during insert mode
		r('i', '<C-n>', '<C-o>')

-- visual mode (v)
	--	v - start visual mode, mark lines, then do a command (like y-yank)
	--	V - start linewise visual mode
	--	o - move to other end of marked area
	--	Ctrl + v - start visual block mode
	--	Esc or Ctrl + c - exit visual mode
	
	--	O - move to other corner of block
	--	aw - mark a word
	--	ab - a block with ()
	--	aB - a block with {}
	--	at - a block with <> tags
	--	ib - inner block with ()
	--	iB - inner block with {}
	--	it - inner block with <> tags

	--	Tip Instead of b or B one can also use ( or { respectively.

	--	> - shift text right
	--	< - shift text left
	--	y - yank (copy) marked text
	--	d - delete marked text
	--	~ - switch case
	--	u - change marked text to lowercase
	--	U - change marked text to uppercase

--	Registers

	-- [ir]- :reg[isters] - show registers content
	-- "xy - yank into register x
	-- "xp - paste contents of register x
	-- "+y - yank into the system clipboard register
	-- "+p - paste from the system clipboard register



-- select mode (z)



-- Marks and positions
	--[[ Tip To jump to a mark you can either use a backtick (`) 
	 or an apostrophe ('). Using an apostrophe jumps to the 
	 beginning (first non-blank) of the line holding the mark. 
	]]

-- :marks - list of marks
-- ma - set current position for mark A
-- `a - jump to position of mark A
-- y`a - yank text to position of mark A
-- `0 - go to the position where Vim was previously exited
-- `" - go to the position when last editing this file
-- `. - go to the position of the last change in this file
-- `` - go to the position before the last jump
-- :ju[mps] - list of jumps
-- Ctrl + i - go to newer position in jump list
-- Ctrl + o - go to older position in jump list
-- :changes - list of changes
-- g, - go to newer position in change list
-- g; - go to older position in change list
-- Ctrl + ] - jump to the tag under cursor





-- Macros

	-- qa - record macro a
	-- q - stop recording macro
	-- @a - run macro a
	-- @@ - rerun last run macro

-- Cut and paste

	-- yy - yank (copy) a line
	-- 2yy - yank (copy) 2 lines
	-- yw - yank (copy) the characters of the word from the cursor position to the start of the next word
	-- yiw - yank (copy) word under the cursor
	-- yaw - yank (copy) word under the cursor and the space after or before it
	-- y$ or Y - yank (copy) to end of line
	-- p - put (paste) the clipboard after cursor
	-- P - put (paste) before cursor
	-- gp - put (paste) the clipboard after cursor and leave cursor after the new text
	-- gP - put (paste) before cursor and leave cursor after the new text
	-- dd - delete (cut) a line
	-- 2dd - delete (cut) 2 lines
	-- dw - delete (cut) the characters of the word from the cursor position to the start of the next word
	-- diw - delete (cut) word under the cursor
	-- daw - delete (cut) word under the cursor and the space after or before it
	-- :3,5d - delete lines starting from 3 to 5

--[[ You can also use the following characters to specify the range:
	:.,$d - From the current line to the end of the file
	:.,1d - From the current line to the beginning of the file
	:10,$d - From the 10th line to the beginning of the file
]]
	-- :g/{pattern}/d - delete all lines containing pattern
	-- :g!/{pattern}/d - delete all lines not containing pattern
	-- d$ or D - delete (cut) to the end of the line
	-- x - delete (cut) character

-- Indent text

	-- >> - indent (move right) line one shiftwidth
	-- << - de-indent (move left) line one shiftwidth
	-- >% - indent a block with () or {} (cursor on brace)
	-- <% - de-indent a block with () or {} (cursor on brace)
	-- >ib - indent inner block with ()
	-- >at - indent a block with <> tags
	-- 3== - re-indent 3 lines
	-- =% - re-indent a block with () or {} (cursor on brace)
	-- =iB - re-indent inner block with {}
	-- gg=G - re-indent entire buffer
	-- ]p - paste and adjust indent to current line

-- Exiting

	-- :w - write (save) the file, but don't exit
	-- :w !sudo tee % - write out the current file using sudo
	-- :wq or :x or ZZ - write (save) and quit
	-- :q - quit (fails if there are unsaved changes)
	-- :q! or ZQ - quit and throw away unsaved changes
	-- :wqa - write (save) and quit on all tabs

-- Search and replace

	-- /pattern - search for pattern
	-- ?pattern - search backward for pattern
	-- \vpattern - 'very magic' pattern: non-alphanumeric characters are interpreted as special regex symbols (no escaping needed)
	-- n - repeat search in same direction
	-- N - repeat search in opposite direction
	-- :%s/old/new/g - replace all old with new throughout file
	-- :%s/old/new/gc - replace all old with new throughout file with confirmations
	-- :noh[lsearch] - remove highlighting of search matches

-- Search in multiple files

	-- :vim[grep] /pattern/ {`{file}`} - search for pattern in multiple files, e.g. :vim[grep] /foo/ **/*

	-- :cn[ext] - jump to the next match
	-- :cp[revious] - jump to the previous match
	-- :cope[n] - open a window containing the list of matches
	-- :ccl[ose] - close the quickfix window

-- Tabs
	-- :tabnew or :tabnew {page.words.file} - open a file in a new tab
	-- Ctrl + wT - move the current split window into its own tab
	-- gt or :tabn[ext] - move to the next tab
	-- gT or :tabp[revious] - move to the previous tab
	-- #gt - move to tab number #
	-- :tabm[ove] # - move current tab to the #th position (indexed from 0)
	-- :tabc[lose] - close the current tab and all its windows
	-- :tabo[nly] - close all tabs except for the current one
	-- :tabdo command - run the command on all tabs (e.g. :tabdo q - closes all opened tabs)



-- Working with multiple files

	-- :e[dit] file - edit a file in a new buffer
	-- :bn[ext] - go to the next buffer
	-- :bp[revious] - go to the previous buffer
	-- :bd[elete] - delete a buffer (close a file)
	-- :b[uffer]# - go to a buffer by index #
	-- :b[uffer] file - go to a buffer by file
	-- :ls or :buffers - list all open buffers
	-- :sp[lit] file - open a file in a new buffer and split window
	-- :vs[plit] file - open a file in a new buffer and vertically split window
	-- :vert[ical] ba[ll] - edit all buffers as vertical windows
	-- :tab ba[ll] - edit all buffers as tabs
	-- Ctrl + ws - split window
	-- Ctrl + wv - split window vertically
	-- Ctrl + ww - switch windows
	-- Ctrl + wq - quit a window
	-- Ctrl + wx - exchange current window with next one
	-- Ctrl + w= - make all windows equal height & width
	-- Ctrl + wh - move cursor to the left window (vertical split)
	-- Ctrl + wl - move cursor to the right window (vertical split)
	-- Ctrl + wj - move cursor to the window below (horizontal split)
	-- Ctrl + wk - move cursor to the window above (horizontal split)
	-- Ctrl + wH - make current window full height at far left (leftmost vertical window)
	-- Ctrl + wL - make current window full height at far right (rightmost vertical window)
	-- Ctrl + wJ - make current window full width at the very bottom (bottommost horizontal window)
	-- Ctrl + wK - make current window full width at the very top (topmost horizontal window)

-- Diff
	--[[ The commands for folding (e.g. za) operate on 
	one level. To operate on all levels, use uppercase 
	letters (e.g. zA). 
	To view the differences of files, one can directly 
	start Vim in diff mode by running vimdiff in a 
	terminal. One can even set this as git difftool.
]]
	-- zf - manually define a fold up to motion
	-- zd - delete fold under the cursor
	-- za - toggle fold under the cursor
	-- zo - open fold under the cursor
	-- zc - close fold under the cursor
	-- zr - reduce (open) all folds by one level
	-- zm - fold more (close) all folds by one level
	-- zi - toggle folding functionality
	-- ]c - jump to start of next change
	-- [c - jump to start of previous change
	-- do or :diffg[et] - obtain (get) difference (from other buffer)
	-- dp or :diffpu[t] - put difference (to other buffer)
	-- :diffthis - make current window part of diff
	-- :dif[fupdate] - update differences
	-- :diffo[ff] - switch off diff mode for current window








-- custom --
	-- telescope 
		-- find files
		r('n', '<leader>ff', '<cmd>Telescope find_files<cr>')