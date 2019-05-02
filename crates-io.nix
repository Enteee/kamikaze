{ lib, buildRustCrate, buildRustCrateHelpers }:
with buildRustCrateHelpers;
let inherit (lib.lists) fold;
    inherit (lib.attrsets) recursiveUpdate;
in
rec {

# errno-0.2.4

  crates.errno."0.2.4" = deps: { features?(features_.errno."0.2.4" deps {}) }: buildRustCrate {
    crateName = "errno";
    version = "0.2.4";
    description = "Cross-platform interface to the `errno` variable.";
    authors = [ "Chris Wong <lambda.fairy@gmail.com>" ];
    sha256 = "145rd8ccjsj99hxkw9g9gnak56qqxlq85hqyj35wba6j2ibxbwy2";
    dependencies = (if kernel == "dragonfly" then mapFeatures features ([
      (crates."errno_dragonfly"."${deps."errno"."0.2.4"."errno_dragonfly"}" deps)
    ]) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."errno"."0.2.4"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."errno"."0.2.4"."winapi"}" deps)
    ]) else []);
  };
  features_.errno."0.2.4" = deps: f: updateFeatures f (rec {
    errno."0.2.4".default = (f.errno."0.2.4".default or true);
    errno_dragonfly."${deps.errno."0.2.4".errno_dragonfly}".default = true;
    libc."${deps.errno."0.2.4".libc}".default = true;
    winapi = fold recursiveUpdate {} [
      { "${deps.errno."0.2.4".winapi}"."errhandlingapi" = true; }
      { "${deps.errno."0.2.4".winapi}"."minwindef" = true; }
      { "${deps.errno."0.2.4".winapi}"."ntdef" = true; }
      { "${deps.errno."0.2.4".winapi}"."winbase" = true; }
      { "${deps.errno."0.2.4".winapi}".default = true; }
    ];
  }) [
    (features_.errno_dragonfly."${deps."errno"."0.2.4"."errno_dragonfly"}" deps)
    (features_.libc."${deps."errno"."0.2.4"."libc"}" deps)
    (features_.winapi."${deps."errno"."0.2.4"."winapi"}" deps)
  ];


# end
# errno-dragonfly-0.1.1

  crates.errno_dragonfly."0.1.1" = deps: { features?(features_.errno_dragonfly."0.1.1" deps {}) }: buildRustCrate {
    crateName = "errno-dragonfly";
    version = "0.1.1";
    description = "Exposes errno functionality to stable Rust on DragonFlyBSD";
    authors = [ "Michael Neumann <mneumann@ntecs.de>" ];
    sha256 = "1bpnr0z3bl2zxnm7syqbgmxsj18qm8l4s1jxr7czpbhdqhgfgvcf";
    dependencies = mapFeatures features ([
      (crates."libc"."${deps."errno_dragonfly"."0.1.1"."libc"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."gcc"."${deps."errno_dragonfly"."0.1.1"."gcc"}" deps)
    ]);
  };
  features_.errno_dragonfly."0.1.1" = deps: f: updateFeatures f (rec {
    errno_dragonfly."0.1.1".default = (f.errno_dragonfly."0.1.1".default or true);
    gcc."${deps.errno_dragonfly."0.1.1".gcc}".default = true;
    libc."${deps.errno_dragonfly."0.1.1".libc}".default = true;
  }) [
    (features_.libc."${deps."errno_dragonfly"."0.1.1"."libc"}" deps)
    (features_.gcc."${deps."errno_dragonfly"."0.1.1"."gcc"}" deps)
  ];


# end
# exec-0.3.1

  crates.exec."0.3.1" = deps: { features?(features_.exec."0.3.1" deps {}) }: buildRustCrate {
    crateName = "exec";
    version = "0.3.1";
    description = "Use the POSIX exec function to replace the running program with another";
    authors = [ "Eric Kidd <git@randomhacks.net>" ];
    sha256 = "0adp2bib4xh0r7kxs9m3r2jva250irxcikk8p796njpvqk7gjgah";
    dependencies = mapFeatures features ([
      (crates."errno"."${deps."exec"."0.3.1"."errno"}" deps)
      (crates."libc"."${deps."exec"."0.3.1"."libc"}" deps)
    ]);
    features = mkFeatures (features."exec"."0.3.1" or {});
  };
  features_.exec."0.3.1" = deps: f: updateFeatures f (rec {
    errno."${deps.exec."0.3.1".errno}".default = true;
    exec."0.3.1".default = (f.exec."0.3.1".default or true);
    libc."${deps.exec."0.3.1".libc}".default = true;
  }) [
    (features_.errno."${deps."exec"."0.3.1"."errno"}" deps)
    (features_.libc."${deps."exec"."0.3.1"."libc"}" deps)
  ];


# end
# gcc-0.3.55

  crates.gcc."0.3.55" = deps: { features?(features_.gcc."0.3.55" deps {}) }: buildRustCrate {
    crateName = "gcc";
    version = "0.3.55";
    description = "**Deprecated** crate, renamed to `cc`\n\nA build-time dependency for Cargo build scripts to assist in invoking the native\nC compiler to compile native C code into a static archive to be linked into Rust\ncode.\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "18qxv3hjdhp7pfcvbm2hvyicpgmk7xw8aii1l7fla8cxxbcrg2nz";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."gcc"."0.3.55" or {});
  };
  features_.gcc."0.3.55" = deps: f: updateFeatures f (rec {
    gcc = fold recursiveUpdate {} [
      { "0.3.55"."rayon" =
        (f.gcc."0.3.55"."rayon" or false) ||
        (f.gcc."0.3.55".parallel or false) ||
        (gcc."0.3.55"."parallel" or false); }
      { "0.3.55".default = (f.gcc."0.3.55".default or true); }
    ];
  }) [];


# end
# libc-0.2.54

  crates.libc."0.2.54" = deps: { features?(features_.libc."0.2.54" deps {}) }: buildRustCrate {
    crateName = "libc";
    version = "0.2.54";
    description = "Raw FFI bindings to platform libraries like libc.\n";
    authors = [ "The Rust Project Developers" ];
    sha256 = "11nrsbpmwcnfrjcds0wnicwwql3809nq6q6z00q920bdpryyaf58";
    build = "build.rs";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."libc"."0.2.54" or {});
  };
  features_.libc."0.2.54" = deps: f: updateFeatures f (rec {
    libc = fold recursiveUpdate {} [
      { "0.2.54"."align" =
        (f.libc."0.2.54"."align" or false) ||
        (f.libc."0.2.54".rustc-dep-of-std or false) ||
        (libc."0.2.54"."rustc-dep-of-std" or false); }
      { "0.2.54"."rustc-std-workspace-core" =
        (f.libc."0.2.54"."rustc-std-workspace-core" or false) ||
        (f.libc."0.2.54".rustc-dep-of-std or false) ||
        (libc."0.2.54"."rustc-dep-of-std" or false); }
      { "0.2.54"."use_std" =
        (f.libc."0.2.54"."use_std" or false) ||
        (f.libc."0.2.54".default or false) ||
        (libc."0.2.54"."default" or false); }
      { "0.2.54".default = (f.libc."0.2.54".default or true); }
    ];
  }) [];


