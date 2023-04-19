use rusqlite::Connection;

pub struct DbClient {}

impl DbClient {
    pub fn new() -> Connection {
        let apps_dir = std::env::var("STEAM_APPS_DIR").expect("STEAM_APPS_DIR required!");
        match Connection::open(format!("{}/valheim/save/server.db", apps_dir)) {
            Ok(connection) => {
                println!("Connected to database successfully!");
                DbClient::init(&connection);
                return connection;
            }
            Err(error) => {
                println!(
                    "An error occurred while creating database connection!\n {}",
                    error
                );
                panic!()
            }
        }
    }

    fn init(connection: &Connection) -> () {
        let query_table_sessions = "
            CREATE TABLE IF NOT EXISTS sessions (
                code INTEGER PRIMARY KEY,
                name TEXT,
                world TEXT,
                ip TEXT,
                players INTEGER,
                public INTEGER, 
                mod TEXT,
                started_at TEXT,
                ended_at TEXT
            )";
        let query_table_players = "
            CREATE TABLE IF NOT EXISTS players (
                id INTEGER PRIMARY KEY,
                name TEXT,
                session_id INTEGER,
                started_at TEXT,
                ended_at TEXT
            )
        ";
        match connection.execute(query_table_sessions, ()) {
            Ok(result) => println!("{} rows affected", result),
            Err(error) => println!("Error while executing command: {} ", error),
        }
        match connection.execute(query_table_players, ()) {
            Ok(result) => println!("{} rows affected", result),
            Err(error) => println!("Error while executing command: {} ", error),
        }
    }
}
