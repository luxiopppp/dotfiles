vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "qq", "<ESC>", { desc = "Exit insert mode" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment num"})
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement num"})

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc= "Move lines up in visual mode" })
keymap.set("v", "J", ":m '<+1<CR>gv=gv", { desc= "Move lines down in visual mode" })

keymap.set("n", "J", "mzJ`z") -- When join whith J, it keeps the cursor at the end

keymap.set("i", "n~", 'ñ', { noremap = true })
keymap.set("i", "N~", 'Ñ', { noremap = true })

-- keymap.set("n", "<leader>nd", function()
--   vim.cmd("terminal ~/.scripts/dailynote.sh")
-- end, { desc = "New Daily Note" })

keymap.set({ "n", "v", "i" }, "<M-h>", function ()
  require("noice").cmd("all")
end, { desc = "Noice History"})

keymap.set({ "n", "v", "i" }, "<M-d>", function ()
  require("noice").cmd("dismiss")
end, { desc = "Dismiss Noice Message" })

keymap.set("n", "<leader>wu", "viw~", { desc = "toggle word casing" })

keymap.set("n", "<leader>mso", function ()
  vim.opt_local.spell = not vim.opt_local.spell:get()
end, { desc = "Toggle spell checker"})

keymap.set("n", "<leader>mss", function ()
  vim.cmd("normal! 1z=")
end, { desc = "Choose 1st spelling suggest", noremap = true, silent = true })

keymap.set("n", "<leader>msg", function ()
  vim.cmd("normal! zg")
end, { desc = "Add word to spellfile" })

keymap.set("n", "<leader>msu", function ()
  vim.cmd("normal! zug")
end, { desc = "Remove word from spellfile" })

-- keymap.set("n", "<leader>msr", function ()
--   vim.api.nvm_feedkeys(vim.api.nvim_replace_termcodes(":spellr\n", true, false, true), "m", true)
-- end)

keymap.set("n", "<leader>msls", function ()
  vim.opt.spelllang = "es"
  vim.cmd("echo 'Spell language Spanish'")
end, { desc = "Seplling language Spanish"})

keymap.set("n", "<leader>mslb", function ()
  vim.opt.spelllang = "en,es"
  vim.cmd("echo 'Spell language Spanish and English'")
end, { desc = "Seplling language Spanish and English"})

-- If this is a bash script, make it executable, and execute it in a tmux pane on the right
-- Using a tmux pane allows me to easily select text
-- Had to include quotes around "%" because there are some apple dirs that contain spaces, like iCloud
keymap.set("n", "<leader>cb", function()
  local file = vim.fn.expand("%") -- Get the current file name
  local first_line = vim.fn.getline(1) -- Get the first line of the file
  if string.match(first_line, "^#!/") then -- If first line contains shebang
    local escaped_file = vim.fn.shellescape(file) -- Properly escape the file name for shell commands
    -- Execute the script on a tmux pane on the right. On my mac I use zsh, so
    -- running this script with bash to not execute my zshrc file after
    -- vim.cmd("silent !tmux split-window -h -l 60 'bash -c \"" .. escaped_file .. "; exec bash\"'")
    -- `-l 60` specifies the size of the tmux pane, in this case 60 columns
    vim.cmd(
      "silent !tmux split-window -h -l 60 'bash -c \""
        .. escaped_file
        .. "; echo; echo Press any key to exit...; read -n 1; exit\"'"
    )
  else
    vim.cmd("echo 'Not a script. Shebang line not found.'")
  end
end, { desc = "BASH, execute file" })

-- Toggle bullet point at the beginning of the current line in normal mode
-- If in a multiline paragraph, make sure the cursor is on the line at the top
-- "d" is for "dash" lamw25wmal
vim.keymap.set("n", "<leader>md", function()
  -- Get the current cursor position
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local current_buffer = vim.api.nvim_get_current_buf()
  local start_row = cursor_pos[1] - 1
  local col = cursor_pos[2]
  -- Get the current line
  local line = vim.api.nvim_buf_get_lines(current_buffer, start_row, start_row + 1, false)[1]
  -- Check if the line already starts with a bullet point
  if line:match("^%s*%-") then
    -- Remove the bullet point from the start of the line
    line = line:gsub("^%s*%-", "")
    vim.api.nvim_buf_set_lines(current_buffer, start_row, start_row + 1, false, { line })
    return
  end
  -- Search for newline to the left of the cursor position
  local left_text = line:sub(1, col)
  local bullet_start = left_text:reverse():find("\n")
  if bullet_start then
    bullet_start = col - bullet_start
  end
  -- Search for newline to the right of the cursor position and in following lines
  local right_text = line:sub(col + 1)
  local bullet_end = right_text:find("\n")
  local end_row = start_row
  while not bullet_end and end_row < vim.api.nvim_buf_line_count(current_buffer) - 1 do
    end_row = end_row + 1
    local next_line = vim.api.nvim_buf_get_lines(current_buffer, end_row, end_row + 1, false)[1]
    if next_line == "" then
      break
    end
    right_text = right_text .. "\n" .. next_line
    bullet_end = right_text:find("\n")
  end
  if bullet_end then
    bullet_end = col + bullet_end
  end
  -- Extract lines
  local text_lines = vim.api.nvim_buf_get_lines(current_buffer, start_row, end_row + 1, false)
  local text = table.concat(text_lines, "\n")
  -- Add bullet point at the start of the text
  local new_text = "- " .. text
  local new_lines = vim.split(new_text, "\n")
  -- Set new lines in buffer
  vim.api.nvim_buf_set_lines(current_buffer, start_row, end_row + 1, false, new_lines)
end, { desc = "[P]Toggle bullet point (dash)" })

