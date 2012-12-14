L2Bot 0.6 version
=================

INTRODUCTION
------------

L2Bot is toolkit of AutoIt scripts to implement Lineage 2 bot.

INSTALLATION
------------

To launch L2Bot you need to download AutoIt interpreter from official website:
http://www.autoitscript.com/site/autoit/downloads

The x64 interpreter version must be selected in installation dialog for users with x64 Windows version.

Then download archive with L2Bot scripts and extract it.

CONFIGURATION
-------------

First of all set checkbox "chat with Enter" in your Lineage client options.

You can modify the following configuration files to adapt L2Bot for your Lineage 2 client.

This is list of configuration files from 'conf' directory:
hotbar.au3 - content of your hotbar is described there
interface.au3 - position of interface windows and trigger colors are described there
control.au3 - specific keys to control player character is described there
targets_ru.au3 - list of patterns for target mobs names

Specify or leave unchanged this information in hotbar.au3 file:
1. kAttackKey - key to attack action in your hotbar (by default F1)
2. kNextTargetKey - key to next target action in your hotbar (by default F10)
3. kPickDropKey - key to pickup drop action in your hotbar (by default F8)
3. kSitKey - key to sit/stand action in your hotbar (by default F9)
6. kHealthPoition - key to use health poition (by default F5)

You can use the CoolPix.exe utility from 'tools' directory to get next interface inforamtion.

Specify or leave unchanged this information in interface.au3 file:
1. kTargetWindowPos[x1, y1, x2, y2] - this is left top point (x1 and y1) and right bottom point (x2, y2) area coordinates array of the target window
2. kTargetWindowColorBrown - first color of target window
3. kTargetWindowColorGray - second color of target window
4. kTargetHealthColor - color of full health bar in the target window
5. kTargetManaColor - color of full mana bar in the target window
6. kTargetManaEmptyColor - color of empty mana bar in the target window
7. kTargetHealthPos - area of the target's health bar to detect first hit
8. kSelfHealthCritPos - area of the player's health bar to detect critical HP value
9. kSelfHealthHalfPos - area of the player's health bar to detect half HP value
10. kSelfHealthEmptyPos - area of whole player's health bar
11. kSelfHealthColor - color of the full player's health bar
12. kSelfManaMinPos - area of the the player's mana bar to detect critical MP value
13. kSelfManaColor - color of the full player's mana bar
14. kMoveControlPos1 - first screen point to check player's moving
15. kMoveControlPos2 - second screen point to check player's moving
16. kMoveControlPos3 - third screen point to check player's moving

Specify or leave unchanged class spicific skills in the files of 'tactics' directory. You can find these in the spoiler.au3, tank.au3 and warcrayer.au3 files.

LAUNCHING
---------

To start L2Bot work perform next actions:

1. Launch your Lineage 2 client in window mode (press Alt+Enter to do it) and start game with your character.
2. Go to location with mobs
3. Minimize Lineage 2 client window
4. Start spoiler.au3, warcrayer.au3 or tank.au3 script from the L2Bot root directory
5. Switch and restore the Linegae 2 client window
6. Press Alt+F2 to grab Lineage 2 client window
7. Press Alt+F3 to start bot
8. Press Alt+F1 to stop bot
