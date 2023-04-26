{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    buildInputs = [
        pkgs.pkg-config
        pkgs.curl.dev
        pkgs.gmp
        pkgs.gsl
        pkgs.opam
        pkgs.python
        pkgs.openssl
        pkgs.zlib
        pkgs.czmq
      ] ++ (if pkgs.stdenv.isDarwin then (with pkgs.darwin.apple_sdk.frameworks; [
        Accelerate
      ]) else [
      ]);
}
