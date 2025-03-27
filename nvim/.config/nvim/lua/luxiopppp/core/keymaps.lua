vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "qq", "<ESC>", { desc = "Exit insert mode" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment num"})
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement num"})

-- keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
-- keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
-- keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
-- keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

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

keymap.set("n", "<leader>ik", function ()
  vim.fn.system("$HOME/.scripts/imagefromkde.sh")
end, { desc = "Copy last image from KDE Connect" })
keymap.set("n", "<leader>if", function ()
  local actions = require("telescope.actions")

  require("telescope.builtin").find_files({
    cwd = "~/Documents/kde_connect/",
    attach_mappings = function (_, map)
      map("i", "<CR>", function (prompt_buffer)
        local selection = require("telescope.actions.state").get_selected_entry()
        actions.close(prompt_buffer)
        vim.fn.system("$HOME/.scripts/imagefromkde.sh", selection.path)
      end)
      return true
    end
  })
end, { desc = "Copy image from Telescope" })

keymap.set("n", "<leader>sne", function ()
  require("scissors").editSnippet()
end, { desc = "Edit Snippet"})

keymap.set({ "n", "x" }, "<leader>sna", function ()
  require("scissors").addNewSnippet()
end, { desc = "Add new snippet"})

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

keymap.set('n', '<leader>ml', function ()
  local line = vim.api.nvim_get_current_line()
  if line:match("^%- %[%s?%] ") then
    line = line:gsub("^%- %[%] ", "", 1)
  else
    line = "- [ ] " .. line
  end

  vim.api.nvim_set_current_line(line)
end, { remap = true, silent = false, desc = 'Toggle markdown list item on line' })

keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>", { desc = 'Toggle markdown preview (on browser)' })

keymap.set("n", "<leader>cb", function()
  local file = vim.fn.expand("%") -- Get the current file name
  local first_line = vim.fn.getline(1) -- Get the first line of the file
  if string.match(first_line, "^#!/") then -- If first line contains shebang
    local escaped_file = vim.fn.shellescape(file) -- Properly escape the file name for shell commands
    vim.cmd(
      "silent !tmux split-window -h -l 60 'bash -c \""
        .. escaped_file
        .. "; echo; echo Press any key to exit...; read -n 1; exit\"'"
    )
  else
    vim.cmd("echo 'Not a script. Shebang line not found.'")
  end
end, { desc = "BASH, execute file" })

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
