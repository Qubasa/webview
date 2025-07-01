{
  description = "A Nix-flake-based C/C++ development environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell.override
          {
            # Override stdenv in order to change compiler:
            stdenv = pkgs.gccStdenv;
          }
          {
            packages = with pkgs; [
              clang
              clang-tools
              cmake
              doxygen
              pkg-config
            ] ++ (with pkgs.llvmPackages; [
              libcxxStdenv
              libcxxClang
              libunwind
            ])
            ++ (if system == "aarch64-darwin" then [ ] else [ 
              gtk4
              webkitgtk_6_0
              gdb 
            ]);
          };
      });
    };
}

