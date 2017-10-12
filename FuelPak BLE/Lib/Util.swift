//
//  Util.swift
//  FuelPak BLE
//
//  Created by Mike Saradeth on 10/12/17.
//  Copyright © 2017 Mike Saradeth. All rights reserved.
//

import UIKit
import CoreData
import Foundation
import CoreBluetooth


final class Util: NSObject {
    
    
    
    // MARK: - Shared Instance
    @objc static let sharedInstance: Util = {
        let instance = Util()
        // setup code
        return instance
    }()
    
    // MARK: - Initialization Method
    override init() {
        super.init()
        
        initData()
        
    }
    

    
    
    
    
    
    // MARK:  Init Data
    func initData() {        
        
    }
    
    
    
    //Validate packet size
    func allPacketsArrived(rawData: String, hexData: String, cmd: String) -> Bool {
        if Constants.debugOn1 {
            NSLog("parsePacket cmd: \(String(describing: cmd))")
            NSLog("parsePacket RawData: \(String(describing: rawData))")
            NSLog("parsePacket HexData: \(String(describing: hexData))")
        }
        
        if hexData.count < 24 {
            return false    //Don't have enough data yet
        }
        
        //Get Packet size
        let packetSizeTxt = String(describing: hexData.substring(with: NSMakeRange(22, 2)))
        let packetSizeAscii = convertHexToAscii(text: packetSizeTxt)
        
        let packetSize = Int(packetSizeAscii)! * 128
        let actualpaketSize = hexData.count - 24
        
        if Constants.debugOn1 {
            NSLog("allPacketsArrived      packetSize: \(String(describing: packetSize))     actualpaketSize: \(String(describing: actualpaketSize))")
            //            NSLog("allPacketsArrived actualpaketSize: \(String(describing: actualpaketSize))")
            //            NSLog("allPacketsArrived         hexData: \(String(describing: hexData.count))")
        }
        
        
        
        //Compare the packetsize to Actual data length
        if actualpaketSize >= packetSize {
            return true
        }else {
            return false
        }
    }
    
    //Strip out header info and return actual data in packet
    func getActualHexData(hexData: String, offset: Int) -> String {
        
        if offset>=hexData.count {
            return hexData
        }
        
        let index = hexData.index(hexData.startIndex, offsetBy: offset)
        let actualHexData = String(hexData.suffix(from: index))
        
        return actualHexData
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
