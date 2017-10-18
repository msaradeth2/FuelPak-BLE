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
    
    
    
    // MARK: - Parse Reponses to Commmand
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
    
    
    // MARK: - Parse VIN Commmand
    public func parseVinCmd(cmd: String, data: String, hexData: String) {
//        if Constants.debugOn {
//            print("data     : ", data)
//            print("hexData  : ", hexData)
//        }
        
        Bike.sharedInstance.VINnumber = Util.sharedInstance.convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(0, 34))))
        Bike.sharedInstance.VINyear = Util.sharedInstance.convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(34, 8))))

        if Constants.debugOn {
            print("Bike.sharedInstance.VINnumber2:  ", Bike.sharedInstance.VINnumber)
            print("VINyear:  ", Bike.sharedInstance.VINyear)
        }

        
        NotificationCenter.default.post(name: Constants.vinCommandNotification, object: nil)

    }
    
    
    // MARK: - Parse DEV Commmand
    public func parseDevCmd(cmd: String, data: String, hexData: String) {
        if Constants.debugOn {NSLog("parseDevCmd data: \(String(describing: data))")}
        
        Bike.sharedInstance.firmwareVersion = Util.sharedInstance.convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(30, 36)))).trim()
        Bike.sharedInstance.hardwareVersion = Util.sharedInstance.convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(72, 42)))).trim()
        Bike.sharedInstance.DEVbtversion = Util.sharedInstance.convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(114, 54))))
        Bike.sharedInstance.DEVodometer = Util.sharedInstance.convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(210, 8))))
        Bike.sharedInstance.DEVlinkedvin = Util.sharedInstance.convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(256, 34))))
        Bike.sharedInstance.DEVbtmacid = Util.sharedInstance.convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(290, 24))))
        
        Bike.sharedInstance.widebandState = Util.sharedInstance.convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(314, 2))))
        Bike.sharedInstance.widebandfversion = Util.sharedInstance.convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(316, 8))))
        Bike.sharedInstance.widebandhversion = Util.sharedInstance.convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(324, 6))))
        
        if Constants.debugOn {
            NSLog("parseDevCmd widebandState: \(String(describing: Bike.sharedInstance.widebandState))")
            NSLog("parseDevCmd widebandfversion: \(String(describing: Bike.sharedInstance.widebandfversion))")
            NSLog("parseDevCmd widebandhversion: \(String(describing: Bike.sharedInstance.widebandhversion))")
            NSLog("parseDevCmd DEVbtversion: \(String(describing: Bike.sharedInstance.DEVbtversion))")
            NSLog("parseDevCmd DEVbtmacid: \(String(describing: Bike.sharedInstance.DEVbtmacid))")
        }

        
//        Bike.sharedInstance.DEVlinkedvin = Util.sharedInstance.convertHexToAscii(text: String(describing: actualHexData.substring(with: NSMakeRange(256, 34))))

        
        NotificationCenter.default.post(name: Constants.devCommandNotification, object: nil)
    }

    
    // MARK: - Parse ECM Commmand
    public func parseEcmCmd(cmd: String, data: String, hexData: String) {
//        if Constants.debugOn {NSLog("parseEcmCmd data: \(String(describing: data))")}

//        Bike.sharedInstance.ECMversion = convertHexToDecimal(hexString: String(describing: actualHexData.substring(with: NSMakeRange(24, 4))))
        //        Bike.sharedInstance.ECMversion = String(describing: UInt64(String(describing: actualHexData.substring(with: NSMakeRange(24, 4))), radix:16))
        Bike.sharedInstance.ECMcalib = Util.sharedInstance.convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(28, 24))))
        Bike.sharedInstance.ECMseed = Util.sharedInstance.convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(52, 4))))
        Bike.sharedInstance.ECMkey = Util.sharedInstance.convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(56, 4))))
        //        Bike.sharedInstance.setSecurityMask = Util.sharedInstance.convertHexToAscii(text: String(describing: actualHexData.substring(with: NSMakeRange(68, 80))))
        
        
        
