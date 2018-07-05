# coding=utf-8
# -------------------------
# Python imports
# -------------------------
import datetime
import math
import time
# -------------------------
# BigWorld imports
# -------------------------
import BigWorld
import Math
# -------------------------
# WoT Events
# -------------------------
# from Avatar import PlayerAvatar
from gui.Scaleform.daapi.view.battle.classic.stats_exchange import FragsCollectableStats
from gui.Scaleform.daapi.view.battle.shared.battle_timers import PreBattleTimer
from Vehicle import Vehicle
# -------------------------
#    WoT Client  imports
# -------------------------
import vehicle_systems.tankStructure
import items.vehicles
from gui import InputHandler
# noinspection PyProtectedMember
from tutorial.control.battle.functional import _StaticObjectMarker3D as StaticObjectMarker3D
from gui.app_loader import g_appLoader
from gui.Scaleform.framework import ViewTypes
from AvatarInputHandler import AimingSystems
from AvatarInputHandler.aih_constants import CTRL_MODE_NAME
import AvatarInputHandler
# -------------------------
#  XVM / XFW imports
# -------------------------
from xfw import *
import xvm_main.python.config as config

isReset = False


class MeltyElementProtractor:
    def __init__(self):
        self.rotation = 0
        self.showInArcade = config.get('armorPanel/protractor/showInArcade', False)
        self.useCameraRotation = config.get('armorPanel/protractor/useCameraRotation', True)
        self.circle_xscale = 1
        self.circle_x = 0
        self.atRMax = False
        self.atLMax = False
        self.middleLine_x = 0
        self.x = None
        self.y = None
        self.useProtractorTD = False
        self.useProtractorSPG = False
        self.rightArc = None
        self.heightSPG = 0.0
        self.midX = BigWorld.screenWidth() / 2
        self.midY = BigWorld.screenHeight() / 2
        self.leftArc = None
        self.enable = False
        self.realMidLine_right_alpha = 0.0
        self.realMidLine_left_alpha = 0.0
        self.leftLine_x = 0
        self.mask_x = 0
        self.rightLine_x = 0
        self.mask_width = 0
        self.middleLine_txt_text = ""
        self.leftLine_img = "LeftLine"
        self.rightLine_img = "RightLine"
        self.middleLine_img = "middleLine"
        self.xSpacing = config.get('armorPanel/protractor/xSpacing', 0)
        # self.m2pix = config.get('armorPanel/protractor/m2pix', 40.4761904762)
        self.protractorOffsetWhenTD = config.get('armorPanel/protractor/protractorOffsetWhenTD', 43)

    def initialValues(self):
        if config.get('armorPanel/protractor/xSpacing', 0) == 0:
            # xSpacing = leftArc + rightArc < 30 ? 32 : 16
            if (ME_Tank.leftArc + ME_Tank.rightArc) < 30:
                self.xSpacing = 32
            else:
                self.xSpacing = 16
        else:
            config.get('armorPanel/protractor/xSpacing', 32)
        turretYawRad = 0.0
        self.middleLine_x = turretYawRad * self.xSpacing
        self.leftLine_img = "LeftLine"
        self.rightLine_img = "RightLine"
        self.middleLine_img = "middleLine"
        self.leftLine_x = (0 - (ME_Tank.leftArc * self.xSpacing - turretYawRad * self.xSpacing)) - 12
        self.rightLine_x = (ME_Tank.rightArc * self.xSpacing + turretYawRad * self.xSpacing) + 11
        self.middleLine_txt_text = " 0"
        self.mask_width = self.rightLine_x - self.leftLine_x
        self.mask_x = self.leftLine_x  # self.leftLine_x + (self.mask_width / 2)
        if self.xSpacing == 0.0:
            self.circle_xscale = 1.0
        else:
            self.circle_xscale = self.xSpacing / self.xSpacing * 100.0  # circle is the line itself
            self.circle_x = self.leftLine_x + (self.mask_width / 2)
            self.realMidLine_left_alpha = 0.0
            self.realMidLine_right_alpha = 0.0

    def showProtractor(self):
        if ME_Tank.tankType == "SPG":
            if config.get('armorPanel/protractor/enableProtractorWhenSPG', True):
                self.enable = True
        elif ME_Tank.tankType == "TD":
            if config.get('armorPanel/eAP/enableProtractorWhenTD', True):
                self.enable = True
        else:
            self.enable = False

    def updateProtractor(self, turretYawDeg, cameraTurretYawDeg, leftArc, rightArc):
        self.rotation = 0
        if self.useProtractorTD or self.useProtractorSPG:
            if self.useCameraRotation:
                angleYawDeg = (0 - cameraTurretYawDeg)
            else:
                angleYawDeg = (0 - turretYawDeg)
            if leftArc + rightArc < 30:
                self.xSpacing = 32
            else:
                self.xSpacing = 16
            self.middleLine_x = angleYawDeg * self.xSpacing
            if abs(angleYawDeg) >= leftArc:
                atLMax = True
                self.leftLine_img = "LeftLineMax"
            else:
                atLMax = False
                self.leftLine_img = "LeftLine"

            if abs(angleYawDeg) >= rightArc:
                atRMax = True
                self.rightLine_img = "RightLineMax"
            else:
                atRMax = False
                self.rightLine_img = "RightLine"

            if not atRMax or not atLMax:
                self.middleLine_img = "middleLine"
            else:
                self.middleLine_img = "middleLineMax"

            self.leftLine_x = (0 - (leftArc * self.xSpacing - angleYawDeg * self.xSpacing)) - 12
            self.rightLine_x = (rightArc * self.xSpacing + angleYawDeg * self.xSpacing) + 11
            self.middleLine_txt_text = str(int(angleYawDeg))
            if len(self.middleLine_txt_text) < 2:
                self.middleLine_txt_text = " " + self.middleLine_txt_text
            self.mask_width = self.rightLine_x - self.leftLine_x
            self.mask_x = self.leftLine_x  # self.leftLine_x + (self.mask_width / 2)
            if self.xSpacing == 0.0:
                self.circle_xscale = 1.0
            else:
                self.circle_xscale = self.xSpacing / self.xSpacing * 100.0  # circle is the line itself
                # self.x = self._parent_midX
                self.circle_x = self.leftLine_x + (self.mask_width / 2)
            if turretYawDeg > 0 and (abs(angleYawDeg) - 1) > leftArc:
                self.realMidLine_left_alpha = 100.0
            else:
                self.realMidLine_left_alpha = 0.0
            if turretYawDeg < 0 and (abs(angleYawDeg) - 1) > rightArc:
                self.realMidLine_right_alpha = 100.0
            else:
                self.realMidLine_right_alpha = 0.0
        as_event('ON_ARMOR')

    # noinspection PyUnusedLocal
    def setArtyProtractor(self, turretYawDeg, leftArc, rightArc, tankYawDeg, aimMode):
        turYawR = (0 - turretYawDeg)
        eAP.front_txt_alpha = 0
        eAP.front_sqrt_alpha = 0
        eAP.side_txt_alpha = 0
        eAP.side_sqrt_alpha = 0
        eAP.armorFrame_alpha = 0
        if leftArc + rightArc < 30:
            self.xSpacing = 32
        else:
            self.xSpacing = 16
        self.middleLine_x = turYawR * self.xSpacing
        if aimMode != "strategic":
            self.rotation = 0
            # self.y = eAP.y + 43
        else:
            # self.y = 0
            # will need to change eventually, fow i'm just using turret rotation anyways
            # TODO - find solution to make whole panel rotate as one of get elements to circle/line to rotate on center.
            self.rotation = 0  # tankYawDeg
            # none of the self.x/y matters at the moment. Previously in flash the x/y pos for the entire panel itself would be adjusted here.
            if abs(self.heightSPG) < 1:
                offset = self.heightSPG * self.midY
            else:
                offset = self.heightSPG

            # self.x = offset == 0 ? 0: (midX - offset * Math.sin(self.rotation / 180 * 3.14159265359)) - midX
            if offset == 0:
                self.x = 0
            else:
                # shouldn't need midx because 0 is center f not upper left like in the flash
                self.x = (self.midX - offset * math.sin(self.rotation / 180 * 3.14159265359))  # - self.midX

            # self.y = offset == 0 ? 0: (midY + offset * math.cos(self.rotation / 180 * 3.14159265359)) - midY
            if offset == 0:
                self.y = 0
            else:
                # shouldn't need midY because 0 is center screen not top like in the flash
                self.y = (self.midY + offset * math.cos(self.rotation / 180 * 3.14159265359))  # - self.midY
        if abs(round(turretYawDeg)) > ME_Tank.leftArc:
            atLMax = True
            self.leftLine_img = "LeftLineMax"
        else:
            atLMax = False
            self.leftLine_img = "LeftLine"

        if abs(round(turretYawDeg)) > ME_Tank.rightArc:
            atRMax = True
            self.rightLine_img = "RightLineMax"
        else:
            atRMax = False
            self.rightLine_img = "RightLine"

        if not atRMax or not atLMax:
            self.middleLine_img = "middleLine"
        else:
            self.middleLine_img = "middleLineMax"

        self.leftLine_x = (0 - (leftArc * self.xSpacing - turYawR * self.xSpacing)) - 12
        self.rightLine_x = (rightArc * self.xSpacing + turYawR * self.xSpacing) + 11
        self.middleLine_txt_text = str(int(turretYawDeg))
        if len(self.middleLine_txt_text) < 2:
            self.middleLine_txt_text = " " + self.middleLine_txt_text
        self.mask_width = self.rightLine_x - self.leftLine_x
        self.mask_x = self.leftLine_x  # self.leftLine_x + (self.mask_width / 2)
        self.circle_xscale = self.xSpacing / self.xSpacing * 100.0  # circle is the line itself
        # self.x = self._parent_midX
        self.circle_x = self.leftLine_x + (self.mask_width / 2)
        if turretYawDeg > 0 and abs(turYawR) > leftArc:
            self.realMidLine_left_alpha = 100.0
        else:
            self.realMidLine_left_alpha = 0.0
        if turretYawDeg < 0 and turYawR > rightArc:
            self.realMidLine_right_alpha = 100.0
        else:
            self.realMidLine_right_alpha = 0.0
        as_event('ON_ARMOR')


