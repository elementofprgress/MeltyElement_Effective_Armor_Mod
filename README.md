# Element ArmorPanel & Protractor Mod - [XVM - py_macro]
# *Mod is in an Alpha state and many features, options, and some general functionality have yet to be tested.*

This mod is a remake of the ArmorPanel & Protractor that was included in the original MeltyMap sights.
Unlike the original ArmorPanel & Protractor this mod is no longer dependent on a XML sheet of tank armor and angle values.
All armor and angle values are gathered dynamically and directly from the game. 
A collision check based on your turret/camera rotation and tank's hull height is done against your own tank which returns the armor angle at that point.

The height that the collision check is done is adjustable and includes a debug render to aid with adjustment if needed. 

Options can be found in the **ArmorPanel.xc** file.

... *complete project description  and screen shots*

## Additional Features

... *document additional features, default hotkeys and options*



## Getting Started

### Prerequisites

* Install the font **\source\resources\font\ZeroThrees.ttf**

**Included **@xvm.xc** and **battleLabels.xc** files are for the release _example_ only. Overwriting your own XVM config with them will likely break your XVM. Use them as a guide if needed to see how and where additional lines are added/merged. **

### Installing


**To install you must manually merge some XVM .xc files.**

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


* Copy **source\python\meltyElement_ArmorPanel.py** to **_<World_of_Tanks_Path>_\res_mods\configs\xvm\py_macro**

* Copy **source\xvm\ArmorPanel.xc**, **source\xvm\meltyElementArmorPanel.xc**, and **source\xvm\meltyElementProtractor.xc** to where your XVM boot config( **res_mods\configs\xvm\xvm.xc** ) points to. 
Default is: **_<World_of_Tanks_Path>_\res_mods\configs\xvm\default**

* Copy the folder **\source\resources\textures\ArmorPanel** and its contents to **_<World_of_Tanks_Path>_\res_mods\mods\shared_resources\xvm\res\MeltyElement** folder.

* Copy the folder **\source\resources\textures\Protractor** and its contents to **_<World_of_Tanks_Path>_\res_mods\mods\shared_resources\xvm\res\MeltyElement** folder.

Example image path:
```
  <World_of_Tanks_Path>\res_mods\mods\shared_resources\xvm\res\MeltyElement\ArmorPanel\armorFrame.png
```

* Copy the folder **source\resources\models\objects** and its contents to **<World_of_Tanks_Path>\res_mods\<World_of_Tanks_Version>\objects** folder.

Example objects path:
```
  <World_of_Tanks_Path>\res_mods\1.0.2.1\objects\debugDot.model
```


## Known Issues

* Protractor is semi-functional in SPG/Arty due to rotation issues. It is not recommended to try and use in SPG/Arty yet.
* Looking very far to the left/right or behind your tank can result in some parts of the ArmorPanel position and visibility being incorrect.
* When viewing the debug render with the cameraAngle option set to True. The debug render is impossible to see because it (correctly) displays the collision points based on the camera angles.
* Does not fully/correctly reinitialize if XVM is reloaded live.
* At times incorrect information can be displayed during preround. This corrects itself once the battle starts.
* During preround the Armor Panel will not update with the camera movement.
* Preround initialization does not always fully update the armor panel.



## Acknowledgments

* ktulho - py_macro and XVM
* GPCracker - XModLib
* spoter - Various code and base for debugRender
* XVM team
* MeltyMap, _RazNaRok_, garnet_auxo & everyone who has ever worked on the previous versions of melty sights and armor panel
