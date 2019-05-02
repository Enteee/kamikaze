extern crate exec;

use std::env;

use std::fs;

use std::process::exit;

fn usage() {
    println!("usage: kamikaze <command> <arguments>");
}

fn main() {

    // Kill myself
    fs::remove_file(
        env::current_exe().expect("failed to get path to executable")
    ).expect("kamikaze failed");

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
    exit(1);
}

