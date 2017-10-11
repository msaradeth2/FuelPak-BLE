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
    
    
    
    public func parsePacket(cmd: String, data: String, hexData: String) {
        
        if Constants.debugOn1 {
            NSLog("parsePacket cmd: \(String(describing: cmd))")
            NSLog("parsePacket RawData: \(String(describing: data))")
            NSLog("parsePacket HexData: \(String(describing: hexData))")
            //        NSLog("parsePacket cmd: \(String(describing: cmd))    responseCode:\(String(describing: responseCode))     data:\(String(describing: data)) ")
        }

        
        //UVIN00 Command
        if (cmd == "UVIN00" && data.substring(with: NSMakeRange(7, 3)) == "RVN") {
            parseVinCmd(cmd: cmd, data: data, hexData: hexData)
        }
        
        //UDEV00 Command
        if (cmd == "UDEV00" && data.substring(with: NSMakeRange(7, 3)) == "RDV") {
            parseDevCmd(cmd: cmd, data: data, hexData: hexData)
        }
        
        
        //UECM00 Command
        if (cmd == "UECM00" && data.substring(with: NSMakeRange(7, 3)) == "REM") {
            parseEcmCmd(cmd: cmd, data: data, hexData: hexData)
        }
        
        //UECM00, UECM01, UECM02 Command URT906DTC
        if (cmd.prefix(3) == "UTT" && data.substring(with: NSMakeRange(7, 2)) == "RT") {
            parseUttCmd(cmd: cmd, data: data, hexData: hexData)
        }
        
  
        
    }
    
    public func parseVinCmd(cmd: String, data: String, hexData: String) {
//        if Constants.debugOn {
//            print("data     : ", data)
//            print("hexData  : ", hexData)
//        }
        
        Bike.sharedInstance.VINnumber = convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(0, 34))))
        Bike.sharedInstance.VINyear = convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(34, 8))))

        if Constants.debugOn {
            print("Bike.sharedInstance.VINnumber2:  ", Bike.sharedInstance.VINnumber)
            print("VINyear:  ", Bike.sharedInstance.VINyear)
        }

        
        NotificationCenter.default.post(name: Constants.vinCommandNotification, object: nil)

    }
    
    
    public func parseDevCmd(cmd: String, data: String, hexData: String) {
        if Constants.debugOn {NSLog("parseDevCmd data: \(String(describing: data))")}
        
        Bike.sharedInstance.firmwareVersion = convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(30, 36)))).trim()
        Bike.sharedInstance.hardwareVersion = convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(72, 42)))).trim()
        Bike.sharedInstance.DEVbtversion = convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(114, 54))))
        Bike.sharedInstance.DEVodometer = convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(210, 8))))
        Bike.sharedInstance.DEVlinkedvin = convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(256, 34))))
        Bike.sharedInstance.DEVbtmacid = convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(290, 24))))
        
        Bike.sharedInstance.widebandState = convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(314, 2))))
        Bike.sharedInstance.widebandfversion = convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(316, 8))))
        Bike.sharedInstance.widebandhversion = convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(324, 6))))
        
        if Constants.debugOn {
            NSLog("parseDevCmd widebandState: \(String(describing: Bike.sharedInstance.widebandState))")
            NSLog("parseDevCmd widebandfversion: \(String(describing: Bike.sharedInstance.widebandfversion))")
            NSLog("parseDevCmd widebandhversion: \(String(describing: Bike.sharedInstance.widebandhversion))")
            NSLog("parseDevCmd DEVbtversion: \(String(describing: Bike.sharedInstance.DEVbtversion))")
            NSLog("parseDevCmd DEVbtmacid: \(String(describing: Bike.sharedInstance.DEVbtmacid))")
        }

        
