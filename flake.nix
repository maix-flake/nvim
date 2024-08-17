{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Plugins in nixpkgs
    "plugin:clangd_extensions-nvim" = {
      url = "github:p00f/clangd_extensions.nvim";
      flake = false;
    };
    "plugin:netman-nvim" = {
      url = "github:miversen33/netman.nvim";
      flake = false;
    };
    "plugin:cmp-buffer" = {
      url = "github:hrsh7th/cmp-buffer";
      flake = false;
    };
    "plugin:cmp-calc" = {
      url = "github:hrsh7th/cmp-calc";
      flake = false;
    };
    "plugin:cmp-nvim-lsp" = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };
    "plugin:cmp-path" = {
      url = "github:hrsh7th/cmp-path";
      flake = false;
    };
    "plugin:cmp_luasnip" = {
      url = "github:saadparwaiz1/cmp_luasnip";
      flake = false;
    };
    "plugin:comment-nvim" = {
      url = "github:numtostr/comment.nvim";
      flake = false;
    };
    "plugin:git-messenger-vim" = {
      url = "github:rhysd/git-messenger.vim";
      flake = false;
    };
    "plugin:gitsigns-nvim" = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };
    "plugin:inc-rename-nvim" = {
      url = "github:smjonas/inc-rename.nvim";
      flake = false;
    };
    "plugin:indent-blankline-nvim" = {
      url = "github:lukas-reineke/indent-blankline.nvim";
      flake = false;
    };
    "plugin:lspkind-nvim" = {
      url = "github:onsails/lspkind.nvim";
      flake = false;
    };
    "plugin:lualine-nvim" = {
      url = "github:nvim-lualine/lualine.nvim";
      flake = false;
    };
    "plugin:noice-nvim" = {
      url = "github:folke/noice.nvim";
      flake = false;
    };
    "plugin:nui-nvim" = {
      url = "github:MunifTanjim/nui.nvim";
      flake = false;
    };
    "plugin:nvim-cmp" = {
      url = "github:hrsh7th/nvim-cmp";
      flake = false;
    };
    "plugin:nvim-lightbulb" = {
      url = "github:kosayoda/nvim-lightbulb";
      flake = false;
    };
    "plugin:nvim-lspconfig" = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };
    "plugin:nvim-notify" = {
      url = "github:rcarriga/nvim-notify";
      flake = false;
    };
    "plugin:nvim-osc52" = {
      url = "github:ojroques/nvim-osc52";
      flake = false;
    };
    "plugin:nvim-tree-lua" = {
      url = "github:nvim-tree/nvim-tree.lua";
      flake = false;
    };
    "plugin:nvim-treesitter-context" = {
      url = "github:nvim-treesitter/nvim-treesitter-context";
      flake = false;
    };
    "plugin:nvim-treesitter-refactor" = {
      url = "github:nvim-treesitter/nvim-treesitter-refactor";
      flake = false;
    };
    "plugin:plantuml-syntax" = {
      url = "github:aklt/plantuml-syntax";
      flake = false;
    };
    "plugin:plenary-nvim" = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };
    "plugin:rustaceanvim" = {
      url = "github:mrcjkb/rustaceanvim";
      flake = false;
    };
    "plugin:telescope-nvim" = {
      url = "github:nvim-telescope/telescope.nvim";
      flake = false;
    };
    "plugin:telescope-ui-select-nvim" = {
      url = "github:nvim-telescope/telescope-ui-select.nvim";
      flake = false;
    };
    "plugin:trouble-nvim" = {
      url = "github:folke/trouble.nvim";
      flake = false;
    };
    "plugin:vim-matchup" = {
      url = "github:andymass/vim-matchup";
      flake = false;
    };
    "plugin:luasnip" = {
      url = "github:L3MON4D3/LuaSnip";
      flake = false;
    };
    "plugin:nvim-treesitter" = {
      url = "github:nvim-treesitter/nvim-treesitter";
      flake = false;
    };
    #"plugin:openscad-nvim" = {
    #  url = "github:salkin-mada/openscad.nvim";
    #  flake = false;
    #};
    "plugin:neo-tree-nvim" = {
      url = "github:nvim-neo-tree/neo-tree.nvim";
      flake = false;
    };
    "plugin:nvim-web-devicons" = {
      url = "github:nvim-tree/nvim-web-devicons";
      flake = false;
    };
    "plugin:popup-nvim" = {
      url = "github:nvim-lua/popup.nvim";
      flake = false;
    };
    "plugin:skim-vim" = {
      url = "github:lotabout/skim.vim";
      flake = false;
    };
    "plugin:tokyonight-nvim" = {
      url = "github:folke/tokyonight.nvim";
      flake = false;
    };
    "plugin:vim-snippets" = {
      url = "github:honza/vim-snippets";
      flake = false;
    };
    "plugin:markdown-preview-nvim" = {
      url = "github:iamcco/markdown-preview.nvim";
      flake = false;
    };
    "plugin:which-key-nvim" = {
      url = "github:folke/which-key.nvim";
      flake = false;
    };
    "plugin:zk-nvim" = {
      url = "github:mickael-menu/zk-nvim";
      flake = false;
    };
    "plugin:efmls-configs-nvim" = {
      url = "github:creativenull/efmls-configs-nvim";
      flake = false;
    };
    "plugin:vim-just" = {
      url = "github:NoahTheDuke/vim-just/";
      flake = false;
    };
    "plugin:ltex_extra-nvim" = {
      url = "github:barreiroleo/ltex_extra.nvim";
      flake = false;
    };

    # Plugins that are not in nixpkgs
    "new-plugin:vim-headerguard" = {
      url = "github:drmikehenry/vim-headerguard";
      flake = false;
    };

    "new-plugin:ft-std-header" = {
      url = "github:42Paris/42header";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixvim,
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system:
      with builtins; let
        module = {
          imports = [
            ./config.nix
            ./plugins/headerguard.nix
            ./plugins/lsp-signature.nix
            ./modules
          ];
        };

        inputsMatching = prefix:
          pkgs.lib.mapAttrs'
          (prefixedName: value: {
            name = substring (stringLength "${prefix}:") (stringLength prefixedName) prefixedName;
            inherit value;
          })
          (pkgs.lib.filterAttrs
            (name: _: (match "${prefix}:.*" name) != null)
            inputs);

        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (final: prev: {
              vimPlugins =
                prev.vimPlugins
                // (pkgs.lib.mapAttrs (
                  pname: src:
                    prev.vimPlugins."${pname}".overrideAttrs (old: {
                      inherit src;
                      version = src.shortRev;
                    })
                ) (inputsMatching "plugin"))
                // (
                  pkgs.lib.mapAttrs (
                    pname: src:
                      prev.vimUtils.buildVimPlugin {
                        inherit pname src;
                        version = src.shortRev;
                      }
                  ) (inputsMatching "new-plugin")
                );
            })
            (final: prev: {
              djlint = prev.djlint.overrideAttrs {
                patches = [./patches/djlint-regex-version.patch];
              };
            })
          ];
        };

        nixvim' = nixvim.legacyPackages."${system}";
        nvim = nixvim'.makeNixvimWithModule {inherit module pkgs;};
      in {
        checks.launch = nixvim.lib."${system}".check.mkTestDerivationFromNvim {
          inherit nvim;
          name = "Neovim Configuration";
        };
        formatter = pkgs.alejandra;

        devShells.default = pkgs.mkShell {
          packages = [nvim];
        };

        packages = {
          inherit nvim;
          inherit (pkgs.vimPlugins) nvim-treesitter;
          #upstream = module.package;
          default = nvim;
        };
      });
}
