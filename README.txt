L2Bot 2.5 version
=================

1. INTRODUCTION
---------------

L2Bot is toolkit of AutoIt scripts to implement Lineage 2 bot.

2. INSTALLATION
---------------

To launch L2Bot you need to download AutoIt interpreter from official website:
http://www.autoitscript.com/site/autoit/downloads

The x64 interpreter version must be selected in installation dialog for users with x64 Windows version.

Then download archive with L2Bot scripts and extract it:
https://github.com/ellysh/l2bot/archive/master.zip

3. CONFIGURATION
----------------

NB: You must set the `chat with Enter` checkbox in your Lineage client application for the correct bot's working.

Configuration of the L2Bot consist of the three stages:
1. Configuration of the bot according to your Lineage client's interface.
2. Configuration of the mob's names to attack them by bot.
3. Configuration of the hotbar keys according your character's class.

All these stages will be described below.

3.1 INTERFACE CONFIGURATION
---------------------------

You can use the `configurator_en.au3` script from the `run` directory to configure farm bot according your Lineage client's interface. All interface's parameters will be saved in `interface.au3` file from the `conf` directory.

There are steps to perform the interface configuration:
1. Run your Lineage client in the window mode. You can press Alt+Enter for switching to the window mode.
2. Resize the Lineage client window to full screen with mouse.
3. Get into the game with your character.
4. Run `configurator_en.au3` script from the `run` directory.
5. Switch to the Lineage client window.
6. Press Alt+F2 to start configuration script.
7. Select the point in the Lineage window according the information in popup tip. You can select point at the current cursor's position by pressing Alt+F3.
8. The popup tips will be disappeared after you has selected the last point. Configuration is complete.

This is illustration of all configuration points in the `interface_conf.jpg` file from the `images` directory.

You can use the `configurator_fishing_en.au3` script from the `run` directory to configure fishing bot. This script works like the described above `configurator_en.au3` one. This is illustration of all configuration points for fishing bot in the `fishing_conf.jpg` file from the `images` directory.

3.2 MOB'S NAMES CONFIGURATION
-----------------------------

There are steps to perform the mob's names configuration:
1. Open the `targets.au3` fle from the `conf` directory with any text editor.
2. Write mob's names into `$kTargetNames` list.
3. Change value of the `$kTargetCount` variable according count of elements in the `$kTargetNames` list.

NB: You can specify one or two letters of the mob's names for the Gracia Final and above Lineage chronicles. This is example:
	global const $kTargetCount = 2
	global const $kTargetNames[$kTargetCount] = [ "G", "Wo" ]

You must specify full mob's names for Lineage chronicles below the Gracia Final one:
	global const $kTargetCount = 2
	global const $kTargetNames[$kTargetCount] = [ "Gremlin", "Wolf" ]

3.3 HOTBAR KEYS CONFIGURATION
-----------------------------

The L2Bot scripts implement the farm bots for several character's classes. All these scripts are placed to the `run` directory. Script's name is the same as relevant class's name.

The hotbar configuration is depended on the running script. You can use hotbar illustrations from the `images` directory. Name of the illustration file contains the character's class name and the `hotbar` word. For example, `bladedancer_hotbar.jpg` file is the illustration for `bladedancer.au3` script.

The `fishing_hotbar.jpg` file from the `images` directory is a hotbar illustration for the fishing bot.

4. LAUNCHING
------------

NB: Bots of L2Bot project is not executable `exe` files! All bots are implemented as AutoIt scripts with `au3` extention and them are placed to the `run` directory. You can run these scripts like the `exe` files.

There are steps to run L2Bot:
1. Run your Lineage client in the window mode. You can press Alt+Enter for switching to the window mode.
2. Resize the Lineage client window to full screen with mouse.
3. Get into the game with your character.
4. Run one of the farm-bot script from the `run` directory.
5. Switch to the Lineage client window.
6. Press Alt+F2 to start bot.
7. You can stop bot by Alt+F1 pressing.

