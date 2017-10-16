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
 
    // MARK:  Define Variables
    enum BtStatus {
        case isDemoMode
        case Connected
        case NotConnected
        case Connecting
//        case FailToConnect
        
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

