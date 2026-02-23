{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    nixvim.url = "github:nix-community/nixvim";
    
    # Plugins that are not in nixpkgs
    "new-plugin:vim-headerguard" = {
      url = "github:drmikehenry/vim-headerguard";
      flake = false;
    };

    #"new-plugin:ft-std-header" = {
    #  url = "github:42Paris/42header";
    #  flake = false;
    #};
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
            #./plugins/headerguard.nix
            #./plugins/lsp-signature.nix
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
