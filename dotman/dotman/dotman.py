import os
import typer
import toml
from pathlib import Path

dotman_cli = typer.Typer()


def main():
    dotman_cli()


@dotman_cli.command()
def link(path: Path):
    if not path.is_dir():
        typer.echo(f"Error: {path} is not a directory!")
        return

    (_, subdirs, _) = next(os.walk(path))

    subdirs = map(lambda subdir: path.joinpath(subdir), subdirs)

    to_link = []
    for subdir in subdirs:
        (_, _, files) = next(os.walk(subdir))
        files = [x for x in filter(lambda file: file == "dotman.toml", files)]
        if len(files) > 0:
            metadata_file = files[0]
            typer.echo(f"Found {metadata_file} at {subdir}.")
            to_link.append(Path(subdir))

    config_paths = []
    for dir in to_link:
        dotman_dir = dir.joinpath("dotman.toml")
        metadata = toml.load(dotman_dir)
        entries = metadata.get('dotman')
        if entries == None:
            typer.echo(f"Error: Missing [dotman] on {dotman_dir} be an absolute path.")
            return

        config_path = entries.get('config_path')
        if entries == None:
            typer.echo(f"Error: Missing config_path on [dotman] on {dotman_dir} be an absolute path.")
            return

        config_path = Path(os.path.expandvars(config_path))
        if not config_path.is_absolute():
            typer.echo(f"Error: config_path: '{config_path}' must be an absolute path.")
            return

        config_paths.append(config_path)

    for (dir, config_path) in zip(to_link, config_paths):
        if not os.path.exists(config_path):
            typer.echo(f"{dir}: Creating {config_path}.")
            os.makedirs(config_path)

        (_, _, files) = next(os.walk(dir))
        files = filter(lambda file: file != "dotman.toml", files)
        for file in files:
            file_dir = os.path.realpath(dir.joinpath(file))
            config_file_dir = config_path.joinpath(file)
            if os.path.islink(config_file_dir):
                typer.echo(f"{dir}: Removing existant link at {config_file_dir}.")
                os.unlink(config_file_dir)
            elif os.path.isfile(config_file_dir):
                typer.echo(f"{dir}: Removing existant file at {config_file_dir}.")
                os.remove(config_file_dir)
            typer.echo(f"{dir}: Creating link: {config_file_dir} -> {file_dir}.")
            os.symlink(file_dir, config_file_dir)




@dotman_cli.command()
def unlink():
    typer.echo("TODO: unlink :P")
