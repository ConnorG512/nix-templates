let
  pkgs = import <nixpkgs> {"github:nixos/nixpkgs?ref=nixos-25.05"};
in
pkgs.mkShell {
  packages  = (import ./nix/packages.nix { inherit pkgs; }).devshellPackages;

  shellHook = ''
    echo "entered development shell!"
    cmake -B build -S . -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++
  '';
}
