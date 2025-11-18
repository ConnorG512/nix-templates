{ pkgs, projectProperties, ... }:

{
  gcc = 
  let 
    buildDeps = with pkgs; [
      cmake 
      ninja 
    ];

  in {
    debug = pkgs.gccStdenv.mkDerivation {
      pname = projectProperties.name;
      version = projectProperties.version;
      src = ../.;
      dontStrip = true;

      nativeBuildInputs = buildDeps;
      buildInputs = with pkgs; [];
      
      configurePhase = ''
        cmake -B build -S . -G Ninja -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$out
      '';

      buildPhase = ''
        cmake --build build
      '';
      
      installPhase = ''
        cmake --install build
      '';
    };
    
    release = pkgs.gccStdenv.mkDerivation {
      pname = projectProperties.name;
      version = projectProperties.version;
      src = ../.;

      nativeBuildInputs = buildDeps;
      buildInputs = with pkgs; [];
      
      configurePhase = ''
        cmake -B build -S . -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$out
      '';

      buildPhase = ''
        cmake --build build
      '';
      
      installPhase = ''
        cmake --install build
      '';
    };
  };
}