//        Bike.sharedInstance.ECMnumber = Util.sharedInstance.convertHexToAscii(text: String(describing: actualHexData.substring(with: NSMakeRange(0, 24))))
//        Bike.sharedInstance.ECMversion = Util.sharedInstance.convertHexToAscii(text: String(describing: actualHexData.substring(with: NSMakeRange(24, 28))))
//        Bike.sharedInstance.ECMcalib = Util.sharedInstance.convertHexToAscii(text: String(describing: actualHexData.substring(with: NSMakeRange(28, 52))))
//        Bike.sharedInstance.ECMseed = Util.sharedInstance.convertHexToAscii(text: String(describing: actualHexData.substring(with: NSMakeRange(52, 56))))
//        Bike.sharedInstance.ECMkey = Util.sharedInstance.convertHexToAscii(text: String(describing: actualHexData.substring(with: NSMakeRange(56, 60))))
//        Bike.sharedInstance.setSecurityMask = Util.sharedInstance.convertHexToAscii(text: String(describing: actualHexData.substring(with: NSMakeRange(68, 80))))

        if Constants.debugOn {
            NSLog("parseEcmCmd ECMnumber: \(String(describing: Bike.sharedInstance.ECMnumber))")
            NSLog("parseEcmCmd ECMversion: \(String(describing: Bike.sharedInstance.ECMversion))")
            NSLog("parseEcmCmd ECMcalib: \(String(describing: Bike.sharedInstance.ECMcalib))")
        }

        

        
        NotificationCenter.default.post(name: Constants.ecmCommandNotification, object: nil)
    }
    
    
    
    // MARK: - Parse UTT Commmand - Get DTC codes
    public func parseUttCmd(cmd: String, data: String, hexData: String) {
        let dataOffset = 8

        let numberOfDtcCodesStr = Util.sharedInstance.convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(2, 6))))
        
//        // Hexadecimal to decimal
//        let h2 = "1c"
//        let d4 = Int(h2, radix: 16)!
//        print(d4) // 28
//
//        let numberOfDtcCodes = Int(numberOfDtcCodesStr, radix: 16)
        
        
        
//        listDtc = [text componentsSeparatedByString:@"_"];
//        listcount = [listDtc count];
        
        
        let dtcCodes = Util.sharedInstance.convertHexToAscii(text: String(describing: hexData.substring(with: NSMakeRange(dataOffset, hexData.count-dataOffset))))
        let dtcCodesArr =  parseDtcCodes(dtcCodes: dtcCodes)
        BluetoothUtil.sharedInstance.respUttCommand = dtcCodesArr
        
        print("numberOfDtcCodes     : ", numberOfDtcCodesStr)
        print("dtcCodes  : ", dtcCodes)
        print("dtcCodesArr.count  : ", dtcCodesArr.count)
        print("dtcCodesArr  : ", dtcCodesArr)
                
        NotificationCenter.default.post(name: Constants.uttCommandNotification, object: nil)        
        
    }
    
    
    
    func parseDtcCodes(dtcCodes: String) -> Array<String> {
        var dtcCodeArray: Array<String> = [String]()
        var ii: Int = 0
        var dtcCode: String = ""
        var myDtcCode: String = ""
        
        let dtcCodesArr =  dtcCodes.split(separator: "_")

        for tmpDtcCode in dtcCodesArr {
            ii = ii + 1
//            print("tmpDtcCode:", ii, tmpDtcCode)
            
            let tmpArray = tmpDtcCode.split(separator: ".")
            
            //Get dtcCode - the first element of tmpArray
            var index = 0
            for tmpStr in tmpArray {
                if index == 0  {
                    dtcCode = String(tmpStr)
                }
                index = index + 1
//                print(tmpStr, dtcCode)
            }
            
            
            //Replace leading number with Character
            let firstDigit = Int(dtcCode.prefix(1))!
            switch (firstDigit) {
            case 0:
                myDtcCode = "P" + dtcCode.suffix(dtcCode.count-1)
                
            case 1:
                myDtcCode = "C" + dtcCode.suffix(dtcCode.count-1)
                
            case 2:
                myDtcCode = "B" + dtcCode.suffix(dtcCode.count-1)
                
            case 3:
                myDtcCode = "U" + dtcCode.suffix(dtcCode.count-1)
                
            default:
                myDtcCode = ""
                break;
            }
            print(tmpArray[0], myDtcCode)
            
            dtcCodeArray.append(myDtcCode)
        }
        
        return dtcCodeArray
    }

    

    
}