class EffectiveArmorPanel:
    def __init__(self):
        self.enable = False
        self.armorCallBack = 0
        self.tickRate = config.get('armorPanel/tickRate', 0.033)
        self.isCamAngle = config.get('armorPanel/eAP/cameraAngle', True)
        self.y = None
        self.armorFrame_alpha = 100
        self.front__visible = True
        self.front_sqrt_alpha = 100
        self.old_front_sqrt_alpha = 100
        self.front_txt_alpha = 100
        self.old_front_txt_alpha = 100
        self.side_txt_alpha = 100.0
        self.side_sqrt_alpha = 100
        self.side_txt_x = 0.0
        self.front_x = 0.0
        self.side_sqrt_xscale = 0.0
        self.side_x = 0.0
        self.front_txt_x = 0.0
        self.front_sqrt_xscale = 1.0
        self.upDir = Math.Vector3(0, 1, 0)
        self.useTargetGunY = config.get('armorPanel/eAP/useTargetGunY', True)
        self.rayLength = config.get('armorPanel/eAP/rayLength', 8.0)
        self.useGunPitch = config.get('armorPanel/eAP/gunPitchHitAngle', False)
        self.hitHullHeight = config.get('armorPanel/eAP/hitHullHeight', 0.7)

    def showArmorPanel(self):
        if ME_Tank.tankType != "SPG" and config.get('armorPanel/eAP/enableEffArmor', True):
            self.enable = True
        else:
            self.enable = False

    def setFrontVisible(self, isFrontVisible):
        # var is true, turn on visible but only if its not already visible
        if isFrontVisible and not self.front__visible:
            if self.old_front_sqrt_alpha is not None:
                self.front_sqrt_alpha = self.old_front_sqrt_alpha
            else:
                self.front_sqrt_alpha = 100
            if self.old_front_txt_alpha is not None:
                self.front_txt_alpha = self.old_front_txt_alpha
            else:
                self.front_txt_alpha = 100
            self.front__visible = True

        # if set to turn off visible and is currently visible
        if not isFrontVisible and self.front__visible:
            # update old values for later
            self.old_front_txt_alpha = self.front_txt_alpha
            self.old_front_sqrt_alpha = self.front_sqrt_alpha
            self.front_txt_alpha = 0
            self.front_sqrt_alpha = 0
            self.front__visible = False
        as_event('ON_ARMOR')

    @staticmethod
    def getEquArmor(armor, turretYawDeg, cameraTurretYawDeg, armorAngel):
        if eAP.isCamAngle:
            turretRotation = cameraTurretYawDeg
        else:
            turretRotation = turretYawDeg
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

    def updateEffArmor(self, effFrontArmor, turretYawDeg, cameraTurretYawDeg):
        front_txt_text = str(effFrontArmor)
        if self.isCamAngle:
            eAPYawDeg = cameraTurretYawDeg
        else:
            eAPYawDeg = turretYawDeg
        abs_YawDeg = abs(eAPYawDeg)
        if abs_YawDeg <= 10:
            if self.side_txt_alpha > 0:
                self.side_txt_alpha -= 10
            else:
                pass
                # self.side_txt_alpha = 0
        else:
            if self.side_txt_alpha < 100:
                self.side_txt_alpha += 20
            else:
                pass
                # self.side_txt_alpha == 100
        if front_txt_text == "999":
            if self.front_txt_alpha > 0:
                self.front_txt_alpha -= 10
            else:
                self.front_txt_alpha = 0
        else:
            if self.front_txt_alpha < 100:
                self.front_txt_alpha += 20
            else:
                pass
                # self.front_txt_alpha == 100
        if abs_YawDeg > 90:
            # self.front__visible = False
            self.setFrontVisible(False)
        else:
            # self.front__visible = True
            self.setFrontVisible(True)
        cosYawRad = math.cos(utills.d2r(eAPYawDeg))
        sinYawRad_x2 = (math.sin(utills.d2r(eAPYawDeg))) * 2
        sinYawRad = math.sin(math.radians(eAPYawDeg))
        self.front_x = -33 * sinYawRad
        self.front_sqrt_xscale = cosYawRad
        # hack fix using front x for front text x when inbetween -1 and 1 to prevent text from jumping when turret yaw transitions from 0 to -/+ 1
        if -1 < self.front_x < 1:
            self.front_txt_x = self.front_x
        elif self.front_x <= -1:
            self.front_txt_x = (cosYawRad * 21.5 - 21.5 - 25.0) + 15
        else:
            self.front_txt_x = (-cosYawRad * 21.5 + 21.5 + 25.0) - 15
        # front and side have same origin of 0/center. In flash they did not. Side was offset by 25px. +/- 2px for extra overlap
        if self.front_x >= 0:
            self.side_x = self.front_x - cosYawRad * 21.5 - 2.5 + 27
        else:
            self.side_x = self.front_x + cosYawRad * 21.5 + 2.5 + 23
        # fix for front sqrt when looking to the right. Positions it to the left of side_sqrt offset by the x_scaled width of front_sqrt
        if self.front_x < -7:
            self.front_x = self.side_x + ((cosYawRad * 50) * -1) + 5
        if self.front_x < 0:
            self.side_sqrt_xscale = math.fabs(sinYawRad_x2)
        else:
            self.side_sqrt_xscale = sinYawRad_x2
        if self.front_x >= 0:
            self.side_txt_x = self.front_txt_x + (-8.0 * len(front_txt_text))
        else:
            self.side_txt_x = self.front_txt_x + (8.0 * len(front_txt_text)) + 25
        as_event('ON_ARMOR')

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

    def getDynamicArc(self, vehicle, vehicleTypeDescriptor, vehicleMatrix, turretYawRad, cameraTurretYawRad, gunPitch):
        if self.isCamAngle:
            turretYaw = cameraTurretYawRad
        else:
            turretYaw = turretYawRad

        playerVehiclePos = BigWorld.player().getOwnVehiclePosition()

        if ME_Tank.hullHeight is None:
            hullMin, hullMax, _ = vehicleTypeDescriptor.hull.hitTester.bbox
            ME_Tank.hullHeight = hullMin + hullMax
        hullHeightHitVector = ME_Tank.hullHeight * self.hitHullHeight
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


