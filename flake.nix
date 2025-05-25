{
  description = "Flake for cpupower_go";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system}.cpupower_go = pkgs.buildGoModule {
      pname = "cpupower_go";
      version = "0.1.2";

      src = pkgs.fetchFromGitHub {
        owner = "nomispaz";
        repo = "cpupower_go";
        rev = "dd4d88b6ee9ca3b89136d2990aefb17cbccda1a3";
        sha256 = pkgs.lib.fakeHash;  # for the source archive
      };

      vendorHash = null;  # temp hash to get the real one

      preBuild = ''
        export GOWORK=off
      '';

      meta = {
        description = "Simple wrapper writte in go for cpupower";
        homepage = "https://github.com/nomispaz/cpupower";
        license = pkgs.lib.licenses.gpl3;
      };
    };

    defaultPackage.${system} = self.packages.${system}.cpupower_go;
  };
}
