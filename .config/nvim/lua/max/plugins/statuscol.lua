return {
  "luukvbaal/statuscol.nvim",
  event = "BufReadPost",
  config = function()
    local builtin = require("statuscol.builtin")

    -- Helper function to check if there are any signs placed
    local function has_signs()
      return vim.fn.sign_getplaced('', { group = '*' })[1].signs ~= nil
    end

    -- Define custom sign for breakpoints
    vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'Error', linehl = '', numhl = '' })

    -- Fold settings
    vim.o.foldcolumn = "1" -- '0' is not bad
    vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.opt.fillchars = {
      fold = " ",
      foldsep = " ",
      foldopen = " ",
      foldclose = "",
      diff = "╱",
    }

    -- Statuscol setup
    require("statuscol").setup({
      relculright = true,
      ft_ignore = { "neo-tree" },
      segments = {
        {
          sign = { namespace = { "diagnostic/signs" }, maxwidth = 1, auto = true },
          condition = { builtin.not_empty, true, builtin.not_empty },
          click = "v:lua.ScSa"
        },
        { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
        {
          text = { " " },
          condition = { has_signs },
        },
        {
          sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
          condition = { builtin.not_empty },
          click = "v:lua.ScSa"
        },
        {
          text = { builtin.foldfunc, " " },
          condition = { builtin.not_empty, true, builtin.not_empty },
          click = "v:lua.ScFa"
        },
        {
          sign = { name = { 'coverage*' }, maxwidth = 1, auto = true },
          condition = { builtin.not_empty, true, builtin.not_empty },
          click = 'v:lua.ScSa'
        },
      },
    })
  end,
}