//        Bike.sharedInstance.DEVlinkedvin = convertHexToAscii(text: String(describing: actualHexData.substring(with: NSMakeRange(256, 34))))

        
        NotificationCenter.default.post(name: Constants.devCommandNotification, object: nil)
    }

    
    public func parseEcmCmd(cmd: String, data: String, hexData: String) {
//        if Constants.debugOn {NSLog("parseEcmCmd data: \(String(describing: data))")}

//        Bike.sharedInstance.ECMversion = convertHexToDecimal(hexString: String(describing: actualHexData.substring(with: NSMakeRange(24, 4))))
        //        Bike.sharedInstance.ECMversion = String(describing: UInt64(String(describing: actualHexData.substring(with: NSMakeRange(24, 4))), radix:16))
        Bike.sharedInstance.ECMcalib = convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(28, 24))))
        Bike.sharedInstance.ECMseed = convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(52, 4))))
        Bike.sharedInstance.ECMkey = convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(56, 4))))
        //        Bike.sharedInstance.setSecurityMask = convertHexToAscii(text: String(describing: actualHexData.substring(with: NSMakeRange(68, 80))))
        
        
        
//        Bike.sharedInstance.ECMnumber = convertHexToAscii(text: String(describing: actualHexData.substring(with: NSMakeRange(0, 24))))
//        Bike.sharedInstance.ECMversion = convertHexToAscii(text: String(describing: actualHexData.substring(with: NSMakeRange(24, 28))))
//        Bike.sharedInstance.ECMcalib = convertHexToAscii(text: String(describing: actualHexData.substring(with: NSMakeRange(28, 52))))
//        Bike.sharedInstance.ECMseed = convertHexToAscii(text: String(describing: actualHexData.substring(with: NSMakeRange(52, 56))))
//        Bike.sharedInstance.ECMkey = convertHexToAscii(text: String(describing: actualHexData.substring(with: NSMakeRange(56, 60))))
//        Bike.sharedInstance.setSecurityMask = convertHexToAscii(text: String(describing: actualHexData.substring(with: NSMakeRange(68, 80))))

        if Constants.debugOn {
            NSLog("parseEcmCmd ECMnumber: \(String(describing: Bike.sharedInstance.ECMnumber))")
            NSLog("parseEcmCmd ECMversion: \(String(describing: Bike.sharedInstance.ECMversion))")
            NSLog("parseEcmCmd ECMcalib: \(String(describing: Bike.sharedInstance.ECMcalib))")
        }

        

        
        NotificationCenter.default.post(name: Constants.ecmCommandNotification, object: nil)
    }
    
    
    public func parseUttCmd(cmd: String, data: String, hexData: String) {

        
//        print("hexData     : ", hexData)
//        print("actualData  : ", actualHexData)
        
//        Bike.sharedInstance.VINnumber = convertHexToAscii(text: String(describing: actualHexData.substring(with: NSMakeRange(0, 34))))
//        Bike.sharedInstance.VINyear = convertHexToAscii(text: String(describing: actualHexData.substring(with: NSMakeRange(34, 8))))
//
//        print("Bike.sharedInstance.VINnumber2:  ", Bike.sharedInstance.VINnumber)
//        print("VINyear:  ", Bike.sharedInstance.VINyear)
        
        NotificationCenter.default.post(name: Constants.uttCommandNotification, object: nil)
        
    }
    
    
    
    
    func convertHexToAscii(text: String) -> String {
        if Constants.debugOn {
            NSLog("convertHexToAscii text1: \(String(describing: text))")
        }
        
        
        
        let regex = try! NSRegularExpression(pattern: "(0x)?([0-9A-Fa-f]{2})", options: .caseInsensitive)
        let textNS = text as NSString
        let matchesArray = regex.matches(in: textNS as String, options: [], range: NSMakeRange(0, textNS.length))
        let characters = matchesArray.map {
            Character(UnicodeScalar(UInt32(textNS.substring(with: $0.range(at: 2)), radix: 16)!)!)
        }
        
        if Constants.debugOn {
            NSLog("convertHexToAscii text2: \(String(describing: String(characters)))")
        }
        
        
        return String(characters)
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

extension String
{
    func trim() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}


