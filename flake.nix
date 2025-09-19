{
  description = "dotnet env";
  nixConfig.bash-prompt-prefix = "[nix(dotnet)] ";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
      in
      with pkgs;
      {
        devShells.default = mkShell {
          name = "dotnet env";
          buildInputs = [
            dotnet-sdk_8
            codex
            claude-code
            natscli
            nats-server
          ];
          shellHook = ''
            export DOTNET_ROOT="${dotnet-sdk_8}/share/dotnet"
          '';
        };
      }
    );
}
