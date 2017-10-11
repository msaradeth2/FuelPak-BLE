//
//  BTDevice.swift
//  FuelPak BLE
//
//  Created by Mike Saradeth on 9/29/17.
//  Copyright © 2017 Mike Saradeth. All rights reserved.
//

import UIKit
import CoreData
import Foundation
import CoreBluetooth



//final class BluetoothUtil: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {

final class BluetoothUtil: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    
    
    // MARK: - Shared Instance
    @objc static let sharedInstance: BluetoothUtil = {
        let instance = BluetoothUtil()
        // setup code
        return instance
    }()
    
    // MARK: - Initialization Method
    override init() {
        super.init()
        
        initData()
        
    }
    
    struct PeripheralsStructure {
        var peripheralInstance: CBPeripheral?
        var peripheralRSSI: NSNumber?
        var timeStamp: Date?
    }

    //Start here
    fileprivate let serviceUUID = CBUUID(string: "49535343-FE7D-4AE5-8FA9-9FAFD205E455")
    fileprivate let characteristicUUID = CBUUID(string: "49535343-1E4D-4BD9-BA61-23C647249616")
//    fileprivate let characteristicUUID = CBUUID(string: "49535343-8841-43F4-A8D4-ECBE34729BB3")
    
    
    fileprivate var characteristicInstance: CBCharacteristic?
    
    fileprivate var alertController: UIAlertController?
    fileprivate var localTimer: Timer = Timer()
    fileprivate var rssiTime: Date = Date()
    
    fileprivate var previousPeripheralRSSIValue: Int = 0
    fileprivate var indexPathForSelectedRow: IndexPath?
    fileprivate var remoteCommandEnabled: Bool = false
    fileprivate var upgradeEnabled: Bool = false
    fileprivate var appDelegate: AppDelegate = AppDelegate()

    fileprivate var appResults: NSArray = NSArray()
    
    fileprivate var peripheralInstance: CBPeripheral?

    
    var cbCentralManager: CBCentralManager!
    var peripheralDict = [String: PeripheralsStructure]()
    var discoveredSevice: CBService?
