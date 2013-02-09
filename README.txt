L2Bot 1.8 version
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

NB: First of all set checkbox "chat with Enter" in your Lineage client options.

You can modify the following configuration files to adapt L2Bot for your Lineage 2 client.

This is list of configuration files from 'conf' directory:
interface.au3 - this is position of points in Lineage windows and the trigger colors for the farm bots
interface_fishing.au3 - this is position of points in Lineage windows and the trigger colors for the fishing bot
control.au3 - this is your hotbar configuration and specific keys to control player character
targets.au3 - this is list of names for searching mobs with /target command

These parameters are specified in the control.au3 file:
kAttackKey - this is key to attack action in your hotbar (by default F1)
kNextTargetKey - this is key to next target action in your hotbar (by default F10)
kPickDropKey - this is key to pickup drop action in your hotbar (by default F8)
kSitKey - this is key to sit/stand action in your hotbar (by default F9)
kHealthPoition - this is key to use health poition (by default F5)

You must use the configurator_en.au3 script from 'run' directory to setup the interface file (interface.au3).

This is instruction of usage configurator script:
1. Launch your Lineage client in window mode (press Alt+Enter to do it) and start game with your character.
2. Manually resize Lineage client window to full screen with mouse
3. Login by your cahracter
4. Start configurator_en.au3 scripts from the 'run' directory
5. Switch focus to the Linegae client window for input receiving
6. Press Alt+F2 to start bot
7. Select point in the Lineage window according information in the popup tip. To select point move cursor
to it and press Alt+F3.

You can use the CoolPix.exe utility from 'tools' directory to check interface inforamtion.

These parameters are specified in the interface.au3 file:
kTargetWindowLeft - this is left-up point of the target window
kTargetWindowRight - this is right-bottom point of the target window
kTargetWindowColorBrown,kTargetWindowColorGray - these are colors of two random pixels in the target window
kTargetHealthLeft - this is left-up point of the target's HP bar
kTargetHealthRight - this is right-bottom point of the target's HP bar
kTargetHealthColor - this is color of the target's full HP bar (by default red)
kTargetManaLeft - this is left-up point of the target's MP bar
kTargetManaRight - this is right-bottom point of the target's MP bar
kTargetManaColor - this is color of the target's full MP bar (by default blue)
kTargetManaEmptyColor - this is color of the target's empty MP bar (by default dark blue)
kSelfHealthLeft - this is left-up point of the player's HP bar
kSelfHealthRight - this is right-bottom point of the player's HP bar
kSelfHealthColor - this is color of the player's full HP bar (by default red)
kSelfManaLeft - this is left-up point of the player's MP bar
kSelfManaRight - this is right-bottom point of the player's MP bar
kSelfManaColor - color of the player's full MP bar (by default blue)
kMoveControlPos1,kMoveControlPos2,kMoveControlPos3 - these are three random screen points to check player's moving

More information about this parameters is available on interface_conf.jpg
illustration in the 'images' directory.

Specify or leave unchanged class spicific skills hotkeys in the files of 'run' directory.

LAUNCHING
---------

NB: Bots of L2Bot project is not executable exe files! All of them have been implemented as AutoIt scripts
with au3 filename extension. You must run these scripts.

To start L2Bot work perform next actions:

1. Launch your Lineage client in window mode (press Alt+Enter to do it) and start game with your character.
2. Manually resize Lineage client window to full screen with mouse
3. Login by your cahracter
4. Start one of scripts from the 'run' directory
5. Switch focus to the Linegae 2 client window for input receiving
6. Press Alt+F2 to start bot
7. To interrupt bot work press Alt+F1

FISHING BOT
-----------

Fishing bot is implemented in fishing.au3 script file from 'run' directory.

You must use the configurator_fishing_en.au3 script from 'run' directory to setup the fishing bot interface file
(interface_fishing.au3).

These parameters are specified in the interface.au3 file:
kFishingWindowLeft - this is left-up point of the "Fishing" window
kFishingWindowRight - this is right-bottom point of the "Fishing" window
kFishingColor1, kFishingColor2 - these are colors of the two random pixels in the "Fishing" window
kFishHealthLeft - this is left-up point of the fish's HP bar
kFishHealthRight - this is right-bottom point of the fish's HP bar
kFishHealthColor - color of the fish's full HP bar (by default blue)

These hotkeys are specified in the fishing.au3 file in the 'run' directory:
kFishingKey - hotkey of the "Fishing" skill (by default F1)
kSkillPumpKey - hotkey of the "Pumping" skill (by default F2)
kSkillReelKey - hotkey of the "Reeling" skill (by default F3)
kFishShotKey - hotkey for fish shot usage (by default F12)

More information about this parameters is available in fishing_conf.jpg illustration in the 'images' directory.

Perform next actions before start fishing:
1. Place you character near the water where you can use "Fishing" skill
2. Wear the fishing rod and any bait

You can launch and stop bot as any others L2Bot scripts:
Alt+F2 - start bot
Alt+F1 - interrupt bot work

CHAT BOT
--------

Chat bot is implemented in chat.au3 script file from 'run' directory.

You can specify message text and delay betweeen message outputs for chat bot in the chat.au3 file:
1. kMessageTextRus - message in Russian language (this must be written in English keyboard layout for Java servers)
2. kMessageTextEn - message in English language
3. kDelayMinutes - delay betweeen message outputs in minutes

CONTACT INFORMATION
-------------------

You can ask any questions about usage L2Bot, report about bugs, send your suggestions and patches to me:
Ilya Shpigor <petrsum@gmail.com>
