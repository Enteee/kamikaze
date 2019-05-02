with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "kamikaze";
  authors = [ "Ente <ducksource@duckpond.ch>" ];

  nativeBuildInputs = [
    #latest.rustChannels.nightly.rust
    (import ./rust.nix)
  ];

  # Set Environment Variables
  RUST_BACKTRACE = 1;
}

