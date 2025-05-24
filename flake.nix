{
  description = "Flake for cpupower_go";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system}.cpupower_go = pkgs.buildGoModule {
      pname = "cpupower_go";
      version = "0.1.0";

      src = pkgs.fetchFromGitHub {
        owner = "nomispaz";
        repo = "cpupower_go";
        rev = "f06fa7f618c874a879ab178519b897f03fdabdf3";
        sha256 = "sha256-rkk8oH5ShfEoGyVVSHxgBWwAcF5jlYghZRcsVdrw/4s=";  # for the source archive
      };

      vendorHash = "sha256-W7Aj/Jfr4AgAGYW9TdTUEmUqtWDb1G1kI/LUP6pFNNk=";  # temp hash to get the real one

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
