# Dodge the Creeps: Godot World

This project started from Godot's "Your first 2D game" tutorial and was
expanded into a playable browser game.

## Changes

- Added keyboard movement with `W`, `A`, `S`, and `D`.
- Added a bullet mechanic using the `Space` key.
- Enemies can be destroyed by bullets and award score.
- Added score tracking for survival time and defeated enemies.
- Added a game-over screen when the player is hit.
- Added a restart button that clears enemies and bullets before a new game.
- Removed the background music.
- Exported the game for Web/GitHub Pages in `dodge-the-creeps/`.

## Play online

https://dravidian117.github.io/proj-1/dodge-the-creeps/

## Controls

- Move: `W`, `A`, `S`, `D`
- Shoot: `Space`
- Restart: click the button shown after game over

## Local web preview

The Web export must be served over HTTP rather than opened directly from the
file system. From the `dodge-the-creeps/` directory, use VS Code Live Server
or another static HTTP server, then open `godot.html` in the browser.

## Export

The original Godot project files are in the repository root. The generated
Web export files are in `dodge-the-creeps/`. The project can be exported again
with the Web preset in Godot 4.7.2.
