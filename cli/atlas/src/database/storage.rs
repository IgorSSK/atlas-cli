use super::client::DbClient;

pub struct Storage {}

impl Storage {
    pub fn insert_session(name: &str, code: u32, ip: &str, started_at: &str) {
        let client = DbClient::new();
        let query = "INSERT INTO sessions (code, name, ip, started_at) VALUES (?1, ?2, ?3, ?4)";
        match client.execute(query, (code, name, ip, started_at)) {
            Ok(result) => println!("{} rows inserted", result),
            Err(error) => println!("Error while executing command: {} ", error),
        }
    }

    pub fn insert_player(id: &str, name: &str, session_id: u32, started_at: &str) {
        let client = DbClient::new();
        let query =
            "INSERT INTO players (id, name, session_id, started_at) VALUES (?1, ?2, ?3, ?4)";
        match client.execute(query, (id, name, session_id, started_at)) {
            Ok(result) => println!("{} rows inserted", result),
            Err(error) => println!("Error while executing command: {} ", error),
        }
    }
}