class MeltyElementTank:
    def __init__(self):
        self.angleDiff = None
        self.turretYawDeg = None
        self.aimMode = "arcade"
        self.callbackID = 0
        self.effFrontArmor = None
        self.effSideArmor = None
        self.front = None
        self.side = None
        self.leftArc = None
        self.rightArc = None
        self.hullHeight = None
        self.player = None
        self.playerVehicleID = None
        self.tankType = "Tank"
        self.alive = None
        self.cameraTurretYaw = 0.0

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
        playerVehicle = BigWorld.entity(self.playerVehicleID)
        if playerVehicle is None:
            playerVehicle = BigWorld.entity(BigWorld.player().getVehicleAttached().id)
        vTypeDesc = playerVehicle.typeDescriptor
        hullArmor = vTypeDesc.hull.primaryArmor
        self.front = hullArmor[0]
        self.side = hullArmor[1]
        # use standard front armor given by WoT as effective front armor in pre-battle to avoid errors with variables yet to be defined like gun marker position
        self.effFrontArmor = self.front
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
        self.toggleDrawDebugRender = config.get('armorPanel/debugRender/debugRenderHitPosKey', 66)
        self.hitUp = config.get('armorPanel/debugRender/posUpKey', 78)
        self.hitDown = config.get('armorPanel/debugRender/posDownKey', 74)
        self.hitDefault = config.get('armorPanel/debugRender/posDefaultKey', 55)
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
            if event.key == self.toggleDrawDebugRender and event.isKeyDown():
                eAP.hitHullHeight = float(eAP.hitHullHeight) + 0.25
                hullHeightMsg = "MeltyElement AP Hull Height Multi + 0.05 to " + str(eAP.hitHullHeight)
                ctrl = g_appLoader.getDefBattleApp()
                if ctrl is not None:
                    battle_page = ctrl.containerManager.getContainer(ViewTypes.VIEW).getView()
                    battle_page.components['battlePlayerMessages'].as_showGreenMessageS(None, hullHeightMsg)
            # adjust the hull hit height down
            if event.key == self.hitDown and event.isKeyDown():
                eAP.hitHullHeight = float(eAP.hitHullHeight) - 0.25
                hullHeightMsg = "MeltyElement AP Hull Height Multi - 0.05 to " + str(eAP.hitHullHeight)
                ctrl = g_appLoader.getDefBattleApp()
                if ctrl is not None:
                    battle_page = ctrl.containerManager.getContainer(ViewTypes.VIEW).getView()
                    battle_page.components['battlePlayerMessages'].as_showGreenMessageS(None, hullHeightMsg)
            # reset the hull hit height to default/config value
            if event.key == self.hitDefault and event.isKeyDown():
                eAP.hitHullHeight = config.get('armorPanel/eAP/hitHullHeight', 0.7)
                hullHeightMsg = "MeltyElement AP Hull Height Multi reset to " + str(eAP.hitHullHeight)
                ctrl = g_appLoader.getDefBattleApp()
                if ctrl is not None:
                    battle_page = ctrl.containerManager.getContainer(ViewTypes.VIEW).getView()
                    battle_page.components['battlePlayerMessages'].as_showGreenMessageS(None, hullHeightMsg)
            # Toggle the debugRender on/off
            if event.key == self.toggleDrawDebugRender and event.isKeyDown():
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
        try:
            if config.get('armorPanel/debug', False):
                prefix = "DEBUG: [Element_ArmorPanel]: "
                argsList.append(prefix)
                for arg in args:
                    argsList.append(arg)
                debugLine = " ".join(map(str, argsList))
                print(debugLine)
            else:
                pass
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


