{
  description = "A dev environment for Figura";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        system = "${system}";
        config.allowUnfree = true;
      };
    in {
      devShell = pkgs.mkShell {
        packages = with pkgs; [
          (vscode-with-extensions.override {
            vscodeExtensions = with vscode-extensions; [
              sumneko.lua
            ];
          })
        ];

        shellHook = ''
          exec code .
        '';
      };
    }
  );
}
