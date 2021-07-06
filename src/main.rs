use std::{env, process};

use post::*;

fn main() {
    let mut args = env::args();
    args.next();
    let title = match args.next() {
        Some(title) => title,
        None => {
            eprintln!("Didn't get a title string");
            process::exit(1);
        }
    };
    let dir = match env::var("SITE") {
        Ok(path) => path,
        Err(e) => {
            eprintln!("Problem reading environment variable: {}", e);
            process::exit(1);
        },
    };

    let (year, month, date) = get_date();
    let path = format!("{}/content/{}/{}/{}", dir, year, month, date);
    let filename = format!("{}/{}.adoc", path, title);

    if let Err(e) = create_dir(path.as_ref()) {
        eprintln!("Problem creating directories: {}", e);
        process::exit(1);
    }

    if let Err(e) = create_file(filename, title) {
        eprintln!("Problem creating directories: {}", e);
        process::exit(1);
    }
}
