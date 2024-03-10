return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = { style = "moon" },
  },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  -- rely on nixos installed treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    dev = true,
    main = "nvim-treesitter.configs",
    opts = {
      auto_install = false,
      autotag = {
        enable = true,
      },
      indent = {
        enable = true,
        disable = { "yaml" },
      },
    },
  },
  -- disable mason
  -- {
  --   "williamboman/mason.nvim",
  --   enabled = false,
  -- },
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   enabled = false,
  -- },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-ci" },
        },
      },
    },
  },
  { "christoomey/vim-tmux-navigator" },
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    opts = {
      -- whether to automatically load preview when
      -- entering another markdown buffer
      auto_load = true,
      -- close preview window on buffer delete
      close_on_bdelete = true,

      -- syntax = true,            -- enable syntax highlighting, affects performance

      theme = "dark", -- 'dark' or 'light'

      update_on_change = true,

      -- relevant if update_on_change is true
      throttle_at = 200000,   -- start throttling when file exceeds this
      -- amount of bytes in size
      throttle_time = "auto", -- minimum amount of time in milliseconds
      -- that has to pass before starting new render
    },
    init = function()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
}
