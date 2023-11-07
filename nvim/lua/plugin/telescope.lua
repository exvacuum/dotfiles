require("telescope").setup {
  extensions = {
    file_browser = {
      hijack_netrw = true,
      hidden = { file_browser = true, folder_browser = true },
      select_buffer = true,
    },
  },
}

require("telescope").load_extension "file_browser"
require("telescope").load_extension("workspaces")
