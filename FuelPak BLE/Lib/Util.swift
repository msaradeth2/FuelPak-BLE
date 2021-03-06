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
    func allPacketsArrived(asciiBuffer: String) -> Bool {
        let headerLength = 12
        
//        let strBuff/er = Util.sharedInstance.convertBytesToHex(byteBuffer: byteBuffer)
        
        if Constants.debugOn1 {
            NSLog("parsePacket RawData: \(String(describing: asciiBuffer))")
            //            NSLog("parsePacket HexData: \(String(describing: hexData))")
        }
        
        if asciiBuffer.count < headerLength {
            return false    //Don't have enough data yet
        }
        
        //Get Packet size
        let packetSize = getPacketSize(asciiBuffer: asciiBuffer)
        let actualpaketSize = asciiBuffer.count - headerLength
        
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
    func removeHeaderInfo(hexData: String, offset: Int) -> String {
        
        if offset>=hexData.count {
            return hexData
        }
        
        let index = hexData.index(hexData.startIndex, offsetBy: offset)
        let actualHexData = String(hexData.suffix(from: index))
        
        return actualHexData
    }
    

    func getPacketSize(asciiBuffer: String) -> Int {
        let headerLen = 12
        var packetSize: Int = -1
        
        if asciiBuffer.count < headerLen {
            return -1    //Don't have enough data yet
        }
        
        let headerInfo = String(asciiBuffer.prefix(headerLen))
        let packetSizeTxt = String(headerInfo.suffix(1))
        
        packetSize = Int(packetSizeTxt, radix: 32)!
        packetSize = packetSize * 64

        return packetSize
        
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
    
    func convertAsciiToHex(text: String) -> String {
        
        // Convert from text -> hex
        let hex = text.utf8.map{ $0 }.reduce("") {
            $0 + String($1, radix: 16, uppercase: false)
        }
        
        return hex        
    }

    func convertBytesToDecimal(byte: UInt8) -> Int {
        
        //Convert bytes to Decimal
        let hexVal = Util.sharedInstance.convertBytesToHex(byte: byte)
        let intVal = Int(hexVal, radix: 16)!

        print("convertBytesToDecimal:   byte=%d   decVal  ", byte, intVal)
        
        return intVal
    }
    
    
    func convertBytesToHex(byte: UInt8) -> String {
        
        //Convert bytes to Hex
        
        let hexValue = String(format: "%02X", byte)
        print("convertBytesToHex:   bytesArr.count=%d   tmpHexDataBuffer.count=%d  ", byte, hexValue)
        
        //         return String(tmpHexDataBuffer)
        
        return String(hexValue)
    }
    
    
    
    func convertBytesToHex(byteBuffer: Array<UInt8>) -> String {
        
        //Convert bytesArr to Hex String
        var tmpHexDataBuffer: String = ""
        for ii in 0..<byteBuffer.count
        {
            let hexValue = String(format: "%02X", byteBuffer[ii])
            tmpHexDataBuffer = tmpHexDataBuffer.appending(hexValue)  ////Accumulate hexData
        }
        
        print("convertBytesToHex:   bytesArr.count=%d   tmpHexDataBuffer.count=%d  ", byteBuffer.count, tmpHexDataBuffer.count)

//         return String(tmpHexDataBuffer)
        
        return String(tmpHexDataBuffer)
    }
    
    

    

    func convertStringsToHex(myString: String) -> String {
        
        //Convert Strings to Hex String
        let tmpHexDataBuffer = myString.unicodeScalars.filter { $0.isASCII }.map { String(format: "%X", $0.value) }.joined()
        
        return tmpHexDataBuffer
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

extension Character {
    var string: String { return String(self) }
}

//extension String.CharacterView {
//    var string: String { return String(self) }
//}

extension Sequence where Iterator.Element == UnicodeScalar {
    var string: String { return String(String.UnicodeScalarView(self)) }
}

extension String {
    func index(at offset: Int) -> Index? {
        precondition(offset >= 0, "offset can't be negative")
        return index(startIndex, offsetBy: offset, limitedBy: index(before: endIndex))
    }
    func character(at offset: Int) -> Character? {
        precondition(offset >= 0, "offset can't be negative")
        guard let index = index(at: offset) else { return nil }
        return self[index]
    }
//    subscript(offset: Int) -> String {
//        precondition(offset >= 0, "offset can't be negative")
//        guard let character = character(at: offset) else { return "" }
//        return String(character)
//    }
    subscript(range: Range<Int>) -> Substring {
        precondition(range.lowerBound >= 0, "range lowerBound can't be negative")
        guard let startIndex = index(at: range.lowerBound) else { return "" }
        return self[startIndex..<(index(startIndex, offsetBy: range.count, limitedBy: endIndex) ?? endIndex)]
    }
    subscript(range: ClosedRange<Int>) -> Substring {
        precondition(range.lowerBound >= 0, "range lowerBound can't be negative")
        guard let startIndex = index(at: range.lowerBound) else { return "" }
        return self[startIndex..<(index(startIndex, offsetBy: range.count, limitedBy: endIndex) ?? endIndex)]
    }
    subscript(partialRange: PartialRangeFrom<Int>) -> Substring {
        return self[partialRange.lowerBound..<endIndex.encodedOffset]
    }
    subscript(partialRange: PartialRangeUpTo<Int>) -> Substring {
        return self[startIndex.encodedOffset..<partialRange.upperBound]
    }
    subscript(partialRange: PartialRangeThrough<Int>) -> Substring {
        return self[startIndex.encodedOffset...partialRange.upperBound]
    }
}
