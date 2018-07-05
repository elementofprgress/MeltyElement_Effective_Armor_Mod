import BigWorld
import Math
import datetime
import GUI
import items.vehicles
import json
import Keys
import math
import os
import re
import ResMgr
import time
import types
from AvatarInputHandler import AimingSystems
from gambiter.utils import *
from gui import DEPTH_OF_Aim
from gui import InputHandler
from gui.app_loader import g_appLoader
from gui.Scaleform import SCALEFORM_SWF_PATH_V3
from gui.Scaleform.daapi.view.battle.shared.battle_timers import PreBattleTimer
from gui.Scaleform.Flash import Flash
from gui.Scaleform.framework import ViewTypes
from gui.shared.utils.TimeInterval import TimeInterval
from tutorial.control.battle.functional import _StaticObjectMarker3D as StaticObjectMarker3D
from Vehicle import Vehicle
import vehicle_systems.tankStructure

isNotEvent = False

# WoTpath = os.getcwd()
# utills.eDebug("wotpath", WoTpath)
# WoTroot = os.getcwd()
# utills.eDebug("WoTroot", WoTroot)
# pathxml = ResMgr.openSection('../paths.xml/Paths')
# utills.eDebug("pathxml", pathxml)
# xPaths = filter(os.path.isdir, pathxml.readWideStrings('Path'))
# utills.eDebug("xPaths", xPaths)
# WoTmod = xPaths[1]
# utills.eDebug("WoTmod2", WoTmod)
# res_modPath = WoTroot + str(WoTmod)
# print "res_modPath", res_modPath
callbackID = 0
keyDict = {"MODIFIER_SHIFT": 1, "MODIFIER_CTRL": 2, "MODIFIER_ALT": 4, "KEY_NOT_FOUND": 0, "KEY_NONE": 0, "KEY_NULL": 0, "KEY_ESCAPE": 1, "KEY_1": 2, "KEY_2": 3, "KEY_3": 4, "KEY_4": 5, "KEY_5": 6, "KEY_6": 7, "KEY_7": 8, "KEY_8": 9, "KEY_9": 10, "KEY_0": 11, "KEY_MINUS": 12, "KEY_EQUALS": 13, "KEY_BACKSPACE": 14, "KEY_TAB": 15, "KEY_Q": 16, "KEY_W": 17, "KEY_E": 18, "KEY_R": 19, "KEY_T": 20, "KEY_Y": 21, "KEY_U": 22, "KEY_I": 23, "KEY_O": 24, "KEY_P": 25, "KEY_LBRACKET": 26, "KEY_RBRACKET": 27, "KEY_RETURN": 28, "KEY_LCONTROL": 29, "KEY_A": 30, "KEY_S": 31, "KEY_D": 32, "KEY_F": 33, "KEY_G": 34, "KEY_H": 35, "KEY_J": 36, "KEY_K": 37, "KEY_L": 38, "KEY_SEMICOLON": 39, "KEY_APOSTROPHE": 40, "KEY_GRAVE": 41, "KEY_LSHIFT": 42, "KEY_BACKSLASH": 43, "KEY_Z": 44, "KEY_X": 45, "KEY_C": 46, "KEY_V": 47, "KEY_B": 48, "KEY_N": 49, "KEY_M": 50, "KEY_COMMA": 51, "KEY_PERIOD": 52, "KEY_SLASH": 53, "KEY_RSHIFT": 54, "KEY_NUMPADSTAR": 55, "KEY_LALT": 56, "KEY_SPACE": 57, "KEY_CAPSLOCK": 58, "KEY_F1": 59, "KEY_F2": 60, "KEY_F3": 61, "KEY_F4": 62, "KEY_F5": 63, "KEY_F6": 64, "KEY_F7": 65, "KEY_F8": 66, "KEY_F9": 67, "KEY_F10": 68, "KEY_NUMLOCK": 69, "KEY_SCROLL": 70, "KEY_NUMPAD7": 71, "KEY_NUMPAD8": 72, "KEY_NUMPAD9": 73, "KEY_NUMPADMINUS": 74, "KEY_NUMPAD4": 75, "KEY_NUMPAD5": 76, "KEY_NUMPAD6": 77, "KEY_ADD": 78, "KEY_NUMPAD1": 79, "KEY_NUMPAD2": 80, "KEY_NUMPAD3": 81, "KEY_NUMPAD0": 82, "KEY_NUMPADPERIOD": 83, "KEY_OEM_102": 86, "KEY_F11": 87, "KEY_F12": 88, "KEY_F13": 100, "KEY_F14": 101, "KEY_F15": 102, "KEY_KANA": 112, "KEY_ABNT_C1": 115, "KEY_CONVERT": 121, "KEY_NOCONVERT": 123, "KEY_YEN": 125, "KEY_ABNT_C2": 126, "KEY_NUMPADEQUALS": 141, "KEY_PREVTRACK": 144, "KEY_AT": 145, "KEY_COLON": 146, "KEY_UNDERLINE": 147, "KEY_KANJI": 148, "KEY_STOP": 149, "KEY_AX": 150, "KEY_UNLABELED": 151, "KEY_NEXTTRACK": 153, "KEY_NUMPADENTER": 156, "KEY_RCONTROL": 157, "KEY_MUTE": 160, "KEY_CALCULATOR": 161, "KEY_PLAYPAUSE": 162, "KEY_MEDIASTOP": 164, "KEY_VOLUMEDOWN": 174, "KEY_VOLUMEUP": 176, "KEY_WEBHOME": 178, "KEY_NUMPADCOMMA": 179, "KEY_NUMPADSLASH": 181, "KEY_SYSRQ": 183, "KEY_RALT": 184, "KEY_PAUSE": 197, "KEY_HOME": 199, "KEY_UPARROW": 200, "KEY_PGUP": 201, "KEY_LEFTARROW": 203, "KEY_RIGHTARROW": 205, "KEY_END": 207, "KEY_DOWNARROW": 208, "KEY_PGDN": 209, "KEY_INSERT": 210, "KEY_DELETE": 211, "KEY_LWIN": 219, "KEY_RWIN": 220, "KEY_APPS": 221, "KEY_POWER": 222, "KEY_SLEEP": 223, "KEY_WAKE": 227, "KEY_WEBSEARCH": 229, "KEY_WEBFAVORITES": 230, "KEY_WEBREFRESH": 231, "KEY_WEBSTOP": 232, "KEY_WEBFORWARD": 233, "KEY_WEBBACK": 234, "KEY_MYCOMPUTER": 235, "KEY_MAIL": 236, "KEY_MEDIASELECT": 237, "KEY_IME_CHAR": 255, "KEY_MOUSE0": 256, "KEY_LEFTMOUSE": 256, "KEY_MOUSE1": 257, "KEY_RIGHTMOUSE": 257, "KEY_MOUSE2": 258, "KEY_MIDDLEMOUSE": 258, "KEY_MOUSE3": 259, "KEY_MOUSE4": 260, "KEY_MOUSE5": 261, "KEY_MOUSE6": 262, "KEY_MOUSE7": 263, "KEY_JOY0": 272, "KEY_JOY1": 273, "KEY_JOY2": 274, "KEY_JOY3": 275, "KEY_JOY4": 276, "KEY_JOY5": 277, "KEY_JOY6": 278, "KEY_JOY7": 279, "KEY_JOY8": 280, "KEY_JOY9": 281, "KEY_JOY10": 282, "KEY_JOY11": 283, "KEY_JOY12": 284, "KEY_JOY13": 285, "KEY_JOY14": 286, "KEY_JOY15": 287, "KEY_JOY16": 288, "KEY_JOY17": 289, "KEY_JOY18": 290, "KEY_JOY19": 291, "KEY_JOY20": 292, "KEY_JOY21": 293, "KEY_JOY22": 294, "KEY_JOY23": 295, "KEY_JOY24": 296, "KEY_JOY25": 297, "KEY_JOY26": 298, "KEY_JOY27": 299, "KEY_JOY28": 300, "KEY_JOY29": 301, "KEY_JOY30": 302, "KEY_JOY31": 303, "KEY_JOYDUP": 272, "KEY_JOYDDOWN": 273, "KEY_JOYDLEFT": 274, "KEY_JOYDRIGHT": 275, "KEY_JOYSTART": 276, "KEY_JOYSELECT": 277, "KEY_JOYBACK": 277, "KEY_JOYALPUSH": 278, "KEY_JOYARPUSH": 279, "KEY_JOYCROSS": 280, "KEY_JOYA": 280, "KEY_JOYCIRCLE": 281, "KEY_JOYB": 281, "KEY_JOYSQUARE": 282, "KEY_JOYX": 282, "KEY_JOYTRIANGLE": 283, "KEY_JOYY": 283, "KEY_JOYL1": 284, "KEY_JOYBLACK": 284, "KEY_JOYR1": 285, "KEY_JOYWHITE": 285, "KEY_JOYL2": 286, "KEY_JOYLTRIGGER": 286, "KEY_JOYR2": 287, "KEY_JOYRTRIGGER": 287, "KEY_JOYAHARD": 288, "KEY_JOYBHARD": 289, "KEY_JOYXHARD": 290, "KEY_JOYYHARD": 291, "KEY_JOYBLACKHARD": 292, "KEY_JOYWHITEHARD": 293, "KEY_JOYLTRIGGERHARD": 294, "KEY_JOYRTRIGGERHARD": 295, "KEY_JOYALUP": 304, "KEY_JOYALDOWN": 305, "KEY_JOYALLEFT": 306, "KEY_JOYALRIGHT": 307, "KEY_JOYARUP": 308, "KEY_JOYARDOWN": 309, "KEY_JOYARLEFT": 310, "KEY_JOYARRIGHT": 311, "KEY_DEBUG": 312, "KEY_LCDKB_LEFT": 320, "KEY_LCDKB_RIGHT": 321, "KEY_LCDKB_OK": 322, "KEY_LCDKB_CANCEL": 323, "KEY_LCDKB_UP": 324, "KEY_LCDKB_DOWN": 325, "KEY_LCDKB_MENU": 326, "AXIS_LX": 0, "AXIS_LY": 1, "AXIS_RX": 2, "AXIS_RY": 3}

