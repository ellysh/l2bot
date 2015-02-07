Repeater 0.4 version
====================

1. INTRODUCTION
---------------

Repeater is an utility to send pressed keys for all windows with specified title or class

2. INSTALLATION
---------------

You need to download AutoHotkey interpreter from official website for launching Repeater:
http://www.autohotkey.com

Then download archive with Repeater scripts and extract it:
https://github.com/ellysh/repeater/archive/master.zip

3. CONFIGURATION
----------------

You must specify title or class of windows that will be recieved user's keystrokes for Repeater utility configuration.
The AU3_Spy.exe tool can be used to get this kind of information about windows. You can find this tool in AutoHotkey installation
directory (by default `C:\Program Files\AutoHotkey`).

Windows' title must be specified in `run\repeater.ahk` script from Repeater utility archive. This is example of title for Notepad application:
kTitle := "Untitled - Notepad"

Alternative solution is specifying windows' class in repeater.ahk script. This is example for Notepad application:
kClass := "ahk_class Notepad"

NB: Change value of kUseClass variable to 1 if you want to use windows' class instead the title:
kUseClass := 1

4. LAUNCHING
------------

There are steps to launch Repeater utility:
1. Run the `repeater.ahk` script from the `run` directory.
2. Allow administrator's privileges for the script.

You can stop Repeater by Alt+F1 pressing.

5. CONTACTS
-----------

You can ask any questions about usage L2Bot, report about bugs, send your suggestions and patches to developer's email.

Developer:
Ilya Shpigor <petrsum@gmail.com>
