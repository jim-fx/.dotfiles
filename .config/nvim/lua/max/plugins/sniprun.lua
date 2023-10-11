return {
  "michaelb/sniprun",
  event = "BufRead",
  opts = {
    selected_interpreters = { "JS_TS_deno" },
    repl_enable = { "JS_TS_deno" }
  },
  build = "bash ./install.sh",
}