WoTpath = os.getcwd()

WoTroot = os.getcwd()

pathxml = ResMgr.openSection('../paths.xml/Paths')

xPaths = filter(os.path.isdir, pathxml.readWideStrings('Path'))

WoTmod = xPaths[1]

modPath = WoTroot + str(WoTmod)
# noinspection PyProtectedMember


class ArmorPanelDebugRender(object):
    def __init__(self):
        # TODO - While debug render is visible lock out camera yaw for turret yaw so you can rotate the camera without moving the debug
        self.modelFakeHitPos = None
        self.modelFakeAimPos = None
        self.modelFakeHitVisible = False
        self.modelFakeShotVisible = False
        self.player = None
        self.modelPath0 = 'objects/debugDot.model'
        self.modelPath1 = 'objects/debugDot.model'
        self.showFakeHitDefault = True
        self.showFakeShotDefault = True
        # self.toggleDrawDebugRender = armorPanel.toggleDrawDebugRender
        # self.hitUp = ArmorPanel.hitUp
        # self.hitDown = ArmorPanel.hitDown
        # self.hitDefault = armorPanel.hitDefault
        self.drawDebugRender = False

    def startBattle(self):
        InputHandler.g_instance.onKeyDown += self._injectAPButton
        dataEnable = True
        if dataEnable:
            self.player = BigWorld.player()
            self.modelFakeHitVisible = self.showFakeHitDefault
            self.modelFakeShotVisible = self.showFakeShotDefault
            self.drawDebugRender = False
            self.modelPath0 = 'objects/debugDot.model'
            self.modelPath1 = 'objects/debugDot.model'
            self.modelFakeHitPos = StaticObjectMarker3D({'path': self.modelPath1}, (0, 0, 0))
            self.modelFakeAimPos = StaticObjectMarker3D({'path': self.modelPath1}, (0, 0, 0))
            if self.modelFakeAimPos._StaticObjectMarker3D__model is not None:
                self.modelFakeAimPos._StaticObjectMarker3D__model.scale = (0.2, 0.2, 0.2)
                self.modelFakeHitPos._StaticObjectMarker3D__model.scale = (0.25, 0.25, 0.25)
                self.modelFakeHitPos._StaticObjectMarker3D__model.visible = False
                self.modelFakeAimPos._StaticObjectMarker3D__model.visible = False
                self.modelFakeHitPos._StaticObjectMarker3D__model.castsShadow = False
                self.modelFakeAimPos._StaticObjectMarker3D__model.castsShadow = False

    def stopBattle(self):
        InputHandler.g_instance.onKeyDown -= self._injectAPButton
        self.modelFakeHitVisible = False
        self.modelFakeShotVisible = False
        if self.modelFakeHitPos is not None:
            self.modelFakeHitPos.clear()
        if self.modelFakeAimPos is not None:
            self.modelFakeAimPos.clear()
        self.modelFakeHitPos = None
        self.modelFakeAimPos = None

    def render(self, fakeShotHitPos, fakeShotAimPoint):
        if not self.drawDebugRender or self.player is None:
            self._hideVisible()
            return
        if not hasattr(self.player, 'vehicleTypeDescriptor') or not hasattr(self.player, 'gunRotator'):
            self._hideVisible()
            return

        if self.modelFakeHitPos is not None and self.modelFakeHitPos._StaticObjectMarker3D__model:
            tmpScale = 0.2
            self.modelFakeHitPos._StaticObjectMarker3D__model.scale = (tmpScale, tmpScale, tmpScale)
            self.modelFakeHitPos._StaticObjectMarker3D__model.position = fakeShotHitPos
        else:
            utills.eDebug(" - DebugRender] modelFakeHitPos is not None or  no .modelFakeHitPos._StaticObjectMarker3D__model")

        if self.modelFakeAimPos is not None and self.modelFakeAimPos._StaticObjectMarker3D__model:
            self.modelFakeAimPos._StaticObjectMarker3D__model.position = fakeShotAimPoint
        else:
            utills.eDebug(" - DebugRender] modelFakeAimPos is not None or  no .modelFakeAimPos._StaticObjectMarker3D__model")
        self._setVisible()

    def _setVisible(self):
        if self.modelFakeHitPos is not None and self.modelFakeHitPos._StaticObjectMarker3D__model:
            self.modelFakeHitVisible = True
            self.modelFakeShotVisible = True
            if self.modelFakeHitPos._StaticObjectMarker3D__model.visible != self.modelFakeHitVisible:
                self.modelFakeHitPos._StaticObjectMarker3D__model.visible = self.modelFakeHitVisible
        if self.modelFakeAimPos is not None and self.modelFakeAimPos._StaticObjectMarker3D__model:
            if self.modelFakeAimPos._StaticObjectMarker3D__model.visible != self.modelFakeShotVisible:
                self.modelFakeAimPos._StaticObjectMarker3D__model.visible = self.modelFakeShotVisible

    def _hideVisible(self):
        if self.modelFakeHitPos is not None and self.modelFakeHitPos._StaticObjectMarker3D__model and self.modelFakeHitPos._StaticObjectMarker3D__model.visible:
            self.modelFakeHitPos._StaticObjectMarker3D__model.visible = False
        if self.modelFakeAimPos is not None and self.modelFakeAimPos._StaticObjectMarker3D__model and self.modelFakeAimPos._StaticObjectMarker3D__model.visible:
            self.modelFakeAimPos._StaticObjectMarker3D__model.visible = False

    def _injectAPButton(self, event):
        # TODO - Save custom hit height per vehicle
        if g_appLoader.getDefBattleApp():
            # adjust the hull hit height up
            if event.key == armorPanel.toggleDrawDebugRender and event.isKeyDown():
                armorPanel.hitHullHeight = float(armorPanel.hitHullHeight) + 0.25
                hullHeightMsg = "MeltyElement AP Hull Height Multi + 0.05 to " + str(armorPanel.hitHullHeight)
                ctrl = g_appLoader.getDefBattleApp()
                if ctrl is not None:
                    battle_page = ctrl.containerManager.getContainer(ViewTypes.VIEW).getView()
                    battle_page.components['battlePlayerMessages'].as_showGreenMessageS(None, hullHeightMsg)
            # adjust the hull hit height down
            if event.key == armorPanel.hitDown and event.isKeyDown():
                armorPanel.hitHullHeight = float(armorPanel.hitHullHeight) - 0.25
                hullHeightMsg = "MeltyElement AP Hull Height Multi - 0.05 to " + str(armorPanel.hitHullHeight)
                ctrl = g_appLoader.getDefBattleApp()
                if ctrl is not None:
                    battle_page = ctrl.containerManager.getContainer(ViewTypes.VIEW).getView()
                    battle_page.components['battlePlayerMessages'].as_showGreenMessageS(None, hullHeightMsg)
            # reset the hull hit height to default/config value
            if event.key == armorPanel.hitDefault and event.isKeyDown():
                armorPanel.hitHullHeight = armorPanel.defaultHitHullHeight
                hullHeightMsg = "MeltyElement AP Hull Height Multi reset to " + str(armorPanel.hitHullHeight)
                ctrl = g_appLoader.getDefBattleApp()
                if ctrl is not None:
                    battle_page = ctrl.containerManager.getContainer(ViewTypes.VIEW).getView()
                    battle_page.components['battlePlayerMessages'].as_showGreenMessageS(None, hullHeightMsg)
            # Toggle the debugRender on/off
            if event.key == armorPanel.toggleDrawDebugRender and event.isKeyDown():
                self.drawDebugRender = not self.drawDebugRender
                self.modelFakeHitVisible = not self.modelFakeHitVisible
                self.modelFakeShotVisible = not self.modelFakeShotVisible
                message = "MeltyElement AP Debug Render - On" if self.drawDebugRender else "MeltyElement AP Debug Render - OFF"
                ctrl = g_appLoader.getDefBattleApp()
                if ctrl is not None:
                    battle_page = ctrl.containerManager.getContainer(ViewTypes.VIEW).getView()
                    if self.drawDebugRender:
                        battle_page.components['battlePlayerMessages'].as_showGreenMessageS(None, message)
                        self._setVisible()
                    else:
                        battle_page.components['battlePlayerMessages'].as_showRedMessageS(None, message)
                        self._hideVisible()