#
# init classes
#

utills = ElementModUtilities()
eAP = EffectiveArmorPanel()
ME_Tank = MeltyElementTank()
AnglePanel = MeltyElementProtractor()
debugRender = ArmorPanelDebugRender()


# noinspection PyBroadException
def resetAll():
    global isReset

    try:
        if eAP.armorCallBack is not None:
            BigWorld.cancelCallback(eAP.armorCallBack)
    except Exception:
        pass
    if not isReset:
        utills.eDebug("Resetting AP")
        eAP.front__visible = True
        eAP.front_sqrt_xscale = 1.0
        eAP.front_txt_alpha = 100
        eAP.front_txt_x = 0.0
        eAP.front_x = 0.0
        eAP.side_sqrt_xscale = 0.0
        eAP.side_txt_alpha = 100
        eAP.side_txt_x = 0.0
        eAP.side_x = 0.0
        eAP.armorCallBack = None
        ME_Tank.callbackID = None
        ME_Tank.effFrontArmor = None
        ME_Tank.effSideArmor = None
        ME_Tank.front = None
        ME_Tank.leftArc = None
        ME_Tank.player = None
        ME_Tank.playerVehicle = None
        ME_Tank.playerVehicleID = None
        ME_Tank.rightArc = None
        ME_Tank.side = None
        ME_Tank.tankType = "Tank"
        ME_Tank.hullHeight = None
        AnglePanel.enable = False
        isReset = True


