{
  pkgs,
  config,
  helpers,
  lib,
  ...
}: {
  config = {
    colorschemes.tokyonight = {
      settings.style = "night";
      enable = true;
    };

    autoGroups.BigFileOptimizer = {};
    autoCmd = [
      {
        event = "BufReadPost";
        pattern = [
          "*.md"
          "*.rs"
          "*.lua"
          "*.sh"
          "*.bash"
          "*.zsh"
          "*.js"
          "*.jsx"
          "*.ts"
          "*.tsx"
          "*.c"
          "*.h"
          "*.cc"
          "*.hh"
          "*.cpp"
          "*.cph"
        ];
        group = "BigFileOptimizer";
        callback = helpers.mkRaw ''
          function(auEvent)
            local bufferCurrentLinesCount = vim.api.nvim_buf_line_count(0)

            if bufferCurrentLinesCount > 2048 then
              vim.notify("bigfile: disabling features", vim.log.levels.WARN)

              vim.cmd("TSBufDisable refactor.highlight_definitions")
          vim.g.matchup_matchparen_enabled = 0
          require("nvim-treesitter.configs").setup({
           matchup = {
             enable = false
           }
          })
            end
          end
        '';
      }
    ];

    globals = {
      neo_tree_remove_legacy_commands = 1;
      mapleader = " ";
      user42 = "maiboyer";
      mail42 = "maiboyer@student.42.fr";
    };

    opts = {
      termguicolors = true;
      number = true;
      tabstop = 4;
      shiftwidth = 4;
      scrolloff = 7;
      signcolumn = "yes";
      cmdheight = 2;
      cot = ["menu" "menuone" "noselect"];
      updatetime = 100;
      colorcolumn = "80";
      spell = false;
      list = true;
      listchars = "tab:󰁔 ,lead:·,nbsp:␣,trail:•";
      fsync = true;

      timeout = true;
      timeoutlen = 300;
    };

    highlight = {
      IndentBlanklineIndent1 = {
        fg = "#E06C75";
        nocombine = true;
      };
      IndentBlanklineIndent2 = {
        fg = "#E5C07B";
        nocombine = true;
      };
      IndentBlanklineIndent3 = {
        fg = "#98C379";
        nocombine = true;
      };
      IndentBlanklineIndent4 = {
        fg = "#56B6C2";
        nocombine = true;
      };
      IndentBlanklineIndent5 = {
        fg = "#61AFEF";
        nocombine = true;
      };
      IndentBlanklineIndent6 = {
        fg = "#C678DD";
        nocombine = true;
      };
    };

    commands = {
      "SpellFr" = "setlocal spelllang=fr";
    };

    filetype = {
      filename = {
        Jenkinsfile = "groovy";
      };
      extension = {
        lalrpop = "lalrpop";
      };
      extension = {
        c__TEMPLATE__ = "c";
        h__TEMPLATE__ = "c";
      };
    };

    keymaps = let
      modeKeys = mode:
        lib.attrsets.mapAttrsToList (key: action:
          {
            inherit key mode;
          }
          // (
            if builtins.isString action
            then {inherit action;}
            else action
          ));
      all_mode = modeKeys ["n" "v" "i"];
      nm = modeKeys ["n"];
      vs = modeKeys ["v"];
      im = modeKeys ["i"];
    in
      helpers.keymaps.mkKeymaps {options.silent = true;} (
        (all_mode {
          "<A-Left>" = "<C-w><Left>";
          "<A-Right>" = "<C-w><Right>";
          "<A-Up>" = "<C-w><Up>";
          "<A-Down>" = "<C-w><Down>";
          "<S-A-Left>" = "<C-w><";
          "<S-A-Right>" = "<C-w>>";
          "<S-A-Up>" = "<C-w>+";
          "<S-A-Down>" = "<C-w>-";
        })
        ++ (
          nm {
            "ft" = "<cmd>Neotree<CR>";
            "fG" = "<cmd>Neotree git_status<CR>";
            "fR" = "<cmd>Neotree remote<CR>";
            "fc" = "<cmd>Neotree close<CR>";
            "bp" = "<cmd>Telescope buffers<CR>";

            "<C-s>" = "<cmd>w<CR>";
            "<F1>" = "<cmd>:Stdheader<CR>";

            "<leader>w" = "<cmd>Telescope grep_string<CR>";
            "<leader>q" = "<cmd>Telescope live_grep<CR>";
            "mk" = "<cmd>Telescope keymaps<CR>";
            "fg" = "<cmd>Telescope git_files<CR>";
            "gr" = "<cmd>Telescope lsp_references<CR>";
            "gI" = "<cmd>Telescope lsp_implementations<CR>";
            "gW" = "<cmd>Telescope lsp_workspace_symbols<CR>";
            "gF" = "<cmd>Telescope lsp_document_symbols<CR>";
            "ge" = "<cmd>Telescope diagnostics bufnr=0<CR>";
            "gE" = "<cmd>Telescope diagnostics<CR>";

            "<leader>h" = {
              action = "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>";
              options = {
                desc = "toggle inlay hints";
              };
            };
            "yH" = {
              action = "<Cmd>Telescope yank_history<CR>";
              options.desc = "history";
            };
            "<C-:>" = "<Plug>(comment_toggle_linewise_current)";
            "<C-/>" = "<Plug>(comment_toggle_linewise_current)";
          }
        )
        ++ (vs {
          "x" = "dl<CR>";
          "<F1>" = "<cmd>:Stdheader<CR>";
          "<C-:>" = "<Plug>(comment_toggle_linewise_visual)";
          "<C-/>" = "<Plug>(comment_toggle_linewise_current)";
        })
        ++ (im {
          "<C-s>" = "<cmd>w<CR>";
          "<F1>" = "<cmd>:Stdheader<CR>";
          "<C-:>" = "<Plug>(comment_toggle_linewise_current)";
          "<C-/>" = "<Plug>(comment_toggle_linewise_current)";
        })
        ++ [
          {
            key = "<leader>r";
            mode = ["n"];
            action = helpers.mkRaw ''
              function()
              	return ":IncRename " .. vim.fn.expand("<cword>")
              end
            '';
            options.expr = true;
          }
        ]
      );

    clipboard.providers.wl-copy.enable = true;

    plugins.efmls-configs = {
      enable = true;

      toolPackages.mdformat = pkgs.mdformat.withPlugins (ps:
        with ps; [
          # TODO: broken with update of mdformat
          # mdformat-gfm
          mdformat-frontmatter
          mdformat-footnote
          mdformat-tables
          mdit-py-plugins
        ]);

      setup = {
        php = {
          formatter = "djlint";
          linter = "php";
        };
        sh = {
          #linter = "shellcheck";
          formatter = "shfmt";
        };
        bash = {
          #linter = "shellcheck";
          formatter = "shfmt";
        };
        c = {
          linter = "cppcheck";
        };
        markdown = {
          formatter = ["cbfmt" "mdformat"];
        };
        python = {
          formatter = "black";
        };
        nix = {
          linter = "statix";
        };
        lua = {
          formatter = "stylua";
        };
        html = {
          formatter = ["prettier" (helpers.mkRaw "djlint_fmt")];
        };
        htmldjango = {
          formatter = [(helpers.mkRaw "djlint_fmt")];
          linter = "djlint";
        };
        json = {
          formatter = "prettier";
        };
        css = {
          formatter = "prettier";
        };
        ts = {
          formatter = "prettier";
        };
        gitcommit = {
          linter = "gitlint";
        };
      };
    };
    plugins.gitsigns.enable = true;
    plugins.gitmessenger.enable = true;

    plugins.luasnip = {
      enable = true;
    };

    extraConfigLuaPre = ''
      vim.lsp.inlay_hint.enable(true)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      local luasnip = require("luasnip")

      local efm_fs = require('efmls-configs.fs')
      local djlint_fmt = {
        formatCommand = string.format('%s --reformat ''${INPUT} -', efm_fs.executable('djlint')),
        formatStdin = true,
      }
    '';
    # plugins.cmp.settings.snippet.expand= "luasnip";

    plugins.cmp = {
      enable = true;

      settings = {
        snippet.expand = ''
          function(args)
            require('luasnip').lsp_expand(args.body)
          end
        '';
        mapping = {
          "<CR>" = "cmp.mapping.confirm({select = true })";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<Tab>" = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
              -- they way you will only jump inside the snippet region
              elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
              elseif has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end, { "i", "s" })
          '';
          "<S-Tab>" = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { "i", "s" })
          '';
          "<Down>" = "cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'})";
          "<Up>" = "cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'})";
        };

        sources = [
          {name = "luasnip";}
          {name = "nvim_lsp";}
          {name = "path";}
          {name = "buffer";}
          {name = "calc";}
        ];
      };

      filetype.sh = {
        sources = [
          {name = "zsh";}
        ];
      };
    };

    plugins.telescope = {
      enable = true;
      enabledExtensions = ["ui-select"];
      settings = {
        defaults = {
          layout_strategy = "vertical";
          ui-select = helpers.mkRaw ''
            require("telescope.themes").get_dropdown {
              -- even more opts
            }
          '';
        };
      };
    };
    plugins.treesitter = {
      enable = true;
      settings = {
        indent.enable = true;
        highlight.enable = true;
      };
      grammarPackages = with config.plugins.treesitter.package.passthru.builtGrammars; [
        arduino
        bash
        c
        cpp
        cuda
        dart
        devicetree
        diff
        dockerfile
        gitattributes
        gitcommit
        gitignore
        git_rebase
        groovy
        html
        ini
        json
        lalrpop
        latex
        lua
        make
        markdown
        markdown_inline
        meson
        ninja
        nix
        python
        regex
        rst
        rust
        slint
        sql
        tlaplus
        toml
        vim
        vimdoc
        yaml
        mermaid
        fish
      ];

      nixvimInjections = true;
    };

    plugins.treesitter-refactor = {
      enable = true;
      highlightDefinitions = {
        enable = true;
        clearOnCursorMove = true;
      };
      smartRename = {
        enable = true;
      };
      navigation = {
        enable = true;
      };
    };

    plugins.treesitter-context = {
      enable = true;
    };

    plugins.ts-context-commentstring = {
      enable = true;
    };

    plugins.vim-matchup = {
      treesitter = {
        enable = true;
        include_match_words = true;
      };
      enable = true;
    };
    plugins.headerguard.enable = true;

    plugins.comment = {
      enable = true;
      settings = {
        mappings = {
          extra = false;
          basic = false;
        };
        pre_hook = "require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()";
      };
      settings.toggler.line = "<C-/>";
    };

    plugins.neo-tree = {
      enable = true;
    };

    plugins.plantuml-syntax.enable = true;

    plugins.indent-blankline = {
      enable = true;

      settings.scope = {
        enabled = true;
        show_start = true;
      };
    };

    plugins.lsp = {
      enable = true;
      inlayHints = true;
      enabledServers = [];

      keymaps = {
        silent = true;
        lspBuf = {
          "gd" = "definition";
          "gD" = "declaration";
          "<leader>a" = "code_action";
          "ff" = "format";
          "K" = "hover";
        };
      };

      servers = {
        phpactor.enable = true;
        bufls = {
          enable = false;
          package = pkgs.buf;
        };
        nil_ls = {
          enable = true;
          settings = {
            formatting.command = ["${pkgs.alejandra}/bin/alejandra" "--quiet"];
          };
        };
        bashls.enable = true;
        dartls.enable = true;
        clangd.enable = true;
        efm.extraOptions = {
          init_options = {
            documentFormatting = true;
          };
          settings = {
            logLevel = 1;
            languages.meson = [
              (helpers.mkRaw (helpers.toLuaObject {
                prefix = "muon-fmt";
                formatCommand = "muon fmt -";
                formatStdin = true;
              }))
              (helpers.mkRaw (helpers.toLuaObject {
                prefix = "muon-analyze";
                lintSource = "efm/muon-analyze";
                lintCommand = "muon analyze -l";
                lintWorkspace = true;
                lintStdin = false;
                LintIgnoreExitCode = true;
                rootMarkers = ["meson_options.txt" ".git"];
                lintFormats = [
                  "%f:%l:%c: %trror %m"
                  "%f:%l:%c: %tarning %m"
                ];
              }))
            ];
          };
        };
        ruff.enable = true;
        djlsp = {
          enable = true;
          package = null;
        };
        jedi_language_server.enable = true;
        taplo.enable = true;
        pyright.enable = true;
        lemminx.enable = true;
        ltex = {
          enable = true;
          onAttach.function = ''
            require("ltex_extra").setup{
              load_langs = { "en-US", "fr-FR" },
              path = ".ltex",
            }
          '';
          filetypes = [
            "bib"
            "gitcommit"
            "markdown"
            "org"
            "plaintex"
            "rst"
            "rnoweb"
            "tex"
            "pandoc"
            "typst"
            #"mail"
          ];
        };
      };
    };

    #plugins.typst-vim.enable = true;
    plugins.hex.enable = true;
    plugins.comment-box.enable = true;
    plugins.web-devicons.enable = true;
    plugins.rustaceanvim = {
      enable = true;
      settings.server.default_settings.rust-analyzer = {
        cmd = [
          "${pkgs.rust-analyzer}/bin/rust-analyzer"
        ];
        rust-analyzer = {
          check.command = "clippy";
          cargo.features = "all";
          rustc.source = "discover";
          checkOnSave = true;
          inlayHints.lifetimeElisionHints.enable = "always";
        };
      };
    };

    plugins.lspkind = {
      enable = true;
      cmp = {
        enable = true;
      };
    };

    plugins.nvim-lightbulb = {
      enable = true;
      settings.autocmd.enabled = true;
    };

    # plugins.lsp_signature = {
    #   enable = true;
    # };

    plugins.inc-rename = {
      enable = true;
    };

    plugins.clangd-extensions = {
      enable = true;
      enableOffsetEncodingWorkaround = true;

      settings = {
        inlay_hints = {
          right_align = true;
          right_align_padding = 4;
          inline = false;
        };
        ast = {
          role_icons = {
            type = "";
            declaration = "";
            expression = "";
            specifier = "";
            statement = "";
            templateArgument = "";
          };
          kind_icons = {
            compound = "";
            recovery = "";
            translationUnit = "";
            packExpansion = "";
            templateTypeParm = "";
            templateTemplateParm = "";
            templateParamObject = "";
          };
        };
      };
    };

    # fidget = {
    #   enable = true;
    #
    #   sources.null-ls.ignore = true;
    # };

    plugins.none-ls = {
      enable = true;
      sources.formatting.sql_formatter = {
        enable = true;
        package = pkgs.sql-formatter;
      };
    };

    plugins.lualine = {
      enable = true;
    };

    plugins.trouble = {
      enable = true;
    };

    plugins.noice = {
      enable = true;

      settings = {
        messages = {
          view = "mini";
          viewError = "mini";
          viewWarn = "mini";
        };

        lsp.override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };
        presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
          inc_rename = true;
          lsp_doc_border = false;
        };
      };
    };

    plugins.netman = {
      enable = false;
      package = pkgs.vimPlugins.netman-nvim;
      neoTreeIntegration = true;
    };

    extraConfigLuaPost = ''
      require("luasnip.loaders.from_snipmate").lazy_load()

      vim.api.nvim_create_user_command("LtexLangChangeLanguage", function(data)
          local language = data.fargs[1]
          local bufnr = vim.api.nvim_get_current_buf()
          local client = vim.lsp.get_active_clients({ bufnr = bufnr, name = 'ltex' })
          if #client == 0 then
              vim.notify("No ltex client attached")
          else
              client = client[1]
              client.config.settings = {
                  ltex = {
                      language = language
                  }
              }
              client.notify('workspace/didChangeConfiguration', client.config.settings)
              vim.notify("Language changed to " .. language)
          end
        end, {
          nargs = 1,
          force = true,
      })
    '';

    plugins.zk = {
      enable = true;
      settings.picker = "telescope";
    };

    plugins.which-key.enable = true;
    # plugins.ft-std-header.enable = true;

    plugins.leap.enable = true;

    plugins.yanky = {
      enable = true;
      enableTelescope = true;
      settings.picker.telescope.use_default_mappings = true;
    };

    files."ftplugin/nix.lua" = {
      opts = {
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
      };
    };

    files."ftplugin/markdown.lua" = {
      # extraConfigLua = ''
      #   if require("zk.util").notebook_root(vim.fn.expand('%:p')) ~= nil then
      #     local function map(...) vim.api.nvim_buf_set_keymap(0, ...) end
      #     local opts = { noremap=true, silent=false }
      #
      #     -- Open the link under the caret.
      #     map("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
      #
      #     -- Create a new note after asking for its title.
      #     -- This overrides the global `<leader>zn` mapping to create the note in the same directory as the current buffer.
      #     map("n", "<leader>zn", "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
      #     -- Create a new note in the same directory as the current buffer, using the current selection for title.
      #     map("v", "<leader>znt", ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", opts)
      #     -- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
      #     map("v", "<leader>znc", ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
      #
      #     -- Open notes linking to the current buffer.
      #     map("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", opts)
      #     -- Alternative for backlinks using pure LSP and showing the source context.
      #     --map('n', '<leader>zb', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
      #     -- Open notes linked by the current buffer.
      #     map("n", "<leader>zl", "<Cmd>ZkLinks<CR>", opts)
      #
      #     -- Preview a linked note.
      #     map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
      #     -- Open the code actions for a visual selection.
      #     map("v", "<leader>za", ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts)
      #   end
      # '';
    };

    extraPackages = with pkgs; [
      /*
      sca2d
      */
      djlint
      muon
    ];

    extraPlugins = with pkgs.vimPlugins; [
      telescope-ui-select-nvim
      vim-snippets
      markdown-preview-nvim
      ft-std-header
    ];
  };
}