class ElementModUtilities(object):
    def __init__(self):
        pass

    # noinspection PyBroadException
    def eDebug(*args):
        argsList = []
        if armorPanel.debug:
            try:
                prefix = "DEBUG: [Element_ArmorPanel]: "
                argsList.append(prefix)
                for arg in args:
                    argsList.append(arg)
                debugLine = " ".join(map(str, argsList))
                print(debugLine)
            except Exception:
                print("ERROR: [Element_ArmorPanel] [" + datetime.datetime.now().strftime("%H:%M:%S.%f") + "]: utills.eDebug FAILED!")

    @staticmethod
    def getNormalisedVector(vector):
        return vector.scale(1.0 / vector.length)

    @staticmethod
    def d2r(degree):
        return degree * 3.14159265359 / 180

    # XmodLib (https://github.com/GPCracker/XModLib)  CollisionUtils functions - https://github.com/GPCracker/XModLib/blob/master/source/XModLib/CollisionUtils.py
    @staticmethod
    def collideVehicle(vehicle, startPoint, endPoint, skipGun=False):
        # This method returns collision data for the first armor layer only
        # Therefore it should not be used for vehicle total armor calculations
        if vehicle.appearance.collisions is not None:
            gunPartIndex = vehicle_systems.tankStructure.TankPartIndexes.GUN
            collisions = vehicle.appearance.collisions.collideAllWorld(startPoint, endPoint)
            if collisions is not None:
                for distance, hitAngleCos, materialKind, partIndex in collisions:
                    materialInfo = vehicle.getMatinfo(partIndex, materialKind)
                    if materialInfo and (not skipGun or partIndex != gunPartIndex):
                        return distance, hitAngleCos, materialInfo.armor
        return None


