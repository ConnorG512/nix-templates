{
  description = "Basic C++23 template flake.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
  };

  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages."${system}";
    
    templates = {
      basic-cpp23 = {
        path = ./basic-cpp23;
        description = "A very basic C++23 template with release and debug builds.";
      };
    };
    defaultTemplate = self.templates.basic-cpp23;

    projectProperties = import ./nix/metadata.nix;
    packages = import ./nix/packages.nix {inherit pkgs;};
    build = ''
      cmake --build build
    '';
    install = ''
      cmake --install build
    '';

  in {
  packages.${system} = {
      debug = pkgs.gccStdenv.mkDerivation {
        pname = projectProperties.name;
        name = projectProperties.name;
        version = projectProperties.version;
        src = ../.;
        dontStrip = true;

        nativeBuildInputs = packages.buildPackages ;
        buildInputs = packages.buildPackages;
        
        configurePhase = ''
          cmake -B build -S . -G Ninja -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$out
        '';
        buildPhase = build;
        installPhase = install;
      };
      
      release = pkgs.gccStdenv.mkDerivation {
        pname = projectProperties.name;
        name = projectProperties.name;
        version = projectProperties.version;
        src = ../.;

        nativeBuildInputs = packages.buildPackages ;
        buildInputs = packages.buildPackages ;
        
        configurePhase = ''
          cmake -B build -S . -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$out
        '';
        buildPhase = build;
        installPhase = install;
      };
    };
  };
}
