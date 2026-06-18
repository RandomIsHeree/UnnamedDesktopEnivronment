{
  lib,
  mkShell,
  stdenv,
  nasm,
  python3,
  cmake,
  gnumake,
  unzip,
  zip,
  ninja,
  curl,
  jetbrains,
  gtk3,
  gtk4,
  libogg,
  flac,
  opus-tools,
  opus,
  glib,
  pkg-config,
  godot,
  inputs
}:
let
  inherit (inputs) fenix;
  rs-toolchain = with fenix.packages.${stdenv.system}; combine [
    latest.toolchain
    targets.wasm32-unknown-unknown.latest.rust-std
  ];
in
mkShell (finalAttrs: {
  buildInputs = [
    nasm
    python3
    cmake
    gnumake
    unzip
    zip
    ninja
    curl
    jetbrains.idea 
    godot

    rs-toolchain
  ];

  nativeBuildInputs = [
    # Torque3D deps
    gtk3
    libogg
    flac
    opus-tools
    opus
    pkg-config

    # Other deps
    gtk4
  ];

  runtimeLibs = lib.optionals stdenv.isLinux [
    gtk4
    glib
  ];

  shellHook = ''
    export LD_LIBRARY_PATH=${lib.makeLibraryPath finalAttrs.runtimeLibs}
  '';
})
