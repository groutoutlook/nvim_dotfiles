-- INFO: This will run last in the setup process and is a good place to configure
-- filetype function.
vim.filetype.add {
  extension = {
    kbd = "lisp",
    tmp = "markdown",
    ini = "markdown",
    jrnl = "markdown",
    zshrc = "zsh",
    hlsl = "cpp",
    vert = "glsl",
    frag = "glsl",
    geom = "glsl",
  },
}
return {}