# noinspection PyBroadException
def setup(playerVehicle, localPlayer):
    global isReset
    if BigWorld.player() or hasattr(localPlayer, 'isOnArena') and playerVehicle is not None:
        try:
            if ME_Tank.callbackID is not None:
                BigWorld.cancelCallback(ME_Tank.callbackID)
        except Exception:
            pass
        ME_Tank.getPlayerTankValues()
        eAP.showArmorPanel()
        AnglePanel.showProtractor()
        if ME_Tank.tankType != "Tank" and AnglePanel.enable:
            AnglePanel.initialValues()
            AnglePanel.updateProtractor(0.0, 0.0, int(ME_Tank.leftArc), int(ME_Tank.rightArc))
        if eAP.enable:
            eAP.updateEffArmor(ME_Tank.effFrontArmor, 0, 0)
        isReset = False
        as_event('ON_ARMOR')
    else:
        ME_Tank.callbackID = BigWorld.callback(0.5, setup)


# noinspection PyBroadException
def Main_update():
    if ME_Tank.player is not None and ME_Tank.alive:
        if config.get('armorPanel/enable', True):
            try:
                if eAP.armorCallBack is not None:
                    BigWorld.cancelCallback(eAP.armorCallBack)
            except Exception:
                pass
            player = BigWorld.player()
            playerVehicle = BigWorld.player().getVehicleAttached()
            gunRotator = player.gunRotator
            vehicleTypeDescriptor = player.vehicleTypeDescriptor
            turretYawRad = gunRotator.turretYaw
            turretYawDeg = math.degrees(turretYawRad)
            ME_Tank.turretYawDeg = turretYawDeg  # don't need just for debug out

            ME_Tank.aimMode = player.inputHandler.ctrlModeName
            if ME_Tank.aimMode == CTRL_MODE_NAME.SNIPER:
                cameraTurretYawRad = player.inputHandler.ctrl.camera.aimingSystem.turretYaw
                cameraTurretYawDeg = math.degrees(cameraTurretYawRad)
                turretPitch = player.gunRotator.gunPitch

                ME_Tank.cameraTurretYaw = cameraTurretYawDeg  # don't need just for debug out

            elif BigWorld.player().inputHandler.ctrlModeName == CTRL_MODE_NAME.ARCADE:
                # noinspection PyProtectedMember
                scanDir, scanStart = AvatarInputHandler.cameras.getWorldRayAndPoint(*BigWorld.player().inputHandler.ctrl._aimOffset)
                scanStop = scanStart + utills.getNormalisedVector(scanDir).scale(720)
                cameraTurretYawRad, _ = AimingSystems.getTurretYawGunPitch(vehicleTypeDescriptor, player.getOwnVehicleStabilisedMatrix(), scanStop, True)
                cameraTurretYawDeg = math.degrees(cameraTurretYawRad)
                turretPitch = Math.Matrix(gunRotator.gunMatrix).pitch

                ME_Tank.cameraTurretYaw = cameraTurretYawDeg  # don't need just for debug out

            else:
                desiredShotPoint = gunRotator.predictLockedTargetShotPoint()
                if desiredShotPoint is None:
                    desiredShotPoint = player.inputHandler.getDesiredShotPoint()
                if desiredShotPoint is None:
                    desiredShotPoint = gunRotator.markerInfo[0]
                cameraTurretYawRad, _ = AimingSystems.getTurretYawGunPitch(vehicleTypeDescriptor, player.getOwnVehicleStabilisedMatrix(), desiredShotPoint, True)
                cameraTurretYawDeg = math.degrees(cameraTurretYawRad)
                turretPitch = Math.Matrix(gunRotator.gunMatrix).pitch
            vehicleMP = Math.Matrix(player.getOwnVehicleMatrix())
            tankYawDeg = math.degrees(Math.Matrix(vehicleMP).yaw)
            arc = eAP.getDynamicArc(playerVehicle, vehicleTypeDescriptor, vehicleMP, turretYawRad, cameraTurretYawRad, turretPitch)
            ME_Tank.effFrontArmor = eAP.getEquArmor(ME_Tank.front, turretYawDeg, cameraTurretYawDeg, arc)
            ME_Tank.effSideArmor = eAP.getEquArmor(ME_Tank.side, (90 - math.fabs(turretYawDeg)), (90 - math.fabs(cameraTurretYawDeg)), 0)
            if ME_Tank.tankType != "SPG":
                eAP.updateEffArmor(ME_Tank.effFrontArmor, turretYawDeg, cameraTurretYawDeg)
                AnglePanel.updateProtractor(turretYawDeg, cameraTurretYawDeg, int(ME_Tank.leftArc), int(ME_Tank.rightArc))
            else:
                AnglePanel.setArtyProtractor(turretYawDeg, int(ME_Tank.leftArc), int(ME_Tank.rightArc), tankYawDeg, ME_Tank.aimMode)
            as_event('ON_ARMOR')
            eAP.armorCallBack = BigWorld.callback(eAP.tickRate, Main_update)  # 0.033 = 30hz 0.01667 = 60hz
    else:
        try:
            if eAP.armorCallBack is not None:
                BigWorld.cancelCallback(eAP.armorCallBack)
        except Exception:
            pass


