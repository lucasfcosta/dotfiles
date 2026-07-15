-- Shorthand fn and opts obj to define silent, non-recursive mappings
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Disable arrow keys in normal, insert, and visual modes
-- This encourages the use of hjkl for movement and improves muscle memory

-- Normal mode
map("n", "<Up>",    "<nop>", opts)
map("n", "<Down>",  "<nop>", opts)
map("n", "<Left>",  "<nop>", opts)
map("n", "<Right>", "<nop>", opts)

-- Insert mode
map("i", "<Up>",    "<nop>", opts)
map("i", "<Down>",  "<nop>", opts)
map("i", "<Left>",  "<nop>", opts)
map("i", "<Right>", "<nop>", opts)

-- Visual mode
map("v", "<Up>",    "<nop>", opts)
map("v", "<Down>",  "<nop>", opts)
map("v", "<Left>",  "<nop>", opts)
map("v", "<Right>", "<nop>", opts)

-- Navigate through quickfix more quickly
map("n", "<leader>qn", "<cmd>cnext<CR>", { desc = "Quickfix next" })
map("n", "<leader>qp", "<cmd>cprev<CR>", { desc = "Quickfix prev" })

-- Git review commands
-- :Review           -> diff vs the remote default branch (origin/HEAD),
--                      so a stale local main never pollutes the review
-- :Review <base>    -> diff vs <base>, e.g. the parent branch of a stacked PR
-- :Review <pr-url>  -> diff that PR's head branch vs its base branch
local function review_pr(url)
  local out = vim.fn.system("gh pr view " .. vim.fn.shellescape(url) .. " --json baseRefName,headRefName 2>&1")
  if vim.v.shell_error ~= 0 then
    vim.notify("gh pr view failed: " .. out, vim.log.levels.ERROR)
    return
  end
  local pr = vim.json.decode(out)
  vim.fn.system(("git fetch origin %s %s"):format(pr.baseRefName, pr.headRefName))
  if vim.v.shell_error ~= 0 then
    vim.notify("could not fetch PR branches from origin (fork PRs not supported)", vim.log.levels.ERROR)
    return
  end
  vim.cmd(("DiffviewOpen origin/%s...origin/%s --imply-local"):format(pr.baseRefName, pr.headRefName))
end

local function review_branch(cmd_opts)
  local ref = cmd_opts.args
  if ref:find("/pull/") or ref:find("^https?://") then
    return review_pr(ref)
  end
  if ref == "" then
    ref = vim.fn.systemlist("git rev-parse --abbrev-ref origin/HEAD 2>/dev/null")[1]
    if vim.v.shell_error ~= 0 or not ref then
      ref = "origin/main"
    end
  end
  vim.cmd("DiffviewOpen " .. ref .. "...HEAD --imply-local")
end

local function branch_names()
  return vim.fn.systemlist("git for-each-ref --format='%(refname:short)' refs/heads refs/remotes 2>/dev/null")
end

vim.api.nvim_create_user_command("Review", review_branch, {
  desc = "Review branch vs origin default branch (or a given base)",
  nargs = "?",
  complete = branch_names,
})
vim.api.nvim_create_user_command("ReviewClose", "DiffviewClose", { desc = "Close the review" })
vim.api.nvim_create_user_command("FileHistory", "DiffviewFileHistory %", { desc = "Git history of current file" })
