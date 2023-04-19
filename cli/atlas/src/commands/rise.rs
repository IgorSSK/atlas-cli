use std::{
    io::{BufRead, BufReader, Error, ErrorKind},
    process::Command,
};

use chrono::{TimeZone, Utc};

use regex::Regex;

use crate::{
    database::storage::Storage,
    helper::{self, config::AppConfig},
    GameCommands,
};

pub fn invoke(command: &GameCommands) {
    let app_config = helper::config::get_app_config(command);

    let mut command = Command::new("./valheim_server.x86_64");

    command
        .current_dir("/home/igors/steam_apps/valheim")
        .arg("-batchmode")
        .arg("-nographics")
        .arg(format!("-name {}", app_config.server_name))
        .arg(format!("-port {}", app_config.server_port))
        .arg(format!("-world {}", "Asgard"))
        .arg(format!("-password {}", "gameplay123"))
        .arg(format!("-public {}", "1"))
        .arg(format!("-savedir {}", app_config.save_dir))
        .arg("-crossplay")
        .env("LD_LIBRARY_PATH", "/home/igors/steam_apps/valheim/linux64")
        .env("SteamAppId", app_config.id.to_string());

    println!("[ATLAS] {:?}", command.get_args());

    let stdout = command
        .spawn()
        .unwrap()
        .stdout
        .ok_or_else(|| Error::new(ErrorKind::Other, "Could not capture standard output."));

    // let stdout = Command::new("/home/igors/repos/personal/GameCenter.DedicatedServers/cli/atlas/src/configs/valheim/startup.sh")
    //     .env("STEAM_APP_DIR", "/home/igors/steam_apps")
    //     .env("APP_ID", app_config.id.to_string())
    //     .env("SERVER", app_config.server_name)
    //     .env("SERVER_PORT", app_config.server_port.to_string())
    //     .env("WORLD", "Asgard")
    //     .env("SECRET", "gameplay")
    //     .env("SAVE_DIR", app_config.save_dir)
    //     .spawn()
    //     .unwrap()
    //     .stdout
    //     .ok_or_else(|| Error::new(ErrorKind::Other, "Could not capture standard output."));

    // BufReader::new(stdout.unwrap())
    //     .lines()
    //     .filter_map(|line| line.ok())
    //     .for_each(|line| {
    //         println!("{}", line);
    //         intercept_session(&line);
    //         intercept_player(&line);
    //     });
}

fn intercept_session(line: &str) {
    let re = Regex::new(
        r#"(?P<datetime>\d{2}/\d{2}/\d{4} \d{2}:\d{2}:\d{2}).+Session\s"(?P<name>.+)".+code\s(?P<code>[0-9]+).+IP\s(?P<ip>(?:[0-9]{1,3}\.){3}[0-9]{1,3}:[0-9]{4}).+(?P<players>[0-9])\splayer"#,
    )
    .unwrap();

    if re.is_match(&line) {
        re.captures(&line).map(|capture| {
            let datetime = Utc
                .datetime_from_str(&capture["datetime"], "%m/%d/%Y %H:%M:%S")
                .unwrap();
            let name = &capture["name"];
            let code = capture["code"].parse::<u32>().unwrap();
            let ip = &capture["ip"];

            println!("{:?}: {:?} | {:?} | {:?}", datetime, name, code, ip);

            Storage::insert_session(name, code, ip, &datetime.to_string());
        });
    }
}

fn intercept_player(line: &str) {
    let re = Regex::new(
        r#"(?P<datetime>\d{2}/\d{2}/\d{4} \d{2}:\d{2}:\d{2}).+Got character ZDOID from (?P<player>\w+[ \w+]*) : (?P<id>\d*):\d*$"#,
    )
    .unwrap();

    if re.is_match(&line) {
        re.captures(&line).map(|capture| {
            let datetime = Utc
                .datetime_from_str(&capture["datetime"], "%m/%d/%Y %H:%M:%S")
                .unwrap();
            let name = &capture["player"];
            let id = &capture["id"];

            println!("{:?}: {:?} | {:?}", datetime, name, id);

            Storage::insert_player(id, name, 0, &datetime.to_string());
        });
    }
}
