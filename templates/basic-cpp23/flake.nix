{
  description = "Basic C++23 template flake.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs =  import nixpkgs { inherit system; };   

  in {
    devShells.x86_64-linux.default = pkgs.mkShellNoCC {
      packages = with pkgs; [
        ccls

        cmake
        ninja
      ];
      
      shellHook = ''
      '';
    }; 
  };
}
