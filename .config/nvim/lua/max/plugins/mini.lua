return {
  'echasnovski/mini.nvim',
  version = false,
  event = "VeryLazy",
  config = function()
    require("mini.comment").setup({
    })

    require("mini.pairs").setup({
      mappings = {
        ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
      }
    })

    require("mini.surround").setup({
    })

    -- require("mini.animate").setup({
    --   cursor = {
    --     enable = true,
    --   },
    --   resize = {
    --     enable = false
    --   }
    -- })
    --
  end
}
