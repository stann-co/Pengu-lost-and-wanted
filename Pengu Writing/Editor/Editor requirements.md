The editor should follow these requirements, and ideally be developed in a way that lets me actually start using it as soon as possible, with the possibility of adding extra features on top without constant refactoring or level data loss
## Technology
Using *ImGui* for all windows widgets and window docking
(maybe switch to this fork https://github.com/WuffMakesGames/ImGui_GM)

Each level should be stored as big *json* files. Can consider making smaller bit files later maybe, but if so should be done early, and in a way where it's still easy to add/remove/edit editor features

Tile data in a level is tied to a specific layer, and the tile data is stored as one long bytearray
[this is how it is stored in gamemaker](https://forum.gamemaker.io/index.php?threads/how-are-tiles-stored-in-room-yy-files.99042/post-598104), i can think if there's a simpler optimal way to store each index + flip + rotate. I will search online and find out

For every tilemap available in game, there's editor specific brush data, that can be used and edited, in the same way you draw tiles in the game normally. They are stored in a seperate editor specifc *json* file

The gamemaker asset tagging system is used to specify which sprites tilemaps and objects should actually be available in editor.

Using the *ResourceOrder.yy* file to copy the asset folder structure, to more easily find specific assets. order and folders cannot be edited at runtime

The game should be slightly restructured in a way that lets me hotswap between game and editor without any issues. The main difficulties being the main game object and camera.
## Features
Live swap between editor and playtesting, it should be made in a way where you can override the usual spawn point, when playtesting, and your playtest should not change the actual level data in any way

there should be a simple hierarchy of level loading. General level info first -> layers -> sprites -> instances

Undo and redo ability, especially when working with tile placement will be very useful
all actions in the editor should call functions, that add the action and the opposite of that action to an undo and redo stack.
When you place a tile, it stores the tile location, the previous tile, and the new tile.
If you copy a large selection of tiles, that will simply be an array of several actions.
If you undo a bunch of times, and then make a new action that will clear the redo stack.

there should be no room bounds when editing a level, it should automatically resize to the tightest fit, and move all layers around to accommodate this

when starting the editor it should open the most recently worked on level
## the editor should have these elements:
topbar of general options like saving loading, switching rooms, windows, and ability to add more options later

Layer window, that let's you add edit and remove layers in a level. A layer can be of these types:
- Tilemap
- Sprites
- Instances
(consider if i should make a special background layer? right now the special backgrounds are each special draw functions that get swapped out and called in post draw, it could also just be able to select on of these draw functions maybe)

The layers should each have these options:
- Parralax That makes the layer move faster or slower relative to camera. When changing this value the layer instances or sprites should be offset so they still appear in the same place in the room. Tilemaps depending on their size should automatically scale to appear further in the background. The parralax slider should be fixed to steps in a way that makes it easy to keep track of how many pixels it is away or closer
- Hide, the layer and all its elements
- Depth, set the layers depth, to determine which order stuff gets drawn. Should probably be in increments of 10, so there's wiggle room for instance specific depth offset
- Lock
The first 3 layers should be for tile collisions, while tiles can be placed the and the layer can be hidden/locked it cannot be deleted or reorganized

all instances placed in editor should be simple editor specific pointer objects, that holds information about the actual objects placed in game. all objects can have optional editor draw functions that these objects can read and use for how they display in editor, as well as special widget functions that make it easier to finetune some elements using widgets

When loading a level directly pointer objects aren't used at all

### Future additions
Editor specific objects

Audio ambience object, placed in level, and lets you hear the effects live in editor

Particle emitter objects

Easy I/O object signals and visible connection lines in editor

Easier terrain tools, to draw out collisions

Cutscene tools

Textbox previewing tools

Multilayer copy pasting, all unlocked layers, you drag a selection over, including tiles will be copied, and be able to be placed elsewhere