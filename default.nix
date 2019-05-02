with import <nixpkgs> {};
let
  rust = (import ./rust.nix);
  extraRustcOpts = [ "--target x86_64-unknown-linux-musl" ];
in
((import ./Cargo.nix).kamikaze {}).override {
  rust = rust;
  crateOverrides = defaultCrateOverrides // {
    kamikaze = attrs: {
      extraRustcOpts = extraRustcOpts;
    };
    errno = attrs: {
      extraRustcOpts = extraRustcOpts;
    };
    errno-dragonfly = attrs: {
      extraRustcOpts = extraRustcOpts;
    };
    exec = attrs: {
      extraRustcOpts = extraRustcOpts;
    };
    gcc = attrs: {
      extraRustcOpts = extraRustcOpts;
    };
    libc = attrs: {
      extraRustcOpts = extraRustcOpts;
    };
    winapi = attrs: {
      extraRustcOpts = extraRustcOpts;
    };
    winapi-i686-pc-windows-gnu = attrs: {
      extraRustcOpts = extraRustcOpts;
    };
    winapi-x86_64-pc-windows-gnu = attrs: {
      extraRustcOpts = extraRustcOpts;
    };
  };
}