# end
# winapi-0.3.7

  crates.winapi."0.3.7" = deps: { features?(features_.winapi."0.3.7" deps {}) }: buildRustCrate {
    crateName = "winapi";
    version = "0.3.7";
    description = "Raw FFI bindings for all of Windows API.";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "1k51gfkp0zqw7nj07y443mscs46icmdhld442s2073niap0kkdr8";
    build = "build.rs";
    dependencies = (if kernel == "i686-pc-windows-gnu" then mapFeatures features ([
      (crates."winapi_i686_pc_windows_gnu"."${deps."winapi"."0.3.7"."winapi_i686_pc_windows_gnu"}" deps)
    ]) else [])
      ++ (if kernel == "x86_64-pc-windows-gnu" then mapFeatures features ([
      (crates."winapi_x86_64_pc_windows_gnu"."${deps."winapi"."0.3.7"."winapi_x86_64_pc_windows_gnu"}" deps)
    ]) else []);
    features = mkFeatures (features."winapi"."0.3.7" or {});
  };
  features_.winapi."0.3.7" = deps: f: updateFeatures f (rec {
    winapi = fold recursiveUpdate {} [
      { "0.3.7"."impl-debug" =
        (f.winapi."0.3.7"."impl-debug" or false) ||
        (f.winapi."0.3.7".debug or false) ||
        (winapi."0.3.7"."debug" or false); }
      { "0.3.7".default = (f.winapi."0.3.7".default or true); }
    ];
    winapi_i686_pc_windows_gnu."${deps.winapi."0.3.7".winapi_i686_pc_windows_gnu}".default = true;
    winapi_x86_64_pc_windows_gnu."${deps.winapi."0.3.7".winapi_x86_64_pc_windows_gnu}".default = true;
  }) [
    (features_.winapi_i686_pc_windows_gnu."${deps."winapi"."0.3.7"."winapi_i686_pc_windows_gnu"}" deps)
    (features_.winapi_x86_64_pc_windows_gnu."${deps."winapi"."0.3.7"."winapi_x86_64_pc_windows_gnu"}" deps)
  ];


# end
# winapi-i686-pc-windows-gnu-0.4.0

  crates.winapi_i686_pc_windows_gnu."0.4.0" = deps: { features?(features_.winapi_i686_pc_windows_gnu."0.4.0" deps {}) }: buildRustCrate {
    crateName = "winapi-i686-pc-windows-gnu";
    version = "0.4.0";
    description = "Import libraries for the i686-pc-windows-gnu target. Please don't use this crate directly, depend on winapi instead.";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "05ihkij18r4gamjpxj4gra24514can762imjzlmak5wlzidplzrp";
    build = "build.rs";
  };
  features_.winapi_i686_pc_windows_gnu."0.4.0" = deps: f: updateFeatures f (rec {
    winapi_i686_pc_windows_gnu."0.4.0".default = (f.winapi_i686_pc_windows_gnu."0.4.0".default or true);
  }) [];


# end
# winapi-x86_64-pc-windows-gnu-0.4.0

  crates.winapi_x86_64_pc_windows_gnu."0.4.0" = deps: { features?(features_.winapi_x86_64_pc_windows_gnu."0.4.0" deps {}) }: buildRustCrate {
    crateName = "winapi-x86_64-pc-windows-gnu";
    version = "0.4.0";
    description = "Import libraries for the x86_64-pc-windows-gnu target. Please don't use this crate directly, depend on winapi instead.";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "0n1ylmlsb8yg1v583i4xy0qmqg42275flvbc51hdqjjfjcl9vlbj";
    build = "build.rs";
  };
  features_.winapi_x86_64_pc_windows_gnu."0.4.0" = deps: f: updateFeatures f (rec {
    winapi_x86_64_pc_windows_gnu."0.4.0".default = (f.winapi_x86_64_pc_windows_gnu."0.4.0".default or true);
  }) [];


# end
}