#
# XVM Event Hooks
#

# TODO - Create a flow for gamemodes like frontlines where players change vehicles without leaving world
# @registerEvent(PlayerAvatar, 'onVehicleChanged')
# def ME_AP_PlayerAvatar_onVehicleChanged(self):
#     utills.eDebug('Avatar vehicle has changed to %s' % self.vehicle)
#     if self.vehicle is not None:
#         control = self.guiSessionProvider.shared.vehicleState
#         if control.isInPostmortem or BigWorld.player().playerVehicleID != self.vehicle.id:
#             ME_Tank.alive = False
#             utills.eDebug("onVehicleChanged in postMortem")
#         else:
#             utills.eDebug("onVehicleChanged: VehicleID:", self.vehicle.id, " matches BigWorld.player ID:", BigWorld.player().playerVehicleID)
#             # ME_Tank.alive = True
#             # setup(self.vehicle, BigWorld.player())


# noinspection PyUnusedLocal
@registerEvent(Vehicle, 'onEnterWorld')
def ME_AP_Vehicle_onEnterWorld(self, prereqs):
    if self.isPlayerVehicle and config.get('armorPanel/enable', True):
        AnglePanel.useProtractorTD = config.get('armorPanel/protractor/enableProtractorWhenTD', False)
        AnglePanel.useProtractorSPG = config.get('armorPanel/protractor/enableProtractorWhenSPG', False)
        debugRender.startBattle()
        ME_Tank.playerVehicleID = self.id
        playerVehicle = BigWorld.entity(self.id)
        ME_Tank.alive = True
        utills.eDebug("ME_AP_Vehicle_onEnterWorld ME_Tank.playerVehicleID:", ME_Tank.playerVehicleID)
        ME_Tank.player = BigWorld.player()
        setup(playerVehicle, ME_Tank.player)
        as_event('ON_ARMOR')


