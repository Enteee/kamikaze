with import <nixpkgs> {};
((import ./Cargo.nix).kamikaze {}).override {
  rust = (import ./shell.nix).rust;
  crateOverrides = defaultCrateOverrides // {
    kamikaze = attrs: {
      extraRustcOpts = [ "--target x86_64-unknown-linux-musl" ];
    };
  };
}

