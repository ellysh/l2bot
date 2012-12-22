L2Bot 0.7 version
=================

INTRODUCTION
------------

L2Bot is toolkit of AutoIt scripts to implement Lineage 2 bot.

INSTALLATION
------------

To launch L2Bot you need to download AutoIt interpreter from official website:
http://www.autoitscript.com/site/autoit/downloads

The x64 interpreter version must be selected in installation dialog for users with x64 Windows version.

Then download archive with L2Bot scripts and extract it:
https://github.com/ellysh/l2bot/archive/master.zip

CONFIGURATION
-------------

First of all set checkbox "chat with Enter" in your Lineage client options.

You can modify the following configuration files to adapt L2Bot for your Lineage 2 client.

This is list of configuration files from 'conf' directory:
interface.au3 - position of interface windows and trigger colors are described there
control.au3 - your hotbar configuration and specific keys to control player character is described there
targets_ru.au3,targets_en.au3 - list of patterns for target mobs names in English and Russian

Specify or leave unchanged this information in control.au3 file:
kAttackKey - key to attack action in your hotbar (by default F1)
kNextTargetKey - key to next target action in your hotbar (by default F10)
kPickDropKey - key to pickup drop action in your hotbar (by default F8)
kSitKey - key to sit/stand action in your hotbar (by default F9)
kHealthPoition - key to use health poition (by default F5)

You can use the CoolPix.exe utility from 'tools' directory to get next interface inforamtion.

Specify or leave unchanged this information in interface.au3 file:
kTargetWindowPos[x1, y1, x2, y2] - this is coordinates left top point (x1 and y1) and right bottom point (x2, y2)
area coordinates array of the target window
kTargetWindowColorBrown - first color to detect target window existance
kTargetWindowColorGray - second color to detect target window existance
kTargetHealthColor - color of full health bar in the target window
kTargetManaColor - color of full mana bar in the target window
kTargetManaEmptyColor - color of empty mana bar in the target window
kTargetHealthPos -  coordinates of the target's health bar to detect first hit event
kSelfHealthCritPos - coordinates of the player's health bar to detect critical HP value
kSelfHealthHalfPos - coordinates of the player's health bar to detect half HP value
kSelfHealthEmptyPos - coordinates of whole player's health bar
kSelfHealthColor - color of the full player's health bar
kSelfManaMinPos - coordinates of the the player's mana bar to detect critical MP value
kSelfManaColor - color of the full player's mana bar
kMoveControlPos1,kMoveControlPos2,kMoveControlPos3  - three screen points to check player's moving

Specify or leave unchanged class spicific skills hotkeys in the files of 'tactics' directory. You can find these
in the spoiler.au3, tank.au3 and warcrayer.au3 files.

LAUNCHING
---------

To start L2Bot work perform next actions:

1. Launch your Lineage 2 client in window mode (press Alt+Enter to do it) and start game with your character.
2. Manually resize Lineage 2 client window to full screen with mouse
3. Login by your cahracter
4. Start one of scripts from the L2Bot root directory
5. Switch focus to the Linegae 2 client window for input receiving
6. Press Alt+F2 to grab Lineage 2 client window
7. Press Alt+F3 to start bot
8. To interrupt bot work press Alt+F1

FISHING BOT
-----------

Fishing bot is implemented in fishing.au3 script file from L2Bot root directory.

Open the fishing.au3 file in text editor and specify values of the next variables:
kFishingWindowPos - coordinates of the "Fishing" window
kFishingColor1, kFishingColor2 - colors of the couple pixels of "Fishing" window to detect its existance
kSkillWindowPos - coordinates of the icon with skill in the "Fishing" window (this icon is hint)
kSkillReelColor - color of the Reeling skill icon
kSkillPumpColor - color of the Pumping skill icon
kFishingKey - hotkey of the "Fishing" skill (by default F1)
kSkillPumpKey - hotkey of the "Pumping" skill (by default F2)
kSkillReelKey - hotkey of the "Reeling" skill (by default F3)

Perform next actions before start fishing:
1. Place you character near the water where you can use "Fishing" skill
2. Wear the fishing rod and bait for beginners (bot is not working with professional bait)

You can launch and stop bot as any others L2Bot scripts:
Alt+F2 - grab Lineage 2 client window
Alt+F3 - start bot
Alt+F1 - interrupt bot work

CHAT BOT
-----------

Chat bot is implemented in chat.au3 script file from L2Bot root directory.

You can specify message text and delay betweeen message outputs for chat bot in the chat.au3 file:
1. kMessageTextRus - message in Russian language (this must be written in English keyboard layout for Java servers)
2. kMessageTextEn - message in English language
3. kDelayMinutes - delay betweeen message outputs in minutes