//    var resultString: String = ""
    var cmd: String = ""
    var asciiData: String = ""


    
    
    // MARK:  Init Data
    func initData() {
        
        
        peripheralDict.removeAll()
        appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        cbCentralManager = CBCentralManager(delegate: self, queue: nil)
        localTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(interruptLocalTimer), userInfo: nil, repeats: true)
    }
    

    
    // MARK:  Write Command
    
    @objc public func write(cmd: String) {
        self.cmd = cmd
        var bytesData = [UInt8] (cmd.utf8)
        let writeData = Data(bytes: &bytesData, count: bytesData.count)
        
        if Constants.debugOn {
            NSLog("connect peripheralInstance: \(String(describing: peripheralInstance?.name))")
            NSLog("connect characteristicInstance uuid: \(String(describing: characteristicInstance?.uuid))")
        }

        
        peripheralInstance!.writeValue(writeData, for: characteristicInstance! as CBCharacteristic, type:CBCharacteristicWriteType.withResponse)
        
    }
    
    
    
   // MARK: - Public methods

    
    public func startScan() {

        self.peripheralDict.removeAll()
        scanForPeripherals()
        
        
//        cbCentralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
//        scanForPeripherals()
        
    }
    
    public func stopScan() {
        if self.cbCentralManager!.isScanning{
            self.cbCentralManager?.stopScan()
        }
    }
    
    
    public func connect(peripheral: CBPeripheral?) {
//        NSLog("connect: \(String(describing: peripheralInstance?.name))")
        cbCentralManager.connect(peripheral!, options: nil)
    }
    
    public func cancelConnect() {
        

        cbCentralManager.cancelPeripheralConnection(peripheralInstance!)
        
    }
    

    

    
    func scanForPeripherals() {
        cbCentralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
//        cbCentralManager.scanForPeripherals(withServices: [serviceUUID], options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
        
        let triggerTime = (Int64(NSEC_PER_SEC) * 9000000)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTime) / Double(NSEC_PER_SEC), execute: { () -> Void in
            if self.cbCentralManager!.isScanning{
                self.cbCentralManager?.stopScan()
                //                self.updateViewForStopScanning()
            }
        })
    }
    
    
    
    
    // MARK: - CCBCentralManagerDelegate and CBPeripheralDelegate Delegates
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch (central.state) {
            
        case .poweredOn:
            scanForPeripherals()
            break
            
        default:
            break
        }
    }
    

    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        self.peripheralInstance = peripheral
        let peripheralConnectable: AnyObject = advertisementData["kCBAdvDataIsConnectable"]! as AnyObject
        
        if ((self.peripheralInstance == nil || self.peripheralInstance?.state == CBPeripheralState.disconnected) && (peripheralConnectable as! NSNumber == 1)) {
            var peripheralName: String = String()
            if (advertisementData.index(forKey: "kCBAdvDataLocalName") != nil) {
                peripheralName = advertisementData["kCBAdvDataLocalName"] as! String
            }
            if (peripheralName == "" || peripheralName.isEmpty) {
                
                if (peripheral.name == nil || peripheral.name!.isEmpty) {
                    peripheralName = "Unknown"
                } else {
                    peripheralName = peripheral.name!
                }
            }
            
            if (peripheralName=="RN_BLE") {
                peripheralDict.updateValue(PeripheralsStructure(peripheralInstance: peripheral, peripheralRSSI: RSSI, timeStamp: Date()), forKey: peripheralName)
                // Post notification
                NotificationCenter.default.post(name: Constants.didDiscoverPeripheralNotification, object: nil)
            }
            
            

            
            NSLog("didDiscover peripheral: \(peripheralName)")
        }
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        Bike.sharedInstance.isConnected = true
        peripheral.delegate = self
        peripheral.discoverServices([serviceUUID])
        
        // Post notification
        NotificationCenter.default.post(name: Constants.didConnectPeripheralNotification, object: nil)
        
        NSLog("didConnect peripheral: \(String(describing: peripheral.name))")
        
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        Bike.sharedInstance.isConnected = false
     
        NSLog("didDisconnectPeripheral peripheral: \(String(describing: peripheral.name))")
        
        // Post notification
        NotificationCenter.default.post(name: Constants.didDisconnectPeripheralNotification, object: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        Bike.sharedInstance.isConnected = false
        
        // Post notification
        NotificationCenter.default.post(name: Constants.didFailToConnectNotification, object: nil)
        
//        alertController = UIAlertController(title: "MLDP Demo", message: "Failed to connect to the peripheral! Check if the peripheral is functioning properly and try to reconnect.", preferredStyle: UIAlertControllerStyle.alert)
//        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
//        alertController!.addAction(alertAction)
//        alertController!.popoverPresentationController?.sourceView = self.view
//        alertController!.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width / 3.0, y: self.view.bounds.size.height / 3.0, width: 1.0, height: 1.0)
//        present(alertController!, animated: true, completion: nil)
    }
    
    func centralManager(_ central: CBCentralManager!, didRetrievePeripherals peripherals: [AnyObject]!) {
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if (peripheral.services!.isEmpty) {
//            alertController = UIAlertController(title: "MLDP Demo", message: "Microchip BLE data services not found! Make sure to enter the right custom Service UUID if using custom service. Ensure that the peripheral is configured to enable the custom service.", preferredStyle: UIAlertControllerStyle.alert)
//            let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
//            alertController!.addAction(alertAction)
//            alertController!.popoverPresentationController?.sourceView = self.view
//            alertController!.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width / 3.0, y: self.view.bounds.size.height / 3.0, width: 1.0, height: 1.0)
//            present(alertController!, animated: true, completion: nil)
            
            cbCentralManager.cancelPeripheralConnection(peripheral)
            return
        }
        
        for service in peripheral.services! {
            NSLog("Service discovered: \(service.uuid)")
            if (service.uuid == serviceUUID) {
                peripheral.discoverCharacteristics([characteristicUUID], for: service )
            }
            
        }
        
        // Post notification
        NotificationCenter.default.post(name: Constants.didDiscoverServicesNotification, object: nil)
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        if (service.characteristics!.isEmpty) {
//            alertController = UIAlertController(title: "MLDP Demo", message: "Microchip BLE data characteristics not found! Make sure to enter the right custom Characteristics UUIDs if using custom service with characteristics. Ensure that the peripheral is configured to enable the custom service and characteristics.", preferredStyle: UIAlertControllerStyle.alert)
//            let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
//            alertController!.addAction(alertAction)
//            alertController!.popoverPresentationController?.sourceView = self.view
//            alertController!.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width / 3.0, y: self.view.bounds.size.height / 3.0, width: 1.0, height: 1.0)
//            present(alertController!, animated: true, completion: nil)
//
            cbCentralManager.cancelPeripheralConnection(peripheral)
            return
        }
        
        self.peripheralInstance = peripheral
        for characteristic in service.characteristics! {
            NSLog("Characteristics discovered: \(characteristic.uuid)")
            if (service.uuid == serviceUUID) {
                peripheral.setNotifyValue(true, for: characteristic)
                NSLog("peripheral.setNotifyValue(true, for: characteristic)")
                
                if (characteristic.uuid == characteristicUUID) {
                    peripheral.setNotifyValue(true, for: characteristic )
                    characteristicInstance = characteristic
                    
                    NSLog("peripheral.setNotifyValue(true, for: characteristic)")
                    NSLog("connect Characteristics discovered: \(characteristic.uuid)")
                }
                
            }
        }
        
        // Post notification
        NotificationCenter.default.post(name: Constants.didDiscoverCharacteristicsNotification, object: nil)
            

    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if Constants.debugOn {
            NSLog("didWriteValueFor characteristic")
            NSLog("didWriteValueFor characteristice uuid: \(String(describing: characteristicInstance?.uuid))")
        }

    }
    
    
    
    // MARK: Handle Bluetooth Reponses here
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        var bytesData = [UInt8] (repeating: 0, count: characteristic.value!.count)
            (characteristic.value! as NSData).getBytes(&bytesData, length: characteristic.value!.count)
        
        let asciiData = String(bytes: bytesData, encoding: String.Encoding.ascii)

        self
        //Convert bytesData to Hex Data
        var hexData = ""
        for ii in 0..<bytesData.count
        {
            let hexValue = String(format: "%02X",bytesData[ii])
            hexData = hexData + hexValue
//            print (hexValue)
        }