# noinspection PyUnusedLocal
@registerEvent(PreBattleTimer, 'hideCountdown')
def ME_AP_APhideCountdown(self, state, speed):
    utills.eDebug("hideCountdown")
    if state == 3:
        if eAP.enable or AnglePanel.enable:
            utills.eDebug("Battle Started, trigger initial Armor Panel update")
            Main_update()
        else:
            # both ArmorPanel and Angle Panel are not enabled so clear debug render and reset for next tank/battle
            utills.eDebug("Battle Started, ArmorPanel and Protractor both disabled")
            debugRender.stopBattle()
            resetAll()


# noinspection PyUnusedLocal
@registerEvent(Vehicle, 'onLeaveWorld')
def ME_AP_Vehicle_onLeaveWorld(self):
    if self.isPlayerVehicle and config.get('armorPanel/enable', True):
        utills.eDebug("ME_AP_Vehicle_onLeaveWorld")
        ME_Tank.alive = False
        debugRender.stopBattle()
        resetAll()


# noinspection PyUnusedLocal
@registerEvent(FragsCollectableStats, 'addVehicleStatusUpdate')
def ME_AP_FragsCollectibleStats_addVehicleStatusUpdate(self, vInfoVO):
    if (not vInfoVO.isAlive()) and (ME_Tank.playerVehicleID == vInfoVO.vehicleID):
        ME_Tank.alive = False
        utills.eDebug("Player is no longer alive")


#
# XVM Exports
#

@xvm.export("effarmorpanel.enable", deterministic=False)
def effarmorpanel_enable():
    return eAP.enable


@xvm.export('effarmorpanel.cameraTurretYaw', deterministic=False)
def effarmorpanel_cameraTurretYaw():
    return ME_Tank.cameraTurretYaw


@xvm.export('effarmorpanel.effFrontArmor', deterministic=False)
def effarmorpanel_APeffFrontArmor():
    return ME_Tank.effFrontArmor


@xvm.export('effarmorpanel.effSideArmor', deterministic=False)
def effarmorpanel_APeffSideArmor():
    return ME_Tank.effSideArmor


@xvm.export('effarmorpanel.front_sqrt_alpha', deterministic=False)
def effArmorPanel_front_sqrt_alpha():
    return eAP.front_sqrt_alpha


@xvm.export('effarmorpanel.side_sqrt_alpha', deterministic=False)
def effArmorPanel_side_sqrt_alpha():
    return eAP.side_sqrt_alpha


@xvm.export("effarmorpanel.front_txt_alpha", deterministic=False)
def effArmorPanel_front_txt_alpha():
    return eAP.front_txt_alpha


@xvm.export("effarmorpanel.side_txt_alpha", deterministic=False)
def effArmorPanel_side_txt_alpha():
    return eAP.side_txt_alpha


@xvm.export('effarmorpanel.armorFrame_alpha', deterministic=False)
def effarmorpanel_armorFrame_alpha():
    return eAP.armorFrame_alpha


@xvm.export("effarmorpanel.front_sqrt_xscale", deterministic=False)
def effArmorPanel_front_sqrt_xscale():
    return eAP.front_sqrt_xscale


@xvm.export("effarmorpanel.front_txt_x", deterministic=False)
def effArmorPanel_front_txt_x():
    return eAP.front_txt_x


@xvm.export("effarmorpanel.side_x", deterministic=False)
def effArmorPanel_side_x():
    return eAP.side_x


