{
  description = "A dev environment for lua";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = { self, nixpkgs, flake-utils, nix-vscode-extensions }: 
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        system = "${system}";
      };
    in {
      devShell = pkgs.mkShell {
        packages = with pkgs; [
          bashInteractive
          (vscode-with-extensions.override {
            vscode = vscodium;
            vscodeExtensions = with nix-vscode-extensions.extensions.${system}.vscode-marketplace; [
              pkgs.vscode-extensions.sumneko.lua
              mhutchie.git-graph
              aaron-bond.better-comments
            ];
          })
        ];

        shellHook = ''
          exec codium --verbose .
        '';
      };
    }
  );
}
