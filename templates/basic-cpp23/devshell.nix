with import <nixpkgs> { };

mkShell {
  packages = import ./nix/packages.nix
  shellHook = ''
    echo "entered development shell!"
    cmake -B build -S . -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++
  '';
}
