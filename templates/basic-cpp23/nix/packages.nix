{ pkgs }:

{
  devshellPackages = [
      pkgs.clang-tools
      pkgs.clang
      pkgs.ninja 
      pkgs.cmake 

      pkgs.scanmem
      pkgs.gef 
      pkgs.strace
  ];

  buildPackages = [
      pkgs.ninja 
      pkgs.cmake 
  ];
}
