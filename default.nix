with import <nixpkgs> {};
let src = fetchFromGitHub {
    owner = "mozilla";
    repo = "nixpkgs-mozilla";
    rev = "50bae918794d3c283aeb335b209efd71e75e3954";
    sha256 = "07b7hgq5awhddcii88y43d38lncqq9c8b2px4p93r5l7z0phv89d";
  };
  moz_rust = import "${src.out}/rust-overlay.nix" pkgs pkgs;
  rust-musl = moz_rust.rustChannelOfTargets "nightly" null ["x86_64-unknown-linux-musl"];
in
with import "${src.out}/rust-overlay.nix" pkgs pkgs;
stdenv.mkDerivation {
  name = "rust-env";
  buildInputs = [
    rust-musl
  ];

  # Set Environment Variables
  RUST_BACKTRACE = 1;
}