@xvm.export("effarmorpanel.side_sqrt_xscale", deterministic=False)
def effArmorPanel_side_sqrt_xscale():
    return eAP.side_sqrt_xscale


@xvm.export("effarmorpanel.front_x", deterministic=False)
def effArmorPanel_front_x():
    return eAP.front_x


@xvm.export("effarmorpanel.side_txt_x", deterministic=False)
def effArmorPanel_side_txt_x():
    return eAP.side_txt_x


@xvm.export('effarmorpanel.AP_y', deterministic=False)
def effarmorpanel_AP_y():
    if ME_Tank.tankType == "TD":
        APy = config.get("armorPanel/eAP/ordinateWhenTD", 0.70) * (BigWorld.screenHeight() / 2)
    elif ME_Tank.tankType == "SPG":
        APy = config.get("armorPanel/protractor/ordinateWhenSPG", 0) * (BigWorld.screenHeight() / 2)
    else:
        APy = config.get("armorPanel/eAP/ordinateWhenTank", 0.8) * (BigWorld.screenHeight() / 2)
    return APy


@xvm.export('effarmorpanel.sqrt_y', deterministic=False)
def effarmorpanel_sqrt_y():
    if ME_Tank.tankType == "TD":
        APsqrty = config.get("armorPanel/eAP/ordinateWhenTD", 0.70) * (BigWorld.screenHeight() / 2) + 1.0
    elif ME_Tank.tankType == "SPG":
        APsqrty = config.get("armorPanel/protractor/ordinateWhenSPG", 0) * (BigWorld.screenHeight() / 2) + 1.0
    else:
        APsqrty = (config.get("armorPanel/eAP/ordinateWhenTank", 0.8) * (BigWorld.screenHeight() / 2)) + 1.0
    return APsqrty


@xvm.export("anglepanel.arcadeToggle", deterministic=False)
def angle_panel_arcadeToggle():
    if AnglePanel.showInArcade:
        return "null"
    else:
        return ME_Tank.aimMode


@xvm.export("anglepanel.middleLine_x", deterministic=False)
def angle_panel_middleLine_x():
    return AnglePanel.middleLine_x


@xvm.export("anglepanel.leftLine_x", deterministic=False)
def angle_panel_leftLine_x():
    return AnglePanel.leftLine_x


@xvm.export("anglepanel.rightLine_x", deterministic=False)
def angle_panel_rightLine_x():
    return AnglePanel.rightLine_x


@xvm.export("anglepanel.enable", deterministic=False)
def angle_panel_enable():
    return AnglePanel.enable


@xvm.export("anglepanel.leftLine_img", deterministic=False)
def angle_panel_leftLine_img():
    return AnglePanel.leftLine_img


@xvm.export("anglepanel.rightLine_img", deterministic=False)
def angle_panel_rightLine_img():
    return AnglePanel.rightLine_img


@xvm.export("anglepanel.middleLine_img", deterministic=False)
def angle_panel_middleLine_img():
    return AnglePanel.middleLine_img


@xvm.export("anglepanel.circle_x", deterministic=False)
def angle_panel_circle_x():
    return AnglePanel.circle_x


@xvm.export("anglepanel.mask_width", deterministic=False)
def angle_panel_mask_width():
    return AnglePanel.mask_width


@xvm.export("anglepanel.circle_xscale", deterministic=False)
def angle_panel_circle_xscale():
    return AnglePanel.circle_xscale


@xvm.export("anglepanel.realMidLine_right_alpha", deterministic=False)
def angle_panel_realMidLine_right_alpha():
    return AnglePanel.realMidLine_right_alpha


@xvm.export("anglepanel.middleLine_txt_text", deterministic=False)
def angle_panel_middleLine_txt_text():
    return AnglePanel.middleLine_txt_text


@xvm.export("anglepanel.turretYawDeg", deterministic=False)
def angle_panel_turretYawDeg():
    return ME_Tank.turretYawDeg


@xvm.export("anglepanel.realMidLine_left_alpha", deterministic=False)
def angle_panel_realMidLine_left_alpha():
    return AnglePanel.realMidLine_left_alpha


@xvm.export("anglepanel.rotation", deterministic=False)
def angle_panel_rotation():
    return AnglePanel.rotation


# TODO - Code clean up and refactoring. Verify Options.

print "--------------------------------------------------------------------------------------"
print "[Element_ArmorPanel]: Loading Element ArmorPanel & Protractor Mod " + time.strftime("%H:%M:%S")
print "[Element_ArmorPanel]: Element_ArmorPanel: Beta v0.1b  Built: 06.19.2018"
print "--------------------------------------------------------------------------------------"
