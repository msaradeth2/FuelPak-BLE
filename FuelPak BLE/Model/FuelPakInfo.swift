//
//  BleDevice.swift
//  FuelPak BLE
//
//  Created by Mike Saradeth on 9/28/17.
//  Copyright © 2017 Mike Saradeth. All rights reserved.
//

import Foundation
import UIKit
//import CoreBluetooth
//import BlueCapKit


final class FuelPakInfo: NSObject {
    
    // MARK: - Shared Instance
    static let sharedInstance: FuelPakInfo = {
        let instance = FuelPakInfo()
        // setup code
        return instance
    }()
    
    // MARK: - Initialization Method
    override init() {
        super.init()
        
        //        initBluetoothUtility()
    }
    
    
    var name = ""
    var deviceUUID = ""
    var charactericName = ""
    var serviceName = ""
    var deviceStatus = ""
    
    var manufacturerName = ""
    var modelNumber = ""
    var serialNumber = ""
    var hardwareVersion = ""
    var firmwareVersion = ""
    var appVersion = ""
    var systemId = ""
    
    var notifiedValue = ""
    var readValue = ""
    
    
    
    
    
    
}