class ArmorPanel(Flash):
    __UPDATE_INTERVAL = 0.03
    _ArmorPanel__UPDATE_INTERVAL = 0.03

    def __init__(self):
        super(ArmorPanel, self).__init__('ArmorPanel.swf', path=SCALEFORM_SWF_PATH_V3)

        self.__timeInterval = None
        self.__isVisible = None
        self.player = None
        self.player_id = 0
        self.tankType = "Tank"
        self.cameraYaw = 0
        self.isCamAngle = True
        self.isAP = True
        self.TDenabled = True
        self.SPGenabled = True
        self.Tank_Y = 0.9
        self.TD_Y = 0.87
        self.SPG_Y = 0
        self.effArmorOffsetY = 0
        self.m2pix = 8.2
        self.xSpacing = 0
        self.debug = True
        self.penIndicator = True
        self.toggleDrawDebugRender = 66
        self.hitUp = 78
        self.hitDown = 74
        self.hitDefault = 55
        self.hitHullHeight = 0.7
        self.defaultHitHullHeight = 0.7
        self.hullHeight = None
        self.useTargetGunY = True
        self.rayLength = 8.0
        self.useGunPitch = False
        self.upDir = Math.Vector3(0, 1, 0)
        self.CurrentAimMode = "XXX"
        self.name = ""
        self.tankType = "Tank"
        self.rightArc = 0.0
        self.leftArc = 0.0
        self.front = 0.0
        self.arc = 0.0
        self.arc2 = 0.0
        self.arc3 = 0.0
        self.side = 0.0
        self.component.wg_inputKeyMode = 1
        self.component.position.z = DEPTH_OF_Aim
        self.movie.backgroundAlpha = 0.0
        self.component.focus = False
        self.component.moveFocus = False
        self.component.heightMode = 'PIXEL'
        self.component.widthMode = 'PIXEL'
        self.flashSize = GUI.screenResolution()
        self.component.visible = True
        self.addExternalCallback('ArmorPanel.ArmorPanelEnable', self.ArmorPanelEnableCallBack)

        fp = open(WoTroot + "/mods/configs/ElementArmorPanelSettings.xml")
        s = fp.read()
        decodeXML = s.decode('utf-8-sig').encode().encode("utf-8")
        fp.close()
        dataSectionXML = ResMgr.DataSection()
        dataSectionXML.createSectionFromString(decodeXML)
        print dataSectionXML
        config = dataSectionXML['mmps']
        xmlRoot = config['config']
        if config is not None:
            try:
                print "[MeltyElement] /config/ElementArmorPanelSettings.xml parsing"
                if xmlRoot.has_key('enableEffArmor'):
                    self.isAP = xmlRoot.readBool('enableEffArmor')
                if xmlRoot.has_key('cameraAngle'):
                    self.isCamAngle = xmlRoot.readBool('cameraAngle')
                if xmlRoot.has_key('enableRulerWhenTD'):
                    self.TDenabled = xmlRoot.readBool('enableRulerWhenTD')
                if xmlRoot.has_key('enableRulerWhenSPG'):
                    self.SPGenabled = xmlRoot.readBool('enableRulerWhenSPG')
                if xmlRoot.has_key('ordinateWhenTank'):
                    self.Tank_Y = xmlRoot.readFloat('ordinateWhenTank')
                if xmlRoot.has_key('ordinateWhenTD'):
                    self.TD_Y = xmlRoot.readFloat('ordinateWhenTD')
                if xmlRoot.has_key('protractorOffsetWhenTD'):
                    self.protractorOffsetWhenTD = xmlRoot.readFloat('protractorOffsetWhenTD')
                if xmlRoot.has_key('ordinateWhenSPG'):
                    self.SPG_Y = xmlRoot.readFloat('ordinateWhenSPG')
                if xmlRoot.has_key('m2pix'):
                    self.m2pix = xmlRoot.readFloat('m2pix')
                if xmlRoot.has_key('xSpacing'):
                    self.xSpacing = xmlRoot.readFloat('xSpacing')
                if xmlRoot.has_key('debug'):
                    self.debug = xmlRoot.readBool('debug')
                if xmlRoot.has_key('penIndicator'):
                    self.penIndicator = xmlRoot.readBool('penIndicator')
                if xmlRoot.has_key('debugRenderHitPosKey'):
                    self.toggleDrawDebugRender = xmlRoot.readFloat('debugRenderHitPosKey')
                if xmlRoot.has_key('posUpKey'):
                    self.hitUp = xmlRoot.readFloat('posUpKey')
                if xmlRoot.has_key('posDownKey'):
                    self.hitDown = xmlRoot.readFloat('posDownKey')
                if xmlRoot.has_key('posDefaultKey'):
                    self.hitDefault = xmlRoot.readFloat('posDefaultKey')
                if xmlRoot.has_key('hitHullHeight'):
                    self.defaultHitHullHeight = xmlRoot.readFloat('hitHullHeight')
                if xmlRoot.has_key('useTargetGunY'):
                    self.useTargetGunY = xmlRoot.readBool('useTargetGunY')
                if xmlRoot.has_key('rayLength'):
                    self.rayLength = xmlRoot.readFloat('rayLength')
                if xmlRoot.has_key('gunPitchHitAngle'):
                    self.useGunPitch = xmlRoot.readBool('gunPitchHitAngle')
            except:
                print "[MeltyElement] config found but error occurred. Check values and file is encoded UTF-8 NO BOM /ElementArmorPanelSettings.xml"
        else:
            print modPath, "[MeltyElement] config not found"
        
        return

    def populate(self):
        #   Getting access to our flash object
        #   By getting a _level0 we can access to first frame functions, but it is useless to set a flash script
        #       property - ActionScript 2.0 document have no document class. So we use an object instead. See basic
        #       info for details.
        self.__flashObject = self.getMember('_root._level0.a_modeMC')

        #   Setting a Python instance overloading ActionScript placeholders.
        #   Methods of this instance will overload ActionScript element (base class instance) methods (dummies).
        #   You can use any instance (object) here, that provides required DAAPI methods for overload.
        # self.__flashObject.script = self

        #   Populating a BigWorld GUI container.
        GUI.addRoot(self.component)

        return

    @property
    def flashObject(self):
        #   This property provides access to our flash object from outside. However, it is a private object.
        #   It's not good if code outside this class access this object directly. It would better to use wrapper methods.
        return self.__flashObject

    def destroy(self):
        #   This method should be called before you delete this class instance. Manually. Otherwise, it will cause
        #       an error. It contrasts populate method.
        #   Removing container from visible objects.
        GUI.delRoot(self.component)

        #   Resetting flash object script.
        self.__flashObject.script = None

        #   Finally, releasing flash object.
        self.__flashObject = None

        # from orig
        self.active(False)
        self.setVisible(False)
        self.__timeInterval.stop()

        return

    def __del__(self):
        #   This method is called when object is actually deleted. See Python docs for details.
        #   Unloading logging and other things (see __init__).
        self.beforeDelete()

        #   Finally call a parent class method.
        super(ArmorPanel, self).__del__()

        return

    @staticmethod
    def py_daapiMethod(number, string, array):
        import debug_utils
        debug_utils.LOG_WARNING("py_daapiMethod was called.")
        return number + len(string) + len(array)

    def as_daapiMethod_wrapper(self, number, string, array):
        #   This method is not strictly required, it may be used to wrap flashObject calls for external caller.
        return self.__flashObject.as_daapiMethod(number, string, array)

    def flashCall(self, funcName, args=None):
        self.call('ArmorPanel.' + funcName, args)

    def start(self):
        debugRender.startBattle()
        self.__timeInterval = TimeInterval(self.__UPDATE_INTERVAL, self, 'AP_update')
        self.__timeInterval.start()


    # def destroy(self):
    #     self.active(False)
    #     self.setVisible(False)
    #     self.__timeInterval.stop()

    def setVisible(self, isVisible):
        self.__isVisible = isVisible
        self.component.visible = self.__isVisible

    def getClass(self, vehicleID):
        vehicle = BigWorld.entity(vehicleID)
        return vehicle and tuple(vehicle.typeDescriptor.type.tags & items.vehicles.VEHICLE_CLASS_TAGS)[0]

    # XmodLib (https://github.com/GPCracker/XModLib)  VehicleMath functions - https://github.com/GPCracker/XModLib/blob/master/source/XModLib/VehicleMath.py
    @staticmethod
    def getTurretMatrix(vehicleTypeDescriptor, vehicleMatrix, turretYaw):
        hullPosition = vehicleTypeDescriptor.chassis.hullPosition
        turretPosition = vehicleTypeDescriptor.hull.turretPositions[0]
        turretMatrix = Math.Matrix()
        turretMatrix.setRotateY(turretYaw)
        turretMatrix.translation = hullPosition + turretPosition
        turretMatrix.postMultiply(vehicleMatrix)
        return turretMatrix

    # XmodLib (https://github.com/GPCracker/XModLib)  VehicleMath function - https://github.com/GPCracker/XModLib/blob/master/source/XModLib/VehicleMath.py
    @staticmethod
    def getGunMatrix(vehicleTypeDescriptor, turretMatrix, gunPitch):
        gunPosition = vehicleTypeDescriptor.turret.gunPosition
        gunMatrix = Math.Matrix()
        gunMatrix.setRotateX(gunPitch)
        gunMatrix.translation = gunPosition
        gunMatrix.postMultiply(turretMatrix)
        return gunMatrix

    # XmodLib (https://github.com/GPCracker/XModLib)  VehicleMath function - https://github.com/GPCracker/XModLib/blob/master/source/XModLib/VehicleMath.py
    def getShotRayAndPoint(self, vehicleTypeDescriptor, vehicleMatrix, turretYaw, gunPitch):
        turretMatrix = self.getTurretMatrix(vehicleTypeDescriptor, vehicleMatrix, turretYaw)
        gunMatrix = self.getGunMatrix(vehicleTypeDescriptor, turretMatrix, gunPitch)
        return gunMatrix.applyToAxis(2), gunMatrix.applyToOrigin()

    def getDynamicArc(self, vehicle, vehicleTypeDescriptor, vehicleMatrix, turretYaw, gunPitch):

        playerVehiclePos = BigWorld.player().getOwnVehiclePosition()

        if armorPanel.hullHeight is None:
            hullMin, hullMax, _ = vehicleTypeDescriptor.hull.hitTester.bbox
            armorPanel.hullHeight = hullMin + hullMax
        hullHeightHitVector = armorPanel.hullHeight * self.hitHullHeight
        fakeHitHullHeight = hullHeightHitVector.y + vehicleTypeDescriptor.chassis.hullPosition.y

        shotRay, shotPoint = self.getShotRayAndPoint(vehicleTypeDescriptor, vehicleMatrix, turretYaw, gunPitch)

        if self.useTargetGunY and BigWorld.target() is not None:
            # noinspection PyBroadException
            try:
                currTarget = BigWorld.target()
                fakeShotStart_ = shotPoint + utills.getNormalisedVector(shotRay).scale(self.rayLength)
                fakeShotAimPoint_ = playerVehiclePos + utills.getNormalisedVector(self.upDir).scale(fakeHitHullHeight)
                fakeShotStart_.y = fakeShotAimPoint_.y
                fakeShotStart = BigWorld.entity(currTarget.id).appearance.compoundModel.node('gun').position
                fakeShotAimPoint = playerVehiclePos + utills.getNormalisedVector(self.upDir).scale(fakeHitHullHeight)
            except Exception as eTargetGunY:
                utills.eDebug(eTargetGunY, "error with eAP.useTargetGunY and BigWorld.target() is not None")
                fakeShotStart = shotPoint + utills.getNormalisedVector(shotRay).scale(self.rayLength)
                fakeShotAimPoint = playerVehiclePos + utills.getNormalisedVector(self.upDir).scale(fakeHitHullHeight)
                if self.useGunPitch:
                    fakeShotStart.y = fakeShotAimPoint.y
        else:
            fakeShotStart = shotPoint + utills.getNormalisedVector(shotRay).scale(self.rayLength)
            fakeShotAimPoint = playerVehiclePos + utills.getNormalisedVector(self.upDir).scale(fakeHitHullHeight)
            if self.useGunPitch:
                fakeShotStart.y = fakeShotAimPoint.y

        fakeShotDir = fakeShotAimPoint - fakeShotStart
        # Only really interested in the hitAngleCos and Distance from collideVehicle. Distance to pass on to debug render
        try:
            dist, hitAngleCos, _ = utills.collideVehicle(vehicle, fakeShotStart, fakeShotAimPoint, skipGun=True)
        except Exception as e2:
            # TODO - Use last known angle or save initial angles at start of match and fall back to the old non-dynamic method
            utills.eDebug("Error:", e2, "error getting dynamic armor angle, use armor at 45 degrees as total angle.")
            hitAngleCos = 0.785398163397
            dist = 8.0

        if debugRender.drawDebugRender:
            fakeShotHitPos = fakeShotStart + utills.getNormalisedVector(fakeShotDir).scale(dist)
            debugRender.render(fakeShotHitPos, fakeShotStart)

        realArmorAngle = 90 - math.degrees(hitAngleCos)
        return realArmorAngle

    def getClassWithTurretYawLimits(self, vehicleID):
        vehicle = BigWorld.entity(vehicleID)
        vehicleClass = vehicle and tuple(vehicle.typeDescriptor.type.tags & items.vehicles.VEHICLE_CLASS_TAGS)[0]
        if vehicleClass == "SPG":
            self.tankType = "SPG"
        else:
            self.tankType = "TD"

    def getPlayerTankValues(self):
        if self.player is None:
            self.player = BigWorld.player()
        playerVehicle = BigWorld.entity(self.player_id)
        if playerVehicle is None:
            playerVehicle = BigWorld.entity(BigWorld.player().getVehicleAttached().id)
        vTypeDesc = playerVehicle.typeDescriptor
        hullArmor = vTypeDesc.hull.primaryArmor
        self.front = hullArmor[0]
        self.side = hullArmor[1]
        self.arc = 0
        if vTypeDesc.gun.turretYawLimits is not None:
            self.rightArc = abs(math.degrees(vTypeDesc.gun.turretYawLimits[0]))
            self.leftArc = abs(math.degrees(vTypeDesc.gun.turretYawLimits[1]))
            self.leftArc = float('%.1f' % self.leftArc)
            self.rightArc = float('%.1f' % self.rightArc)
            self.getClassWithTurretYawLimits(BigWorld.player().playerVehicleID)
        else:
            self.tankType = "Tank"
            self.rightArc = 0.0
            self.leftArc = 0.0
        utills.eDebug("tankType:", self.tankType, "front:", self.front, " side:", self.side, " Left:", self.leftArc, " Right:", self.rightArc)

    def setup(self, playerVehicle):
        global callbackID
        player = BigWorld.player()
        if BigWorld.player() or hasattr(player, 'isOnArena') and player.isOnArena and playerVehicle is not None:
            try:
                if callbackID is not None:
                    BigWorld.cancelCallback(callbackID)
            except:
                pass
            self.getPlayerTankValues()
            self.flashCall('removeAP', [1])
            print "[ELEMENT_ArmorPanel] Tank ", self.name, "type ", self.tankType, "rightArc ", self.rightArc, "leftArc ", self.leftArc, "front ", self.front, "arc ", self.arc, "side ", self.side
            self.flashCall('setTankValues', [self.tankType, self.leftArc, self.rightArc, self.name, self.arc])
            pass
        else:
            callbackID = BigWorld.callback(0.5, self.setup)


    @staticmethod
    def getEquArmor(armor, turretRotation, armorAngel):
        # TODO - Hijack some functions from _CrosshairShotResults for armor w/ normalization and the works
        combinedAngle = math.acos(math.cos(math.radians(abs(turretRotation))) * math.cos(math.radians(armorAngel)))
        norm = 5
        if armor < 30:
            norm *= 4
        elif armor < 40:
            norm *= 3
        elif armor < 60:
            norm *= 2
        if combinedAngle <= math.radians(norm):
            combinedAngle = 0
        else:
            combinedAngle -= math.radians(norm)  # 0.0523596  # 3 degrees
        # 1.221730 = ~69.9 deg and 1.919862 = 109.9 deg:
        if 1.2217304764 < abs(combinedAngle) < 1.91986217719:
            return 999
        equArmor = abs(armor / math.cos(combinedAngle))
        if equArmor >= 999:
            return "999"
        return int(round(equArmor, 0))

    def AP_update(self):
        if BigWorld.player() and isAlive(BigWorld.player().playerVehicleID):  # or BigWorld.isKeyDown(Keys.KEY_LALT):
            self.player = BigWorld.player()
            player = BigWorld.player()
            self.player_id = BigWorld.player().playerVehicleID
            player_id = BigWorld.player().playerVehicleID
            showArmorPanel = self.showArmorPanel(self.tankType)
            if showArmorPanel:
                if self.CurrentAimMode != BigWorld.player().inputHandler.ctrlModeName:
                    self.CurrentAimMode = BigWorld.player().inputHandler.ctrlModeName
                ownVehicle = BigWorld.entity(BigWorld.player().playerVehicleID)
                # gunPitch = Math.Matrix(BigWorld.player().gunRotator.gunMatrix).pitch
                # gunPitch = math.degrees(gunPitch)
                ownAvatar = BigWorld.player()
                playerVehTypeDesc = ownAvatar.vehicleTypeDescriptor
                vehicleMP = ownAvatar.getOwnVehicleMatrix()
                gunRotator = BigWorld.player().gunRotator
                try:
                    desiredShotPoint = gunRotator.predictLockedTargetShotPoint()
                    if desiredShotPoint is None:
                        desiredShotPoint = self.player.inputHandler.getDesiredShotPoint()
                    if desiredShotPoint is None:
                        desiredShotPoint = gunRotator.markerInfo[0]
                except AttributeError as AttE:
                    return
                cameraTurretYaw, cameraTurretYaw_ = AimingSystems.getTurretYawGunPitch(playerVehTypeDesc, self.player.getOwnVehicleStabilisedMatrix(), desiredShotPoint, True)
                TankYaw = math.degrees(Math.Matrix(vehicleMP).yaw)
                yawRx = Math.Matrix(BigWorld.player().gunRotator.turretMatrix).yaw if not self.isCamAngle else cameraTurretYaw
                yawDx = math.degrees(Math.Matrix(BigWorld.player().gunRotator.turretMatrix).yaw) if not self.isCamAngle else math.degrees(cameraTurretYaw)
                turretYaw = math.degrees(Math.Matrix(BigWorld.player().gunRotator.turretMatrix).yaw)
                if self.CurrentAimMode == 'sniper' and self.tankType == 'TD' and self.isCamAngle:
                    yawDx = turretYaw if not math.fabs(turretYaw) > abs(self.leftArc) else yawDx
                turretPitch = Math.Matrix(gunRotator.gunMatrix).pitch
                if self.CurrentAimMode != 'arcade' and self.tankType == 'SPG':
                    arc = 0.0
                else:
                    arc = self.getDynamicArc(ownVehicle, playerVehTypeDesc, vehicleMP, yawRx, turretPitch)
                AyawDx = math.fabs(math.degrees(Math.Matrix(BigWorld.player().gunRotator.turretMatrix).yaw)) if not self.isCamAngle else math.fabs(yawDx)
                effFrontArmor = self.getEquArmor(self.front, AyawDx, arc)
                effSideArmor = self.getEquArmor(self.side, (90 - math.fabs(AyawDx)), 0)
                self.flashCall('getEffArmor', [effFrontArmor, effSideArmor, yawRx, yawDx, turretYaw, int(self.leftArc), int(self.rightArc), self.tankType, TankYaw, self.CurrentAimMode])
                if BigWorld.target() is not None:
                    typeDescr = BigWorld.target().typeDescriptor
                    shellPower = [0, 0, 0]
                    j = 0
                    for element in typeDescr.gun.shots:
                        shellPower[j] = element.piercingPower[0]
                        j = j + 1
                    self.flashCall('getTargetPen', [1, shellPower[0], shellPower[1], shellPower[2]])
                else:
                    self.flashCall('getTargetPen', [0, 0, 0, 0])
        if BigWorld.player().arena.vehicles[BigWorld.player().playerVehicleID]['isAlive']:
            self.flashCall('removeAP', [0])
        else:
            self.flashCall('removeAP', [1])
        if BigWorld.player() is not None:
            if BigWorld.player().inputHandler.ctrlModeName is not None:
                aimMode = BigWorld.player().inputHandler.ctrlModeName
                self.CurrentAimMode = BigWorld.player().inputHandler.ctrlModeName
                if aimMode == 'postmortem':
                    self.flashCall('AimMode', [aimMode])
        else:
            aimMode = None
            self.CurrentAimMode = aimMode
        return

    # def targetEnableCallBack(self, cid, team, enemy, dead):
    #     self.isTeam = team
    #     self.isEnemy = enemy
    #     self.isDead = dead

    def ArmorPanelEnableCallBack(self, cid, AP, eCA, eTD, eSPG, ordTank, ordTD, ordSPG, xspace):
        # print "ArmorPanelEnableCallBack"
        self.isCamAngle = eCA
        # print "camAngle", self.isCamAngle
        self.isAP = AP
        # print "AP: ", self.isAP
        self.TDenabled = eTD
        # print "eTD: ", self.TDenabled
        self.SPGenabled = eSPG
        # print "eSPG: ", self.SPGenabled
        self.Tank_Y = ordTank
        # print "ordTank: ", self.Tank_Y
        self.TD_Y = ordTD
        # print "ordTD: ", self.TD_Y
        self.SPG_Y = ordSPG
        # print "ordSPG: ", self.SPG_Y
        self.xSpacing = xspace  # print "xspace: ", self.xSpacing

    def showArmorPanel(self, tanktype):
        if tanktype == "SPG":
            if self.SPGenabled:
                return True
        elif tanktype == "TD":
            if self.TDenabled:
                return True
        elif tanktype == "Tank":
            if self.isAP:
                return True
        else:
            return False

    def sendFlashSettings(self, enableEffArmor, cameraAngle, enableWhenTD, enableWhenSPG, heightTank, heightTD, offsetTD, heightSPG, m2pix, xSpacing, bmkcode, enableAPdebug, enablePenlight):
        self.flashCall('applyConfig', [enableEffArmor, cameraAngle, enableWhenTD, enableWhenSPG, heightTank, heightTD, offsetTD, heightSPG, m2pix, xSpacing, bmkcode, enableAPdebug, enablePenlight])


