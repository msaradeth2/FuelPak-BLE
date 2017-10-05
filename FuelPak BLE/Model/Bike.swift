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
    
    //From Fuelpak
    var VINnumber = "";  // 1HD1JPV34CB010700
    var ECMversion = "";   // 357
    
    var ECMcalib = "";    // 41000063B
    var DEVstate = "";     // paired or unpaired
    var DEVfversion = "";  // 1.1.6
    var DEVhversion = "";  // 1.1.6
    var widebandState = ""
    var widebandfversion = ""
    var widebandhversion = ""
    var iosVersion  = ""
    var appVersion = ""
    var appBuildVersion = ""
    var DEVbtversion = ""; // Ver 5.2 iAP <date>
    var DEVbtmacid = "";     // 000666612345
    
    var VINmodel = "";   // Softail
    var VINdesc = "";    // FXS Blackline FLSTC
    var VINyear = "";     // 2012
    var VINplant = "";   // York, PA USA
    var ECMnumber = "";   // 410000006
    
    var ECMseed = "";      // 0x0DBE
    var ECMkey = "";       // 0xDBE5
    var ECMextended = "";
    
    

    
    // 0 no slot, A thru L valid slots
    
    var DEVlinkedvin = "";   // 1HD1JPV34CB010700 (married)
    
    
//    unsigned long odometer;
//    unsigned long tamperseal;
//    unsigned long tampersealcount;
    
   

    
}

