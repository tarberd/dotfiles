import os
import typer
import toml
from pathlib import Path

dotman_cli = typer.Typer()


class DotmanConfig:
    def __init__(self, dotman_config_file_directory, target_config_directory, file_map):
        self.source_dir = dotman_config_file_directory
        self.target_dir = target_config_directory
        self.file_map = file_map


def main():
    dotman_cli()


@dotman_cli.command()
def link(root_path: Path):
    if not root_path.is_dir():
        typer.echo(f"Error: {root_path} is not a directory!")
        return

    (_, root_path_subdirectories, _) = next(os.walk(root_path))

    root_path_subdirectories = map(
        lambda subdir: root_path.joinpath(subdir), root_path_subdirectories)

    dotman_config_file_directories = []
    for subdir in root_path_subdirectories:
        (_, _, config_files) = next(os.walk(subdir))
        config_files = [x for x in filter(
            lambda file: file == "dotman.toml", config_files)]
        if len(config_files) > 0:
            metadata_file = config_files[0]
            typer.echo(f"Found {metadata_file} at {subdir}.")
            dotman_config_file_directories.append(Path(subdir))

    dotman_configurations = []
    for source_dir in dotman_config_file_directories:
        dotman_dir = source_dir.joinpath("dotman.toml")
        metadata = toml.load(dotman_dir)
        entries = metadata.get('dotman')
        if entries == None:
            typer.echo(
                f"Error: Missing [dotman] on {dotman_dir} be an absolute path.")
            return

        config_path = entries.get('config_path')
        if entries == None:
            typer.echo(
                f"Error: Missing config_path on [dotman] on {dotman_dir} be an absolute path.")
            return

        config_path = Path(os.path.expandvars(config_path)).expanduser();
        if not config_path.is_absolute():
            typer.echo(
                f"Error: config_path: '{config_path}' must be an absolute path.")
            return

        file_map = entries.get('file_map')
        if file_map == None:
            file_map = []
        
        dotman_configurations.append(DotmanConfig(source_dir, config_path, file_map))

    for dotman_config in dotman_configurations:
        source_dir = dotman_config.source_dir
        target_dir = dotman_config.target_dir
        file_map = dotman_config.file_map

        if not os.path.exists(target_dir):
            typer.echo(f"{source_dir}: Creating {target_dir}.")
            os.makedirs(target_dir)
        
        (_, _, config_files) = next(os.walk(source_dir))
        config_files = filter(lambda file: file != "dotman.toml", config_files)
        for config_file in config_files:
            source_file_path = os.path.realpath(source_dir.joinpath(config_file))

            target_file_path = target_dir.joinpath(config_file)
            for mapping in file_map:
                if mapping['file'] == config_file:
                    target_file_path = target_dir.joinpath(Path(mapping['link']))

            if os.path.isfile(source_file_path) or os.path.islink(source_file_path):
                if os.path.islink(target_file_path):
                    typer.echo(
                        f"{source_dir}: Removing existant link at {target_file_path}.")
                    os.unlink(target_file_path)
                elif os.path.isfile(target_file_path):
                    typer.echo(
                        f"{source_dir}: Removing existant file at {target_file_path}.")
                    os.remove(target_file_path)
                typer.echo(
                    f"{source_dir}: Creating link: {target_file_path} -> {source_file_path}.")
                os.symlink(source_file_path, target_file_path)
            else:
                typer.echo(f"{source_file_path} does not exist")


@dotman_cli.command()
def unlink():
    typer.echo("TODO: unlink :P")
