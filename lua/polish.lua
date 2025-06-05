-- INFO: This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }
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
    -- glsl = "cpp",
  },
}
return {}
