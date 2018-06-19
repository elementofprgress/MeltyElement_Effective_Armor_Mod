/**
 * List of battle interface labels.
 */
{
  "labels": {
    // Referenced labels:
    // * every custom field can be separate enabled or disabled by "enabled" switch in their settings.
    // * extended format supported, see extra-field.txt
    "formats": [
      ${ "battleLabelsTemplates.xc":"def.hitlogHeader" },
      ${ "battleLabelsTemplates.xc":"def.hitlogBody" },
      ${ "battleLabelsTemplates.xc":"def.winChance" },
      // ${ "battleLabelsTemplates.xc":"def.teamRating" },
      ${ "battleLabelsTemplates.xc":"def.totalHP" },
      ${ "battleLabelsTemplates.xc":"def.avgDamage" },
      ${ "battleLabelsTemplates.xc":"def.mainGun" },
      ${ "battleLabelsTemplates.xc":"def.damageLogBackground" },
      ${ "battleLabelsTemplates.xc":"def.damageLog" },
      ${ "battleLabelsTemplates.xc":"def.lastHit" },
      ${ "battleLabelsTemplates.xc":"def.fire" },
      ${ "battleLabelsTemplates.xc":"def.totalEfficiency" },
      ${ "battleLabelsTemplates.xc":"def.repairTimeEngine" },
      ${ "battleLabelsTemplates.xc":"def.repairTimeGun" },
      ${ "battleLabelsTemplates.xc":"def.repairTimeTurret" },
      ${ "battleLabelsTemplates.xc":"def.repairTimeTracks" },
      ${ "battleLabelsTemplates.xc":"def.repairTimeSurveying" },
      ${ "battleLabelsTemplates.xc":"def.repairTimeRadio" },
	  //
	  // * Armor Panel templates / defs - add this to your battleLables.xc file. 
	  // * Only the lines that reference meltyElementArmorPanel.xc are needed.
	  // *
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
	  // *
	  // * end Armor Panel lines
	  // *
      ${ "meltyElementExtraInfo.xc":"def.hitAngle" },
      ${ "meltyElementExtraInfo.xc":"def.penetrationChance" },
      ${ "meltyElementExtraInfo.xc":"def.timeToAim" },
      // ${ "meltyElementArmorPanel.xc":"def.DEBUG_DATA_00" },
      // ${ "meltyElementArmorPanel.xc":"def.DEBUG_DATA_01" },
	  // ${ "meltyElementProtractor.xc":"def.RULER_DEBUG_DATA_00" },
	  // ${ "meltyElementProtractor.xc":"def.RULER_DEBUG_DATA_01" },
      {}
    ]
  }
}
