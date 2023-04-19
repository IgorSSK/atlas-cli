use crate::GameCommands;

pub struct AppConfig {
    pub id: i32,
    pub app_dir: String,
    pub server_port: i32,
    pub server_name: String,
    pub save_dir: String,
}

pub fn get_app_config(command: &GameCommands) -> AppConfig {
    let apps_dir = std::env::var("STEAM_APPS_DIR").expect("STEAM_APPS_DIR required!");
    return match command {
        GameCommands::Valheim => AppConfig {
            id: 896660,
            app_dir: format!("{}/valheim", apps_dir),
            server_port: 2456,
            server_name: "[Atlas] Valheim Server".to_string(),
            save_dir: format!("{}/valheim/save", apps_dir),
        },
        GameCommands::TheForest => todo!(),
    };
}
