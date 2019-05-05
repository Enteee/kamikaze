extern crate exec;
extern crate users;

use std::env;

use std::fs;

use std::process::exit;

use users::{get_effective_uid, get_effective_gid};
use users::switch::{set_current_uid, set_current_gid};

fn usage() {
    println!("usage: kamikaze <command> <arguments>");
}

fn main() {

    // Kill myself
    fs::remove_file(
        env::current_exe().expect("failed to get path to executable")
    ).expect("kamikaze failed");

    set_current_uid(
        get_effective_uid()
    ).expect("failed setting current uid");

    set_current_gid(
        get_effective_gid()
    ).expect("failed setting current gid");

    let mut args: Vec<String> = env::args().collect();
    match args.len() {
        0 => usage(),
        1 => usage(),
        _ => {
            args.remove(0);
            let err = exec::Command::new(args.remove(0))
                .args(&args)
                .exec();
            println!("Error: {}", err);
        },
    }
    // Should never get here
    exit(1);
}

