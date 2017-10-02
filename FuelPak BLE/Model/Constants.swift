//
//  Globals.swift
//  FuelPak BLE
//
//  Created by Mike Saradeth on 10/2/17.
//  Copyright © 2017 Mike Saradeth. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth



class Constants {
    
    // Define identifier
//    let notificationName = Notification.Name("NotificationIdentifier")
   
    static let didDiscoverPeripheralNotification =  Notification.Name("didDiscoverPeripheralNotification")
    static let didConnectPeripheralNotification =  Notification.Name("didConnectPeripheralNotification")
    static let didDisconnectPeripheralNotification =  Notification.Name("didDisconnectPeripheralNotification")
    static let didFailToConnectNotification =  Notification.Name("didFailToConnectNotification")
    static let didDiscoverCharacteristicsNotification =  Notification.Name("didDiscoverCharacteristicsNotification")
    static let didDiscoverServicesNotification =  Notification.Name("didDiscoverServicesNotification")
    static let didUpdateNotificationStateNotification =  Notification.Name("didUpdateNotificationStateNotification")

}


