mod commands;
mod database;
mod helper;

use clap::{Args, Parser, Subcommand};
use commands::{install, rise};

#[derive(Parser)]
#[command(author, version, about, long_about = None)]
#[command(propagate_version = true)]
struct Cli {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    /// Install apps from command
    Install(GameArgs),
    /// Start the container server
    Rise(GameArgs),
    /// Stop the container server
    Fall,
    /// Start internal Server API
    Api,
    /// Backup game files
    Backup,
    /// Update server files
    Update,
}

#[derive(Args)]
#[command(args_conflicts_with_subcommands = true)]
struct GameArgs {
    #[command(subcommand)]
    command: GameCommands,
}

#[derive(Subcommand)]
pub enum GameCommands {
    /// Valheim
    Valheim,
    /// The Forest
    TheForest,
}

fn main() {
    match &Cli::parse().command {
        Commands::Install(args) => install::invoke(&args.command),
        Commands::Rise(args) => rise::invoke(&args.command),
        Commands::Fall => todo!(),
        Commands::Api => todo!(),
        Commands::Backup => todo!(),
        Commands::Update => todo!(),
    }
}
