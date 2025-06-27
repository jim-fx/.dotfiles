return {
  'https://codeberg.org/esensar/nvim-dev-container',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  commands = {
    "DevcontainerStart",
    "DevcontainerAttach",
    "DevcontainerExec",
    "DevcontainerStop",
    "DevcontainerStopAll",
    "DevcontainerRemoveAll",
    "DevcontainerLogs",
    "DevcontainerEditNearestConfig",
  },
  event = "VeryLazy",
  opts = {
    autocommands = {
      init = "ask"
    }
  }
}
