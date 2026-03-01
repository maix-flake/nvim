{
  pkgs,
  config,
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
      #{
      #  event = "BufReadPost";
      #  pattern = [
      #    "*.md"
      #    "*.rs"
      #    "*.lua"
      #    "*.sh"
      #    "*.bash"
      #    "*.zsh"
      #    "*.js"
      #    "*.jsx"
      #    "*.ts"
      #    "*.tsx"
      #    "*.c"
      #    "*.h"
      #    "*.cc"
      #    "*.hh"
      #    "*.cpp"
      #    "*.cph"
      #  ];
      #  group = "BigFileOptimizer";
      #}
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
      lib.nixvim.keymaps.mkKeymaps {options.silent = true;} (
        (all_mode {
          "<A-Left>" = "<C-w><Left>";
          "<A-Right>" = "<C-w><Right>";
          "<A-Up>" = "<C-w><Up>";
          "<A-Down>" = "<C-w><Down>";
          "<S-A-Left>" = "<C-w><";
          "<S-A-Right>" = "<C-w>>";
          "<S-A-Up>" = "<C-w>+";
          "<S-A-Down>" = "<C-w>-";
          "<C-:>" = "<Plug>(comment_toggle_linewise_current)";
          "<C-/>" = "<Plug>(comment_toggle_linewise_current)";
          "<C-s>" = "<cmd>w<CR>";
        })
        ++ (
          nm {
            "ft" = "<cmd>Neotree<CR>";
            "fG" = "<cmd>Neotree git_status<CR>";
            "fR" = "<cmd>Neotree remote<CR>";
            "fc" = "<cmd>Neotree close<CR>";
            "bp" = "<cmd>Telescope buffers<CR>";

            "<leader>w" = "<cmd>Telescope grep_string<CR>";
            "<leader>q" = "<cmd>Telescope live_grep<CR>";
            "<leader>d" = "<cmd>Telescope diagnostics bufnr=0<CR>";
            "<leader>D" = "<cmd>Telescope diagnostics<CR>";

            "mk" = "<cmd>Telescope keymaps<CR>";
            "fg" = "<cmd>Telescope git_files<CR>";
            "gr" = "<cmd>Telescope lsp_references<CR>";
            "gI" = "<cmd>Telescope lsp_implementations<CR>";
            "gW" = "<cmd>Telescope lsp_workspace_symbols<CR>";
            "gF" = "<cmd>Telescope lsp_document_symbols<CR>";

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
          }
        )
        ++ (vs {
          "x" = "dl<CR>";
        })
        ++ (im {})
        ++ [
          {
            key = "<leader>r";
            mode = ["n"];
            action = lib.nixvim.mkRaw ''
              function()
              	return ":IncRename " .. vim.fn.expand("<cword>")
              end
            '';
            options.expr = true;
          }
        ]
      );

    clipboard.providers.wl-copy.enable = true;
    plugins = {

      luasnip = {
        enable = true;
        autoLoad = true;
      };
      efmls-configs = {
        enable = true;

        toolPackages.mdformat = pkgs.mdformat;
        #.withPlugins (ps:
        #  with ps; [
        #    # TODO: broken with update of mdformat
        #    # mdformat-gfm
        #    mdformat-frontmatter
        #    mdformat-footnote
        #    mdformat-tables
        #    mdit-py-plugins
        #  ]);

        languages = {
          htmldjango = {
            formatter = [(lib.nixvim.mkRaw "djlint_fmt")];
            linter = "djlint";
          };

          bash = {formatter = "shfmt";};
          c = {linter = "cppcheck";};
          css = {formatter = "prettier";};
          gitcommit = {linter = "gitlint";};
          html = {formatter = ["prettier" (lib.nixvim.mkRaw "djlint_fmt")];};
          javacript = {formatter = "prettier";};
          json = {formatter = "prettier";};
          lua = {formatter = "stylua";};
          markdown = {formatter = ["cbfmt" "mdformat"];};
          nix = {linter = "statix";};
          python = {formatter = "black";};
          sh = {formatter = "shfmt";};
          typescript = {formatter = "prettier";};
        };
      };
      gitsigns.enable = true;
      gitmessenger.enable = true;

      cmp = {
        enable = true;

        settings = {
          snippet.expand = ''
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
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
            "<S-Tab>" = ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
            "<Down>" = "cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'})";
            "<Up>" = "cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'})";
          };

          sources = [
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

      telescope = {
        enable = true;
        enabledExtensions = ["ui-select"];
        settings = {
          defaults = {
            layout_strategy = "vertical";
            ui-select = lib.nixvim.mkRaw ''
              require("telescope.themes").get_dropdown {
                -- even more opts
              }
            '';
          };
        };
      };
      treesitter = {
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

      treesitter-refactor = {
        enable = false;
        settings = {
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
      };

      treesitter-context = {
        enable = true;
      };

      ts-context-commentstring = {
        enable = true;
      };

      vim-matchup = {
        treesitter = {
          enable = false;
          include_match_words = false;
        };
        enable = false;
      };
      #headerguard.enable = true;

      comment = {
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

      neo-tree = {
        enable = true;
      };

      plantuml-syntax.enable = true;

      indent-blankline = {
        enable = true;

        settings.scope = {
          enabled = true;
          show_start = true;
        };
      };

      lsp = {
        enable = true;
        inlayHints = true;

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
          bashls.enable = true;
          clangd.enable = true;
          dartls.enable = true;
          eslint.enable = true;
          html.enable = true;
          jedi_language_server.enable = true;
          lemminx.enable = true;
          nginx_language_server.enable = true;
          phpactor.enable = true;
          pyright.enable = true;
          ruff.enable = true;
          taplo.enable = true;
          ts_ls.enable = true;

          djlsp = {
            enable = true;
            package = pkgs.djlint;
          };
          nil_ls = {
            enable = true;
            settings = {
              formatting.command = ["${pkgs.alejandra}/bin/alejandra" "--quiet"];
            };
          };
          efm.extraOptions = {
            enable = true;
            init_options = {
              documentFormatting = true;
            };
            settings = {
              logLevel = 1;
            };
          };
        };
      };

      hex.enable = true;
      comment-box.enable = true;
      web-devicons.enable = true;
      rustaceanvim = {
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

      lspkind = {
        enable = true;
        cmp = {
          enable = true;
        };
      };

      nvim-lightbulb = {
        enable = true;
        settings.autocmd.enabled = true;
      };

      inc-rename = {
        enable = true;
      };

      clangd-extensions = {
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

      none-ls = {
        enable = true;
        sources.formatting = {
          sql_formatter = {
            enable = true;
            package = pkgs.sql-formatter;
          };
        };
      };

      lualine = {
        enable = true;
      };

      trouble = {
        enable = true;
      };

      noice = {
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

      netman = {
        enable = false;
        package = pkgs.vimPlugins.netman-nvim;
        neoTreeIntegration = true;
      };
      zk = {
        enable = true;
        settings.picker = "telescope";
      };

      which-key.enable = true;

      leap.enable = true;

      yanky = {
        enable = true;
        enableTelescope = true;
        settings.picker.telescope.use_default_mappings = true;
      };
    };

    files = {
      "ftplugin/nix.lua" = {
        opts = {
          tabstop = 2;
          shiftwidth = 2;
          expandtab = true;
        };
      };
    };
    extraConfigLuaPre = ''
      vim.lsp.inlay_hint.enable(true)
    '';

    extraPackages = [];

    extraPlugins = with pkgs.vimPlugins; [
      telescope-ui-select-nvim
      vim-snippets
      markdown-preview-nvim
    ];
  };
}
