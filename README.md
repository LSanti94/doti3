My personal i3 window manager dot files
---------------------------------------
My attempt to organize i3 configuration and tricks to get it working on 
different computer with different display setups

This repo includes the needed configuration to integerate rofi as dmenu
replacement in conjuction with albert.

Tools used
----------
* dunst - https://github.com/knopwob/dunst
* feh - http://feh.finalrewind.org
* conky - https://github.com/brndnmtthws/conky
* rofi - https://github.com/DaveDavenport/rofi
* albert - https://github.com/albertlauncher/albert
* terminator - https://launchpad.net/terminator/gtk3/1.91
* lockfile-progs xbindkeys xautomation mate-control-center
Fonts
-----
* Nerd fonts - https://github.com/ryanoasis/nerd-fonts

I3 branch used
--------------
* i3-gaps - https://github.com/Airblader/i3

Other resource configurations included
--------------------------------------
* ~/.Xdefault
* ~/.Xresources
* ~/.XresourcesLocal
* ~/.xinitrc
* i3/conkyrc as ~/.conkyrc
* rofi/config
* ...

You can use the following script to relink your dotfiles

```bash
install/relink
```

Specific Keybindings
--------------------

Keybinding           |  Action
---------------------|---------------------------------------
Mod + F1             | Run `htop`
Mod + F10            | Decrease Volume -
Mod + F11            | Increase Volume +
Mod + Shift + F12    | Toggle loud volume for chrome
Mod + PageUp         | Run `rofi -combi-modi`
-------------------- | -----------------------
Mod + a              | Focus parent container
Mod + d              | Run `rofi -show run`
Mod + f              | Fullscreen toggle
Mod + g              | Fullscreen toggle global
Mod _+ l              | Run `~/bini3/i3colorlock`
Mod + u              | Youtube trick (only works with chrome)
Mod + q              | Kill focused window
Mod + x              | Dump i3 window layout in a graph
Mod + y              | Toggle border 
Mod + z              | "Mouse-Key" Mode
Mod + Shift + z      | "Mouse" Mode (easy scroll)
Mod + Shift + n      | Run `Thunar`
Mod + Shift + d      | Run `xfce4-appfinder`
Mod + Control + r    | Rename workspace
-------------------- | -----------------------
Mod + Tab            | Next workspace
Mod + Control + Right| Next workspace
Mod + Shift + Tab    | Previous workspace
Mod + Control + Left | Previous workspace
-------------------- | -----------------------
Mod + Shift + F1     | Move window to output $DP0
Mod + Shift + F2     | Move window to output $DP1
Mod + Shift + F3     | Move window to output $DP2
-------------------- | -----------------------
Mod + Shift + PgUp   | Increase size of window by 100
Mod + Shift + PgDown | Decrease size of window by 100
Mod + Shift + Left   | Move window 100 pixel to the left
Mod + Shift + Right  | Move window 100 pixel to the right
Mod + Shift + Up     | Move window 100 pixel to the top
Mod + Shift + Down   | Move window 100 pixel to the bottom
-------------------- | -----------------------
Mod + Home           | Run `~/bini3/tempscript`
Mod + Pause          | Show system dmenu
Caps_Lock             | Change keyboard layout

