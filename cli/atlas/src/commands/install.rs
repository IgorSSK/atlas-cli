use std::{
    io::{BufRead, BufReader, Error, ErrorKind},
    process::{Command, Stdio},
};

use crate::{helper, GameCommands};

pub fn invoke(command: &GameCommands) {
    let app_config = helper::config::get_app_config(command);

    let stdout = Command::new("steamcmd")
        .arg("+@sSteamCmdForcePlatformType linux")
        .arg(format!("+force_install_dir {}", app_config.app_dir))
        .arg("+login anonymous")
        .arg(format!("+app_update {} validate", app_config.id))
        .arg("+quit")
        .stdout(Stdio::piped())
        .spawn()
        .unwrap()
        .stdout
        .ok_or_else(|| Error::new(ErrorKind::Other, "Could not capture standard output."));

    BufReader::new(stdout.unwrap())
        .lines()
        .filter_map(|line| line.ok())
        .for_each(|line| println!("[STEAMCMD] {}", line));
}
