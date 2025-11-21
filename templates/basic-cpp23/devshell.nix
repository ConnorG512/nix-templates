with import <nixpkgs> { };

mkShell {
  packages = [
    clang-tools
    clang
    cmake
    ninja
  ];

  shellHook = ''
    echo "entered development shell!"
    cmake -B build -S . -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++
  '';
}
