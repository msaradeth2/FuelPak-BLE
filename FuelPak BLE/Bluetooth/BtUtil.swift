//
//  BtUtil.swift
//  FuelPak BLE
//
//  Created by Mike Saradeth on 9/28/17.
//  Copyright © 2017 Mike Saradeth. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth
import BlueCapKit


final class BtUtil: NSObject {
    
    // MARK: - Shared Instance
    
    static let sharedInstance: BtUtil = {
        let instance = BtUtil()
        // setup code
        return instance
    }()
    
    // MARK: - Initialization Method
    
    override init() {
        super.init()
    }
    
    
    
}
