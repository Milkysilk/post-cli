use std::{fs, io, path};

use uuid::Uuid;
use chrono::prelude::{Local};
use chrono::Datelike;

pub fn create_dir(path: &str) -> io::Result<()> {
    if !path::Path::new(path).exists() {
        fs::create_dir_all(path)?
    }
    Ok(())
}

pub fn create_file(filename: String, title: String) -> io::Result<()> {
    let front_matter = format!(r#"+++
title = "{}"
date = {}
url = "{}"
+++
"#, title, Local::now().to_rfc3339(), get_uuid());
    fs::write(filename, front_matter)?;
    Ok(())
}

pub fn get_date() -> (String, String, String) {
    let time = Local::now();
    let month = format!("{:0>2}", time.month());
    let day = format!("{:0>2}", time.day());
    (time.year().to_string(), month, day)
}

fn get_uuid() -> String {
    let uuid = format!("{}", Uuid::new_v4().to_string().replace("-", ""));
    uuid
}