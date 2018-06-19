{
  "armorPanel": {
    // enable
    "enable": true,
	// warn when no arc found, print outs etc, etc
	"debug": true,
	"eAP": {
	  // Displays effective armor calculation.  only when armor values are present in vehiclesData section
	  "enableEffArmor": true,
	  // effective armor calculation follows the camera, if false it follow your turret
	  "cameraAngle": true,
	  // Vertical placement of Effective armor calculation ( In percentage of lower half vertical screen resolution ).
	  "ordinateWhenTank": 0.75,
	  // Vertical placement of Effective armor calculation ( In percentage of lower half vertical screen resolution ).
	  "ordinateWhenTD": 0.70,
	  // use your currents target hight to check effective armor
	  "useTargetGunY": true,
	  // collision check height used to determine angle of your tanks armor. aim point is the center of your hull. Adjust the vertical axis via percent of your hull's height. 0.0 would the bottom of your hull while 1.0 the very top.
	  "hitHullHeight": 0.75,
	  // use the guns pitch to determine the angle of the collision check. Disabled the collision check will start at the same global height as the hull height chosen. Enabled you will get you effective Armor for where you are looking both Vertically and Horz
	  "gunPitchHitAngle": true,
	  // The distance away from vehicle to start the collision check. (collision check ignores everything but your vehicle)
	  "rayLength": 20.0
	},
	"protractor": {
	  // Displays GunArc Critical Angle Protractor for TD's.
	  "enableProtractorWhenTD": true,
	  //enable Protractor when in Arcade mode
	  "showInArcade": true,
	  //use camera rotation for Protractor position. False will lock the Protractor at max value when looking past gun arc. True will let the Protractor move off screen.
	  "useCameraRotation": true,
	  // Vertical placement of TD GunArc Protractor ( where 0 is screen center and 1 its bottom ).
	  "protractorOffsetWhenTD": 43,
	  // WIP / Not Implimented - Displays GunArc Critical Angle Protractor for SPG's. 
	  "enableProtractorWhenSPG": false,
	  // placement of SPG GunArc Protractor. ( In percentage of lower half vertical screen resolution ) Recommend 0 or ~0.7-0.1
	  "ordinateWhenSPG": 0.1,
	  // Distance to Pixels ratio, Default is 1m = 8.2px.
	  "m2pix": 8.2,
	  // GunArc Protractor degree dash'es spacing, default is 0 adaptive. Recommended setting for fixed spacing is 16 or 32.
	  "xSpacing": 0
	},
	"debugRender": {
	  //Toggle the rendering of the start and end point being used for the collision check. Useful to see if the collision point needs to be adjusted verticaly. Default is F8
	  "debugRenderHitPosKey": 66,
	  // KEY_ADD  78
	  "posUpKey": 78,
	  // KEY_NUMPADMINUS  74
	  "posDownKey": 74,
	  // Key_numstar xx
	  "posDefaultKey": 55
    },
     // rate at which armor panel loopsupdates 0.033 = 30hz 0.016 = 60hz fps hit
    "tickRate": 0.022
  }
}

