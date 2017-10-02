//
//  Bike.swift
//  FuelPak BLE
//
//  Created by Mike Saradeth on 9/28/17.
//  Copyright © 2017 Mike Saradeth. All rights reserved.
//


import Foundation
import UIKit
//import CoreBluetooth
//import BlueCapKit


final class Bike: NSObject {
    
    // MARK: - Shared Instance
    static let sharedInstance: Bike = {
        let instance = Bike()
        // setup code
        return instance
    }()
    
    // MARK: - Initialization Method
    override init() {
        super.init()
        
//        initBluetoothUtility()
    }
    
    var deviceName = ""
    var deviceUUID = ""
    var deviceCharacteric = ""
    var deviceService = ""
    var deviceStatus = ""
    
    var manufacturerName = ""
    var modelNumber = ""
    var serialNumber = ""
    var hardwareVersion = ""
    var firmwareVersion = ""
    var softwareVersion = ""
    var systemId = ""
    
    var isDemoMode = false
    var isConnected = false
    
   

    
}

