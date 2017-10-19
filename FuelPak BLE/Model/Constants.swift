//
//  Globals.swift
//  FuelPak BLE
//
//  Created by Mike Saradeth on 10/2/17.
//  Copyright © 2017 Mike Saradeth. All rights reserved.
//

import Foundation
import UIKit
//import CoreBluetooth


//final class Bike: NSObject {
final class Constants: NSObject {
        
    // MARK: - Shared Instance
    static let sharedInstance: Constants = {
        let instance = Constants()
        // setup code
        return instance
    }()
    
    // MARK: - Initialization Method
    override init() {
        super.init()

        //        initBluetoothUtility()
    }
    
    
    
    // Define Notification Names
    @objc static let didDiscoverPeripheralNotification =  Notification.Name("didDiscoverPeripheralNotification")
    @objc static let didConnectPeripheralNotification =  Notification.Name("didConnectPeripheralNotification")
    @objc static let didDisconnectPeripheralNotification =  Notification.Name("didDisconnectPeripheralNotification")
    @objc static let didFailToConnectNotification =  Notification.Name("didFailToConnectNotification")
    @objc static let didDiscoverCharacteristicsNotification =  Notification.Name("didDiscoverCharacteristicsNotification")
    @objc static let didDiscoverServicesNotification =  Notification.Name("didDiscoverServicesNotification")
    @objc static let didUpdateNotificationStateNotification =  Notification.Name("didUpdateNotificationStateNotification")
    @objc static let didUpdateValueForcharacteristicNotification =  Notification.Name("didUpdateValueForcharacteristicNotification")
    @objc static let vinCommandNotification =  Notification.Name("vinCommandNotification")
    @objc static let devCommandNotification =  Notification.Name("devCommandNotification")
    @objc static let ecmCommandNotification =  Notification.Name("ecmCommandNotification")
    @objc static let uttCommandNotification =  Notification.Name("uttCommandNotification")
    @objc static let commandTimeoutNotification =  Notification.Name("commandTimeoutNotification")
    
    
//    @objc static let debugOn =  true;
//    @objc static let debugOn1 =  true;
//    @objc static let debugOn2 =  true;
    @objc static let debugOn =  false;
    @objc static let debugOn1 =  false;
    @objc static let debugOn2 =  false;
    
    @objc static let debugOn4 =  true;
 
    // MARK:  Define Notification Constant Variables
    @objc static let timedOut: String = "timedOut"
    @objc static let cmdStatus: String = "cmdStatus"
    @objc static let cmdCode: String = "cmdCode"
    
    @objc static let systemInfoViewController: String = "SystemInfoViewController"
    @objc static let dtcViewController: String = "DTCViewController"
    @objc static let peripheralViewController: String = "PeripheralViewControllers"
    @objc static let utilClass: String = "utilClass"
    
    
    
    // MARK:  Define Variables
    enum BtStatus {
        case isDemoMode
        case Connected
        case NotConnected
        case Connecting
//        case FailToConnect
        
    }
    
    enum CommandCode {
        case UVIN00
        case UDEV00
        case UECM00
        case UTT000
        case UTT001
        case UTT002
        case UNKNOWN
        case ALL
        
    }
    
    public func getCmdCode(cmd:String) -> CommandCode {
        
        if cmd == "UVIN00" {
            return CommandCode.UVIN00
            
        }else if cmd == "UDEV00" {
            return CommandCode.UDEV00
            
        }else if cmd == "UDEV00" {
            return CommandCode.UDEV00
            
        }else if cmd == "UECM00" {
            return CommandCode.UECM00
            
        }else if cmd == "UTT000" {
            return CommandCode.UTT000
            
        }else if cmd == "UTT001" {
            return CommandCode.UTT001
            
        }else if cmd == "UTT002" {
            return CommandCode.UTT002
            
        }else {
            return CommandCode.UNKNOWN
        }
        
    }
    
    
}





// Define Notification Names
extension Notification.Name {
    
    static let didDiscoverPeripheralNotification =  Notification.Name("didDiscoverPeripheralNotification")
    static let didConnectPeripheralNotification =  Notification.Name("didConnectPeripheralNotification")
    static let didDisconnectPeripheralNotification =  Notification.Name("didDisconnectPeripheralNotification")
    static let didFailToConnectNotification =  Notification.Name("didFailToConnectNotification")
    static let didDiscoverCharacteristicsNotification =  Notification.Name("didDiscoverCharacteristicsNotification")
    static let didDiscoverServicesNotification =  Notification.Name("didDiscoverServicesNotification")
    static let didUpdateNotificationStateNotification =  Notification.Name("didUpdateNotificationStateNotification")
    static let didUpdateValueForcharacteristicNotification =  Notification.Name("didUpdateValueForcharacteristicNotification")
    static let vinCommandNotification =  Notification.Name("vinCommandNotification")
    static let devCommandNotification =  Notification.Name("devCommandNotification")
    static let ecmCommandNotification =  Notification.Name("ecmCommandNotification")
    static let uttCommandNotification =  Notification.Name("uttCommandNotification")
    static let commandTimeoutNotification =  Notification.Name("commandTimeoutNotification")
}

