return {
  name = "bash-debug-adapter",
  description = "Bash shell debugger, based on bashdb.",
  homepage = "https://github.com/UltiWebAlt/vscode-bash-debug",
  licenses = { "MIT" },
  languages = { "Bash" },
  categories = { "DAP" },
  source = {
    id = "pkg:github/UltiWebAlt/vscode-bash-debug@v0.4.3",
    asset = { file = "bash-debug-0.4.3.vsix" },
  },
  bin = {
    ["bash-debug-adapter"] = "node:extension/out/bashDebug.js",
  },
  opt = {
    ["bashdb/"] = "extension/bashdb_dir/",
  },
}