-- -- In visual mode, check if the selected text is already bold and show a message if it is
-- -- If not, surround it with double asterisks for bold
-- vim.keymap.set("v", "<leader>mb", function()
--   -- Get the selected text range
--   local start_row, start_col = unpack(vim.fn.getpos("'<"), 2, 3)
--   local end_row, end_col = unpack(vim.fn.getpos("'>"), 2, 3)
--   -- Get the selected lines
--   local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)
--   local selected_text = table.concat(lines, "\n"):sub(start_col, #lines == 1 and end_col or -1)
--   if selected_text:match("^%*%*.*%*%*$") then
--     vim.notify("Text already bold", vim.log.levels.INFO)
--   else
--     vim.cmd("normal 2gsa*")
--   end
-- end, { desc = "[P]BOLD current selection" })
--
-- -- -- Multiline unbold attempt
-- -- -- In normal mode, bold the current word under the cursor
-- -- -- If already bold, it will unbold the word under the cursor
-- -- -- If you're in a multiline bold, it will unbold it only if you're on the
-- -- -- first line
-- vim.keymap.set("n", "<leader>mb", function()
--   local cursor_pos = vim.api.nvim_win_get_cursor(0)
--   local current_buffer = vim.api.nvim_get_current_buf()
--   local start_row = cursor_pos[1] - 1
--   local col = cursor_pos[2]
--   -- Get the current line
--   local line = vim.api.nvim_buf_get_lines(current_buffer, start_row, start_row + 1, false)[1]
--   -- Check if the cursor is on an asterisk
--   if line:sub(col + 1, col + 1):match("%*") then
--     vim.notify("Cursor is on an asterisk, run inside the bold text", vim.log.levels.WARN)
--     return
--   end
--   -- Search for '**' to the left of the cursor position
--   local left_text = line:sub(1, col)
--   local bold_start = left_text:reverse():find("%*%*")
--   if bold_start then
--     bold_start = col - bold_start
--   end
--   -- Search for '**' to the right of the cursor position and in following lines
--   local right_text = line:sub(col + 1)
--   local bold_end = right_text:find("%*%*")
--   local end_row = start_row
--   while not bold_end and end_row < vim.api.nvim_buf_line_count(current_buffer) - 1 do
--     end_row = end_row + 1
--     local next_line = vim.api.nvim_buf_get_lines(current_buffer, end_row, end_row + 1, false)[1]
--     if next_line == "" then
--       break
--     end
--     right_text = right_text .. "\n" .. next_line
--     bold_end = right_text:find("%*%*")
--   end
--   if bold_end then
--     bold_end = col + bold_end
--   end
--   -- Remove '**' markers if found, otherwise bold the word
--   if bold_start and bold_end then
--     -- Extract lines
--     local text_lines = vim.api.nvim_buf_get_lines(current_buffer, start_row, end_row + 1, false)
--     local text = table.concat(text_lines, "\n")
--     -- Calculate positions to correctly remove '**'
--     -- vim.notify("bold_start: " .. bold_start .. ", bold_end: " .. bold_end)
--     local new_text = text:sub(1, bold_start - 1) .. text:sub(bold_start + 2, bold_end - 1) .. text:sub(bold_end + 2)
--     local new_lines = vim.split(new_text, "\n")
--     -- Set new lines in buffer
--     vim.api.nvim_buf_set_lines(current_buffer, start_row, end_row + 1, false, new_lines)
--     -- vim.notify("Unbolded text", vim.log.levels.INFO)
--   else
--     -- Bold the word at the cursor position if no bold markers are found
--     local before = line:sub(1, col)
--     local after = line:sub(col + 1)
--     local inside_surround = before:match("%*%*[^%*]*$") and after:match("^[^%*]*%*%*")
--     if inside_surround then
--       vim.cmd("normal gsd*.")
--     else
--       vim.cmd("normal viw")
--       vim.cmd("normal 2gsa*")
--     end
--     vim.notify("Bolded current word", vim.log.levels.INFO)
--   end
-- end, { desc = "[P]BOLD toggle bold markers" })


