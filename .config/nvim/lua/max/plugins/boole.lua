return {
  "nat-418/boole.nvim",
  event = "InsertEnter",
  opts = {
    mappings = {
      increment = '+',
      decrement = '-'
    },
    additions = {
      { "const",    "let",      "var" },
      { "absolute", "relative", "fixed", "sticky" },
      { "undefined", "null"}
    }
  }
}
