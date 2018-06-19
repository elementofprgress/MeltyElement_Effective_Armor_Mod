# Element ArmorPanel & Protractor Mod
# *Mod is in an Alpha state and many features, options, and some general functionality have yet to be tested.*

This mod is a remake of the ArmorPanel & Protractor that was included in the original MeltyMap sights.
Unlike the original ArmorPanel & Protractor this mod is no longer dependent on a XML sheet of tank armor and angle values.
All armor and angle values are gathered dynamically and directly from the game. 
A collision check based on your turret/camera rotation and tank's hull height is done against your own tank which returns the armor angle at that point.

The height that the collision check is done is adjustable and includes a debug render to aid with adjustment if needed. 

Options can be found in the **ArmorPanel.xc** file.

... *complete project description  and screenshots*

## Additional Features

... *document additional features, default hotkeys and options*



## Getting Started

### Prerequisites

* Install the font **\RequiredFont\ZeroThrees.ttf**

### Installing


**To install you must manually merge XVM .xc files.**

Included **@xvm.xc** and **battleLabels.xc** files are there for example only. Do not copy paste them over your XVM files.

* In your file **battleLabels.xc** add:

```
      ${ "meltyElementArmorPanel.xc":"def.frontSqrt" },
      ${ "meltyElementArmorPanel.xc":"def.sideSqrt" },
      ${ "meltyElementArmorPanel.xc":"def.effFrontArmorText" },
      ${ "meltyElementArmorPanel.xc":"def.effSideArmorText" },
      ${ "meltyElementArmorPanel.xc":"def.armorFrame" },
      ${ "meltyElementProtractor.xc":"def.circle" },
      ${ "meltyElementProtractor.xc":"def.leftLine" },
      ${ "meltyElementProtractor.xc":"def.middleLine" },
      ${ "meltyElementProtractor.xc":"def.rightLine" },
      ${ "meltyElementProtractor.xc":"def.realMiddleLine" },
      ${ "meltyElementProtractor.xc":"def.realMiddleLineLeft" },
      ${ "meltyElementProtractor.xc":"def.realMiddleLineRight" },
      ${ "meltyElementProtractor.xc":"def.middleLineText" },
```

* In your **@xvm.xc file**, add a link to the **armorPanel.xc** file:

```
  "armorPanel": ${"armorPanel.xc":"armorPanel"},
```


* Copy the folder **\res_mods\mods\shared_resources\xvm\res\MeltyElement** and its contents to **<World_of_Tanks_Path>\res_mods\mods\shared_resources\xvm\res\MeltyElement** folder.

* Copy the folder **res_mods\1.0.2.1\objects** and its contents to **<World_of_Tanks_Path>res_mods\<World_of_Tanks_Version>\objects** folder.

* Copy **meltyElement_ArmorPanel.py** to **<World_of_Tanks_Path>\res_mods\configs\xvm\py_macro**

* Copy **ArmorPanel.xc**, **meltyElementArmorPanel.xc**, and **meltyElementProtractor.xc** to where your XVM boot configs points to. Default is: **<World_of_Tanks_Path>\res_mods\configs\xvm\default**



## Known Issues

* Protractor is simi-functional in SPG/Arty due to rotation issues. It is not recommended to try and use in SPG/Arty yet.
* ArmorPanel element's position and visibility can become incorrect when looking very far to the left/right or behind your tank
* Effective armor text rarely fails to display for one battle.
* When viewing the debug render with the cameraAngle option set to True. The debug render is impossible to see because it (correctly) displays the collision points based on the camera angles.
* Does not fully/correctly reinitialize if XVM is reloaded live.



## Acknowledgments

* ktulho - py_macro and XVM
* GPCracker - XModLib
* spoter - Various code and base for debugRender
* XVM team
* MeltyMap, _RazNaRok_, garnet_auxo & everyone who has ever worked on the previous versions of melty sights and armor panel
