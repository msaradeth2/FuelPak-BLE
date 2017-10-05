//
//  Parser.swift
//  FuelPak BLE
//
//  Created by Mike Saradeth on 10/4/17.
//  Copyright © 2017 Mike Saradeth. All rights reserved.
//

import Foundation
import UIKit


final class ParserUtil: NSObject {
    
    // MARK: - Shared Instance
    static let sharedInstance: ParserUtil = {
        let instance = ParserUtil()
        // setup code
        return instance
    }()
    
    
    
    // MARK: - Initialization Method
    override init() {
        super.init()
        
        //        initBluetoothUtility()
    }
    

    var range = NSRange.init()
    var base = 0
    var index = 0
    var jj = 0
    var ii = 0
    
    
    
    public func parsePacket(cmd: String, data: String) {

        if data.count < 64 {
            return
        }
        
//        NSLog("parsePacket cmd: \(String(describing: cmd))    responseCode:\(String(describing: responseCode))     data:\(String(describing: data)) ")
//        NSLog("parsePacket cmd: \(String(describing: cmd))")
//        NSLog("parsePacket data: \(String(describing: data))")
//        NSLog("parsePacket resCode: \(String(describing: responseCode))")
//        NSLog("parsePacket NSMakeRange(1, 3): \(String(describing: data.substring(with: NSMakeRange(1, 3))))")
        
        //UVIN00 Command
        if (cmd == "UVIN00" && data.substring(with: NSMakeRange(1, 3)) == "RVN") {
            parseVinCmd(cmd: cmd, data: data)
        }
        
        //UDEV00 Command
        if (cmd == "UDEV00" && data.substring(with: NSMakeRange(7, 3)) == "RDV") {
            parseDevCmd(cmd: cmd, data: data)
        }
        
        
        //UECM00 Command
        if (cmd == "UECM00" && data.substring(with: NSMakeRange(7, 3)) == "REM") {
            parseEcmCmd(cmd: cmd, data: data)
        }
  
        
    }
    
    public func parseVinCmd(cmd: String, data: String) {
        let offset = 6 + 6
        NSLog("parseVinCmd data: \(String(describing: data))")


        Bike.sharedInstance.VINnumber = String(describing: data.substring(with: NSMakeRange(offset, 17)))
        Bike.sharedInstance.VINyear = String(describing: data.substring(with: NSMakeRange(offset+17, 4)))
        NSLog("parseVinCmd VINnumber: \(String(describing: Bike.sharedInstance.VINnumber))")
        NSLog("parseVinCmd VINyear: \(String(describing: Bike.sharedInstance.VINyear))")
        
        
//        Bike.sharedInstance.modelNumber = String(describing: data.substring(with: NSMakeRange(offset+17+4, 10)))
        
//        if (data[3]=="0" && data[4]=="D" && data[5]=="D")   //Valid Vin
//        {
//
//            Bike.sharedInstance.VINnumber = String(describing: data.substring(with: NSMakeRange(offset, 17)))
//            Bike.sharedInstance.VINyear = String(describing: data.substring(with: NSMakeRange(offset+17, 4)))
//            Bike.sharedInstance.modelNumber = String(describing: data.substring(with: NSMakeRange(offset+17+4, 10)))
//
//        }else {
//            Bike.sharedInstance.VINnumber = ""
//            Bike.sharedInstance.VINyear = ""
//            Bike.sharedInstance.modelNumber = ""
//        }
        
        NotificationCenter.default.post(name: Constants.didUpdateValueForcharacteristicNotification, object: nil)

    }
    
    
    public func parseDevCmd(cmd: String, data: String) {
        NSLog("parseDevCmd data: \(String(describing: data))")
//        data = data.sub
        
        Bike.sharedInstance.firmwareVersion = String(describing: data.substring(with: NSMakeRange(12, 7)))
        Bike.sharedInstance.hardwareVersion = String(describing: data.substring(with: NSMakeRange(6, 72)))
        
        NotificationCenter.default.post(name: Constants.didUpdateValueForcharacteristicNotification, object: nil)
    }

    
    public func parseEcmCmd(cmd: String, data: String) {
        NSLog("parseEcmCmd data: \(String(describing: data))")
        let offset = 6 + 6 + 6
        
        Bike.sharedInstance.ECMnumber = String(describing: data.substring(with: NSMakeRange(offset, 12)))
        NSLog("parseEcmCmd ECMnumber: \(String(describing: Bike.sharedInstance.ECMnumber))")
        
        Bike.sharedInstance.ECMversion = String(describing: data.substring(with: NSMakeRange(offset+12, 2)))
//        Bike.sharedInstance.ECMcalib = String(describing: data.substring(with: NSMakeRange(offset+12+2, 12)))
//        Bike.sharedInstance.ECMseed = String(describing: data.substring(with: NSMakeRange(offset+12+2+12, 2)))
//        Bike.sharedInstance.ECMkey = String(describing: data.substring(with: NSMakeRange(offset+12+2+12+2, 2)))
        
        NSLog("parseEcmCmd ECMnumber: \(String(describing: Bike.sharedInstance.ECMnumber))")
        NSLog("parseEcmCmd ECMversion: \(String(describing: Bike.sharedInstance.ECMversion))")
        
        print("%04x", Bike.sharedInstance.ECMversion)
//        NSLog("parseVinCmd VINyear: \(String(describing: Bike.sharedInstance.VINyear))")
//        NSLog("parseVinCmd VINyear: \(String(describing: Bike.sharedInstance.VINyear))")
        
        let str = Bike.sharedInstance.ECMversion
        let data2 = str.data(using: .utf8)!
        let hexString = data2.map{ String(format:"%04x", $0) }.joined()
        NSLog("parseEcmCmd hexString: \(String(describing: hexString))")
        
        NotificationCenter.default.post(name: Constants.didUpdateValueForcharacteristicNotification, object: nil)
    }
    
}

// extend String to enable sub-script with Int to get Character or sub-string
extension String
{
    subscript (i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }

    // for convenience we should include String return
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    func substring(with nsrange: NSRange) -> Substring? {
        guard let range = Range(nsrange, in: self) else { return nil }
        return self[range]
    }
        
//    subscript (r: Range<Int>) -> String {
//        let start = self.index(self.startIndex, offsetBy: r.lowerBound)
//        let end = self.index(self.startIndex, offsetBy: r.upperBound)
//
////        return self[start...end]
//    }
}


