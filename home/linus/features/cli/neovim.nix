{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    plugins = with pkgs.vimPlugins; [
      # File tree
      nvim-tree-lua
      
      # Fuzzy finding
      telescope-nvim
      telescope-fzf-native-nvim
      
      # LSP
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
      
      # Treesitter for better syntax highlighting
      (nvim-treesitter.withPlugins (p: [
        p.nix
        p.python
        p.lua
        p.bash
        p.javascript
        p.typescript
        p.json
        p.yaml
        p.markdown
      ]))
      
      # Git integration
      gitsigns-nvim
      vim-fugitive
      
      # UI improvements
      lualine-nvim
      nvim-web-devicons
      
      # Color scheme
      catppuccin-nvim
      
      # Productivity
      comment-nvim
      nvim-autopairs
      indent-blankline-nvim
      which-key-nvim
      
      # Formatting
      neoformat
    ];
    
    extraPackages = with pkgs; [
      # Language servers
      nil  # Nix
      pyright  # Python
      nodePackages.typescript-language-server
      nodePackages.bash-language-server
      lua-language-server
      
      # Formatters
      alejandra  # Nix
      black  # Python
      nodePackages.prettier
      
      # Other tools
      ripgrep
      fd
      tree-sitter
    ];
    
    extraLuaConfig = ''
      -- Basic settings
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.expandtab = true
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2
      vim.opt.smartindent = true
      vim.opt.wrap = false
      vim.opt.swapfile = false
      vim.opt.backup = false
      vim.opt.undofile = true
      vim.opt.hlsearch = false
      vim.opt.incsearch = true
      vim.opt.termguicolors = true
      vim.opt.scrolloff = 8
      vim.opt.signcolumn = "yes"
      vim.opt.updatetime = 50
      vim.opt.colorcolumn = "100"
      
      -- Leader key
      vim.g.mapleader = " "
      
      -- Color scheme
      require("catppuccin").setup({
        flavour = "mocha",
      })
      vim.cmd.colorscheme "catppuccin"
      
      -- Lualine
      require('lualine').setup {
        options = {
          theme = 'catppuccin',
          component_separators = '|',
          section_separators = { left = '', right = '' },
        },
      }
      
      -- Treesitter
      require('nvim-treesitter.configs').setup {
        highlight = { enable = true },
        indent = { enable = true },
      }
      
      -- LSP configuration
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      
      -- Setup language servers
      lspconfig.nil_ls.setup { capabilities = capabilities }
      lspconfig.pyright.setup { capabilities = capabilities }
      lspconfig.tsserver.setup { capabilities = capabilities }
      lspconfig.bashls.setup { capabilities = capabilities }
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          }
        }
      }
      
      -- Completion
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        })
      })
      
      -- Gitsigns
      require('gitsigns').setup()
      
      -- Comment
      require('Comment').setup()
      
      -- Autopairs
      require('nvim-autopairs').setup()
      
      -- Indent blankline
      require('ibl').setup()
      
      -- Which-key
      require('which-key').setup()
      
      -- Nvim-tree
      require('nvim-tree').setup()
      
      -- Telescope
      require('telescope').setup()
      require('telescope').load_extension('fzf')
      
      -- Keymaps
      local keymap = vim.keymap.set
      
      -- File tree
      keymap('n', '<leader>e', ':NvimTreeToggle<CR>')
      
      -- Telescope
      keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
      keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
      keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
      keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
      
      -- LSP
      keymap('n', 'gd', vim.lsp.buf.definition)
      keymap('n', 'K', vim.lsp.buf.hover)
      keymap('n', '<leader>rn', vim.lsp.buf.rename)
      keymap('n', '<leader>ca', vim.lsp.buf.code_action)
      keymap('n', 'gr', vim.lsp.buf.references)
      keymap('n', '<leader>f', vim.lsp.buf.format)
      
      -- Better navigation
      keymap('n', '<C-d>', '<C-d>zz')
      keymap('n', '<C-u>', '<C-u>zz')
      keymap('n', 'n', 'nzzzv')
      keymap('n', 'N', 'Nzzzv')
    '';
  };
}
