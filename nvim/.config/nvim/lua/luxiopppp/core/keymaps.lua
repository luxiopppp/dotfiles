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

keymap.set("n", "K", ":m .-2<CR>==", { desc= "Move line up" })
keymap.set("n", "J", ":m .+1<CR>==", { desc= "Move line down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc= "Move lines up" })
keymap.set("v", "J", ":m '<+1<CR>gv=gv", { desc= "Move lines down" })

keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice Message" })

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


