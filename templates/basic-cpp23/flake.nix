{
  description = "Basic C++23 template flake.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs =  import nixpkgs { inherit system; };   

    projectInfo = {
      projectName = "App";
      execName = "app";
      version = "indev";
    };

    derivations = {
      release = pkgs.stdenv.mkDerivation {
        pname = projectInfo.projectName;
        name = projectInfo.execName;
        version = projectInfo.version; 
        src = ./.;
          
        nativeBuildInputs = with pkgs; [
          cmake
          ninja
        ];
        
        buildInputs = with pkgs; [ ];
        
        cmakeFlags = [
          "-DCMAKE_BUILD_TYPE=Release"
          "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON"
        ];
        
        configurePhase = ''
          cmake -B build -S . -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Release
        '';

        buildPhase = ''
          cmake --build build 
        '';

        installPhase = ''
          mkdir -p $out/bin
          cp build/compile_commands.json $out/bin
          cp build/${projectInfo.execName} $out/bin
        '';
      };
    };
  in {
    devShells.x86_64-linux.default = pkgs.mkShellNoCC {
      packages = with pkgs; [
        ccls
        
        gef
        strace 
      ];
      
      shellHook = ''
        echo "Entering shell!"
      '';
    }; 
    
    packages.x86_64-linux.default = derivations.release;
  };
}
