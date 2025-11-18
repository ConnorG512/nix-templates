{ pkgs, projectProperties, ... }:

{
  default = pkgs.mkShell {
    packages = with pkgs; [
      clang-tools
      clang
      ninja 
      cmake 

      scanmem
      gef 
    ];

    shellHook = ''
      echo "entering ${projectProperties.name} shell!"
      echo "To configure the project..."
      echo "Run: \"cmake -B build -S . -DUSING_NIX=ON -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DNIX_PROJECT_NAME=${projectProperties.name}\"."
    '';
  };
}
