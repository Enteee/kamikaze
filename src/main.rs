use std::env;

use std::fs;

use std::process::{Command, exit};

fn usage() {
    println!("usage: kamikaze <command> <arguments>");
    exit(1);
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
            let mut child = Command::new(args.remove(0))
                .args(&args)
                .spawn()
                .expect("failed to execute process");
            exit(
                child
                    .wait()
                    .expect("wait failed")
                        .code().unwrap()
            );
        },
    }

}