//        print ("hexData: ", hexData)
        
        
        
        //Got the Acknowlegement from FuelPak - do nothing for now
        if asciiData==self.cmd {
            if Constants.debugOn2 {
                NSLog("Acknowlegement: \(String(describing: self.cmd))")
//                print(self.cmd)
            }
            
            //Got the Acknowlegement from FuelPak - do nothing for now
//            NSLog("resultAscii: \(String(describing: resultAscii))")
        }else {

            if validPacketSize(rawData: asciiData!, hexData: hexData, offset: 0) {
                // Parse data
                ParserUtil.sharedInstance.parsePacket(cmd: self.cmd, data: asciiData!, hexData: hexData)
            }else {

            }

            
        }

//        print("asciiData: ", asciiData!)
//        NSLog("asciiData?.count: \(String(describing: asciiData?.count))    resultAscii:\(String(describing: asciiData))")
        
    }
    
    
    // MARK:  Helper methods

    @objc func interruptLocalTimer() {
        
        for keyDict in Array(BluetoothUtil.sharedInstance.peripheralDict.keys) {
            if ((BluetoothUtil.sharedInstance.peripheralDict[keyDict]!.timeStamp!).timeIntervalSinceNow < -15.0) {
                BluetoothUtil.sharedInstance.peripheralDict.removeValue(forKey: keyDict)
            }
        }
        
    }
    
    
    //Validate packet size
    func validPacketSize(rawData: String, hexData: String, offset: Int) -> Bool {
        if Constants.debugOn1 {
            NSLog("parsePacket cmd: \(String(describing: self.cmd))")
            NSLog("parsePacket RawData: \(String(describing: rawData))")
            NSLog("parsePacket HexData: \(String(describing: hexData))")
        }
        
        //Get Packet size
        let packetSizeTxt = String(describing: hexData.substring(with: NSMakeRange(22, 2)))
        let packetSizeAscii = convertHexToAscii(text: packetSizeTxt)
        if packetSizeAscii.count != 1 {
            return false
        }
        
        let packetSize = Int(packetSizeAscii)! * 128
        let actualpaketSize = hexData.count - 24
        
        if Constants.debugOn1 {
            NSLog("validPacketSize      packetSize: \(String(describing: packetSize))")
            NSLog("validPacketSize actualpaketSize: \(String(describing: actualpaketSize))")
            NSLog("validPacketSize         hexData: \(String(describing: hexData.count))")
        }
        
        
        
        //Compare the packetsize to Actual data length
        if packetSize == actualpaketSize {
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



