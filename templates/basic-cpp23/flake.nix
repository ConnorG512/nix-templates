{
  description = "Basic C++23 template flake.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages."${system}";
    
    projectProperties = {
      name = "App";
      version = "indev";
    };

    devShell = import ./nix/devshell.nix { inherit pkgs projectProperties; };
    derivations = import ./nix/derivation.nix { inherit pkgs projectProperties; };
    
    templates = {
      basic-cpp23 = {
        path = ./basic-cpp23;
        description = "A very basic C++23 template with release and debug builds.";
      };
    };
    defaultTemplate = self.templates.basic-cpp23;

  in {

    devShells."${system}" = {
      default = devShell.default;
    }; 

    derivations."${system}" = {
      gcc.debug = derivations.gcc.debug;
      gcc.release = derivations.gcc.release;
    };
  };
}
