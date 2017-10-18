//
//  CmdInfo.swift
//  FuelPak BLE
//
//  Created by Mike Saradeth on 10/18/17.
//  Copyright © 2017 Mike Saradeth. All rights reserved.
//

import Foundation
import UIKit

class CmdInfo: NSObject {
    
    var cmd: String = ""
    var timeoutInSeconds: Double = 0.0
    var notificationName: Notification.Name  
    var startTime: Date = Date()
    var endTime: Date = Date()
    var timedoutAt: Date? = nil
    var cmdCode: Constants.CommandCode
    var cmdStatus: String = ""
    
    init(cmd:String, timeoutInSeconds: Double, notificationName:Notification.Name) {
        self.cmd = cmd
        self.cmdCode = Constants.sharedInstance.getCmdCode(cmd: cmd)
        self.timeoutInSeconds = timeoutInSeconds
        self.notificationName = notificationName
        self.startTime = Date()
        self.endTime = self.startTime.addingTimeInterval(timeoutInSeconds)
        
    }
    
}