NB: The Lineage client window must have the same size and position as you have configured (see the 3.1 section).

5. FISHING BOT
--------------

Fishing bot is implemented in the runnable `fishing.au3` script file from `run` directory.

Configuration of the fishing bot consist of the two stages:
1. Configuration of the bot according to your Lineage client's interface (see the 3.1 section).
2. Configuration of the hotbar keys (see the 3.3 section).

NB: You must set the attack skill to F1 key for the nuker classes instead the `Attack` action

You must perform these actions before run the fishing bot:
1. Place your character near the water where you can use `Fishing` skill. Character and camera must be faced to the water i.e. the character will move to the water if you will press the `Up` arrow keyboard button.
2. Wear the fishrod and bait on your character.

You can run and stop fishing bot with the same buttons as the others bots.

6. CHAT BOT
-----------

Chat bot is implemented in the runnable `chat.au3` script file from the `run` directory.

You can open the `chat.au3` file from the `run` directory and specify variables described below to configure bot:
	kMessageTextRus - this is message text to print in Russian language.
	kMessageTextEn - this is message text to print in English language.
	kDelayMinutes - this is delay betweeen the message outputs in minutes.

You can run and stop chat bot with the same buttons as the others bots.

7. CUSTOM SCRIPT
----------------

The custom script mechanism allow you to extend the functionality of existing farm bots. Also you can create custom script that will be launched separately from the other L2Bot scripts.

There are steps to perform the custom script generation:
1. Run `script_generator.au3` file from the `run` directory.
2. Press Alt+F2 to start generator script.
3. Perform the keys pressing and mouse clicks that will be saved.
4. Press Alt+F1 to complete the generator script

NB: The generator script is able to save letters, numbers, F1-F12 buttons and left button mouse clicks. The buttons Alt, Ctrl, Shift and Win will not be saved.

The generated custom script has been saved in the `script.au3` file in the `run` directory.

There are steps to launch custom script:
1. Run `script_run.au3` file from the `run` directory.
2. Press Alt+F2 to start custom script.
3. You can interrupt the custom script's work by Alt+F1 pressing

NB: You can launch custom script in the loop. Change the `kIsLoop` variable to `true` in the `script_run.au3` file:
global const $kIsLoop = true

All farm bots will launch custom script by timeout. You can change timeout value with the `kScriptTimeout` variable in the running farm bot script.

8. REPEATER SCRIPT
------------------

Repeater script translates player's key pressing to all Lineage 2 window. Additional configuration is not needed for this script.

There are steps to launch repeater script:
1. Run `repeater.au3` file from the `run` directory.
2. Switch to the Lineage client window.
3. Press Alt+F2 to start repeater.
4. You can interrupt the script's work by Alt+F1 pressing

9. ROULETTE BOT
---------------

Roullete bot allow you to automate roulette play at the asterios.tm servers x3 and x7.

There are steps to perform the bot's configuration:
1. Run `configurator_roulette.au3` script from the `run` directory.
2. Switch to the Lineage client window.
3. Press Alt+F2 to start configuration script.
4. Select the point in the Lineage window according the information in popup tip. You can select point at the current cursor's position by pressing Alt+F3.
5. The popup tips will be disappeared after you has selected the last point. Configuration is complete.

You can open the `roulette.au3` file from the `run` directory and specify variables described below for additional bot's configuration:
	kStartRate - start rate.
	kMaxRate - maximum allowable rate.

There are steps to launch rullete bot:
1. Run `roulette.au3` file from the `run` directory.
2. Switch to the Lineage client window.
3. Press Alt+F2 to start bot.
4. You can interrupt the script's work by Alt+F1 pressing

10. CONTACTS
-----------

You can ask any questions about usage L2Bot, report about bugs, send your suggestions and patches in the L2Bot project's groups and the developer's email.

Developer:
Ilya Shpigor <petrsum@gmail.com>

Project's group in vk:
https://vk.com/l2bot

Project's group in facebook:
https://www.facebook.com/L2Bot
