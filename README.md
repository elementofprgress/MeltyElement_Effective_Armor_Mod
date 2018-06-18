# Element ArmorPanel & Protractor Mod

...description...

## Getting Started

...

### Prerequisites

* Install the font **\RequiredFont\ZeroThrees.ttf**

### Installing


* Copy \res_mods\mods\shared_resources\xvm\res\MeltyElement\... to your **\res_mods\mods\shared_resources\xvm\res\MeltyElement**

* Copy **res_mods\1.0.2.1\objects\**... to **res_mods\<current WoT version>\objects**

* Copy **meltyElement_ArmorPanel.py** to **\res_mods\configs\xvm\py_macro\**

* Copy **ArmorPanel.xc**, **meltyElementArmorPanel.xc**, and **meltyElementProtractor.xc** to where your XVM boot configs points to. Default is: **\res_mods\configs\xvm\default\**


* In the file **battleLabels.xc** add:

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

* In the **@xvm.xc file**, add a link to the armorPanel.xc file:

```
  "armorPanel": ${"armorPanel.xc":"armorPanel"},
```

See included files for an example.

## Acknowledgments

* ktulho
* GPCracker
* spoter
* XVM team
* MeltyMap, _RazNaRok_, garnet_auxo & everyone who has ever worked on the previous versions of melty sights and armor panel