# check()
armorPanel = ArmorPanel()
armorPanel.sendFlashSettings(armorPanel.isAP, armorPanel.isCamAngle, armorPanel.TDenabled, armorPanel.SPGenabled, armorPanel.Tank_Y, armorPanel.TD_Y, armorPanel.protractorOffsetWhenTD, armorPanel.SPG_Y, armorPanel.m2pix, armorPanel.xSpacing, 0, armorPanel.debug, armorPanel.penIndicator)
utills = ElementModUtilities()
debugRender = ArmorPanelDebugRender()


def isAlive(vehicle):
    if not isinstance(vehicle, (BigWorld.Entity, types.NoneType)):
        vehicle = BigWorld.entity(vehicle)
    return vehicle and vehicle.isAlive()


# noinspection PyUnusedLocal
@registerEvent(Vehicle, 'onLeaveWorld')
def ME_AP_Vehicle_onLeaveWorld(self):
    global armorPanel
    if self.isPlayerVehicle:
        debugRender.stopBattle()
        armorPanel.destroy()
        armorPanel = None


# noinspection PyUnusedLocal
@registerEvent(Vehicle, 'onEnterWorld')
def ME_AP_Vehicle_onEnterWorld(self, prereqs):
    global isNotEvent, armorPanel
    # global armorPanel
    if self.isPlayerVehicle:
        isNotEvent = True
        if armorPanel is None:
            armorPanel = ArmorPanel()
        armorPanel.populate()
        armorPanel.sendFlashSettings(armorPanel.isAP, armorPanel.isCamAngle, armorPanel.TDenabled, armorPanel.SPGenabled, armorPanel.Tank_Y, armorPanel.TD_Y, armorPanel.protractorOffsetWhenTD, armorPanel.SPG_Y, armorPanel.m2pix, armorPanel.xSpacing, 0, armorPanel.debug, armorPanel.penIndicator)
        global isIAPisible
        armorPanel.active(True)
        isIAPisible = True
        armorPanel.setVisible(True)
        armorPanel.flashCall('removeAP', [0])
        armorPanel.player_id = BigWorld.player().playerVehicleID
        playerVehicle = BigWorld.entity(BigWorld.player().playerVehicleID)
        armorPanel.player = BigWorld.player()
        armorPanel.setup(playerVehicle)


# noinspection PyUnusedLocal
@registerEvent(PreBattleTimer, 'hideCountdown')
def ME_AP_APhideCountdown(self, state, speed):
    utills.eDebug("hideCountdown")
    if state == 3:
        armorPanel.start()


print "--------------------------------------------------------------------------------------"
print "[Element_AP]: Loading Element ArmorPanel & Protractor Mod " + time.strftime("%H:%M:%S")
print "[Element_AP]: Element_ArmorPanel: Beta v0.1b  Built: 07.05.2018"
print "--------------------------------------------------------------------------------------"