L2Bot 0.8 version
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

Specify or leave unchanged this parameters in control.au3 file:
kAttackKey - key to attack action in your hotbar (by default F1)
kNextTargetKey - key to next target action in your hotbar (by default F10)
kPickDropKey - key to pickup drop action in your hotbar (by default F8)
kSitKey - key to sit/stand action in your hotbar (by default F9)
kHealthPoition - key to use health poition (by default F5)

You can use the CoolPix.exe utility from 'tools' directory to get next interface inforamtion.

NB: Changing interface parameters is needed only if you have change size
and position of the client windows. Don't change interface parameters for
default windows configuration.

NB: Specify windows and bars coordinares in right-top point and left-bottom
point order.

Specify or leave unchanged this parameters in interface.au3 file:
kTargetWindowPos - coordinates of the target state window
kTargetWindowColorBrown - first color to detect target window existance
kTargetWindowColorGray - second color to detect target window existance
kTargetHealthPos - coordinates of the target's health bar
kTargetHealthColor - color of the target's full health bar (by default red)
kTargetManaPos - coordinates of the target's mana bar
kTargetManaColor - color of the target's full mana bar (by default blue)
kTargetManaEmptyColor - color of the target's empty mana bar (by default dark blue)
kSelfHealthPos - coordinates of the player's health bar
kSelfHealthColor - color of the player's full health bar (by default red)
kSelfManaPos - coordinates of the player's mana bar
kSelfManaColor - color of the player's full mana bar (by default blue)
kMoveControlPos1,kMoveControlPos2,kMoveControlPos3 - three screen points to check player's moving

More information about this parameters is available in interface_conf_1.png and
interface_conf_2.png illustrations in the 'images' directory.

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
kFishingColor1, kFishingColor2 - colors of the couple pixels of "Fishing" window
to detect the window existance
kFishHealthPos - coordinates of the fish's health bar
kFishHealthColor - color of the fish's full health bar (by default blue)
kFishingKey - hotkey of the "Fishing" skill (by default F1)
kSkillPumpKey - hotkey of the "Pumping" skill (by default F2)
kSkillReelKey - hotkey of the "Reeling" skill (by default F3)
kFishShotKey - hotkey for fish shot usage (by default F12)

More information about this parameters is available in fishing_conf.png illustration in the 'images' directory.

Perform next actions before start fishing:
1. Place you character near the water where you can use "Fishing" skill
2. Wear the fishing rod and any bait

You can launch and stop bot as any others L2Bot scripts:
Alt+F2 - grab Lineage 2 client window
Alt+F3 - start bot
Alt+F1 - interrupt bot work

CHAT BOT
--------

Chat bot is implemented in chat.au3 script file from L2Bot root directory.

You can specify message text and delay betweeen message outputs for chat bot in the chat.au3 file:
1. kMessageTextRus - message in Russian language (this must be written in English keyboard layout for Java servers)
2. kMessageTextEn - message in English language
3. kDelayMinutes - delay betweeen message outputs in minutes

CONTACT INFORMATION
-------------------

You can ask any questions about usage L2Bot, report about bugs, send your suggestions and patches to me:
Ilya Shpigor <petrsum@gmail.com>
