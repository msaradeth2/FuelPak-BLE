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

    // MARK: Private Data
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
    fileprivate var cbCentralManager: CBCentralManager!
    fileprivate var discoveredSevice: CBService?
    fileprivate var cmdInfoList: [CmdInfo] = []
    fileprivate var cmdInfoListBytes: [UInt8] = []
    fileprivate var timeoutCounter = 0
    fileprivate var timerCmdTimeout: Timer = Timer()
    fileprivate var btDataStreamAscii: String = ""
//    fileprivate var btDataStreamHex: String = ""
    fileprivate var btDataStreamBytes: Array<UInt8> = [UInt8]()

    fileprivate var isParsingBtDataStream: Bool = false
    fileprivate var parseBtDataStreamTimer: Timer = Timer()
    
//    fileprivate var cmdInfoList: [CmdInfo] = []
    
    // MARK:  Share Data
    var peripheralDict = [String: PeripheralsStructure]()
    @objc var respUttCommand: Array<String> = [String]()

    // MARK:  Init Data
    func initData() {
        
        
        peripheralDict.removeAll()
        appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        cbCentralManager = CBCentralManager(delegate: self, queue: nil)
        localTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(interruptLocalTimer), userInfo: nil, repeats: true)
        
        let numberofSeconds = 0.25
        self.isParsingBtDataStream = false
        parseBtDataStreamTimer = Timer.scheduledTimer(timeInterval: numberofSeconds, target: self, selector: #selector(parseBtDataStream), userInfo: nil, repeats: true)
    }
    

    
    // MARK:  Write Command
    
    @objc public func write(cmd: String, timeoutInSeconds: Double, notificationName: Notification.Name, caller: String) {

        var bytesData = [UInt8] (cmd.utf8)
        let writeData = Data(bytes: &bytesData, count: bytesData.count)
        
        NSLog("Mike write: \(String(describing: cmd))")
        
        if Bike.sharedInstance.isConnected() {
            peripheralInstance!.writeValue(writeData, for: characteristicInstance! as CBCharacteristic, type:CBCharacteristicWriteType.withResponse)            
        }else {
            NSLog("write: Not connected)")
        }
        
        self.cmdInfoList.append(CmdInfo(cmd: cmd, timeoutInSeconds: timeoutInSeconds, notificationName: notificationName, caller: caller))
        
        
        if Constants.debugOn {
            NSLog("connect peripheralInstance: \(String(describing: peripheralInstance?.name))")
            NSLog("connect characteristicInstance uuid: \(String(describing: characteristicInstance?.uuid))")
        }

    }
    
    
    
    func testTime() {
        let date1 = Date()
        let date2 = Date().addingTimeInterval(100)
        
        if date1 == date2 {
            print("date1 == date2")
        }
        else if date1 > date2 {
            print("date1 > date2")
        }
        else if date1 < date2 {
            print("date1 < date2")
        }
        
    }
    
    
    
    // MARK:  Montitor Command Timeout
    func startTimerCmdTimeout(numberOfSeconds: Double) {
        self.timeoutCounter = 0
        
        self.timerCmdTimeout = Timer.scheduledTimer(timeInterval: numberOfSeconds, target: self, selector: #selector(handleCommandTimeout), userInfo: nil, repeats: true)
    }
    
    func stopTimerCmdTimeout() {
        self.timerCmdTimeout.invalidate()
    }
    
    
    @objc func handleCommandTimeout(notfication: NSNotification) {
        
        self.timeoutCounter = self.timeoutCounter + 1
        if Constants.debugOn {
            NSLog("handleCommandTimeout: \(String(describing: timeoutCounter))")
        }
        
        //On Command Timeout
        if self.timeoutCounter > 1 {
            stopTimerCmdTimeout()
            //Post command timeout notification
            NotificationCenter.default.post(name: Constants.commandTimeoutNotification, object: nil)
            if Constants.debugOn {
                NSLog("handleCommandTimeout: NotificationCenter.default.post(name: Constants.commandTimeoutNotification, object: nil)")
            }
//            resetDataBuffer()
        }
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
        
        if Bike.sharedInstance.isNotConnected() && peripheralDict.count == 1 {
            connect(peripheral: peripheral)
        }
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        Bike.sharedInstance.btStatus = Constants.BtStatus.Connected
        peripheral.delegate = self
        peripheral.discoverServices([serviceUUID])
        
        // Post notification
        NotificationCenter.default.post(name: Constants.didConnectPeripheralNotification, object: nil)
        
        NSLog("didConnect peripheral: \(String(describing: peripheral.name))")
        
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        Bike.sharedInstance.btStatus = Constants.BtStatus.NotConnected
        
     
        NSLog("didDisconnectPeripheral peripheral: \(String(describing: peripheral.name))")
        
        // Post notification
        NotificationCenter.default.post(name: Constants.didDisconnectPeripheralNotification, object: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        Bike.sharedInstance.btStatus = Constants.BtStatus.NotConnected
        
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
    
//
    
    // MARK: Handle Bluetooth Reponses here
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        var bytesData = [UInt8] (repeating: 0, count: characteristic.value!.count)
            (characteristic.value! as NSData).getBytes(&bytesData, length: characteristic.value!.count)

        self.btDataStreamBytes.append(contentsOf: bytesData)
        
        let packetDataAscii = String(bytes: bytesData, encoding: String.Encoding.ascii)
        self.btDataStreamAscii.append(packetDataAscii!)
        
    }
    

    
    
    // MARK:  Process data stream from bluetooth
    
    @objc func parseBtDataStream() {
        var byteBuffer: Array<UInt8> = [UInt8]()
 
        let offsetHex = (6 + 6 + 6) * 2
        let offsetAscii = 6 + 6 + 6
        
        if self.btDataStreamBytes.count == 0 || self.isParsingBtDataStream || !Bike.sharedInstance.isConnected() {
            return
        }
        
        //Get first Acknowledgement for the command found in btDataStream
        let cmdInfo = parseForAcknowledgement()
        
        //Check and handle timeout
        checkTimedout()
        
        if cmdInfo.cmd.count==0 || !(Util.sharedInstance.allPacketsArrived(asciiBuffer: self.btDataStreamAscii) ) {
            self.isParsingBtDataStream = false
            return
        }
        if Constants.debugOn {
            NSLog("parseBtDataStream cmd: \(String(describing: cmdInfo.cmd))   self.btDataStreamAscii.count=%",  self.btDataStreamAscii.count)
        }
        
        //Start Parsing Data - Only allow one parsing process at a time
        self.isParsingBtDataStream = true
        removeDuplicateCommands(mCmdInfo: cmdInfo)  //duplicate commands can share same response
        
        

        //Get packet size
        let packetSize = Util.sharedInstance.getPacketSize(asciiBuffer: self.btDataStreamAscii)
        if packetSize < 64 {
            self.isParsingBtDataStream = false
            return
        }
        
        //Get the reponse for a command
        byteBuffer.append(contentsOf: self.btDataStreamBytes.prefix(packetSize))

        //Get data for the command)
        let dataBufferAscii = String(self.btDataStreamAscii.prefix(packetSize))
        let dataBufferHex = Util.sharedInstance.convertBytesToHex(byteBuffer: byteBuffer)
        
        let actualDataBufferHex = String(Util.sharedInstance.removeHeaderInfo(hexData: dataBufferHex, offset: offsetHex))  //Remove header information
        let actualDataBufferAscii = String(Util.sharedInstance.removeHeaderInfo(hexData: dataBufferAscii, offset: offsetAscii))  //Remove header information
        
        if Constants.debugOn {
            NSLog("parseBtDataStream dataBufferAscii.count=%d, %d   dataBufferHex.count=%d, %d",  dataBufferAscii.count, actualDataBufferAscii.count, dataBufferHex.count, actualDataBufferHex.count)
        }
        
        if Constants.debugOn4 {
            NSLog("parseBtDataStream cmd: \(String(describing: cmdInfo.cmd))   packetSize=%d, actualDataBufferHex.count=%d   actualDataBufferAscii.count=%d ", packetSize, actualDataBufferHex.count, actualDataBufferAscii.count)
            NSLog("parseBtDataStream actualDataBufferAscii: \(String(describing: actualDataBufferAscii))")
            NSLog("parseBtDataStream actualDataBufferHex: \(String(describing: actualDataBufferHex))")
        }
        
        //Parse response found for the command sent
        ParserUtil.sharedInstance.parsePacket(cmdInfo: cmdInfo, data: dataBufferAscii, hexData: actualDataBufferHex)

        
        //Remove response from btDataStreamBytes
        self.btDataStreamBytes.removeFirst(packetSize)
        self.btDataStreamAscii.removeFirst(packetSize)
        
        self.isParsingBtDataStream = false
        
    }
    

    
    
    func parseForAcknowledgement() -> CmdInfo {
        let notFound: CmdInfo = CmdInfo(cmd: "", timeoutInSeconds: 0, notificationName: Constants.commandTimeoutNotification, caller: "")
        
        while self.btDataStreamAscii.count > 0 {
            for (index, cmdInfo) in self.cmdInfoList.enumerated() {

                if self.btDataStreamAscii.hasPrefix(cmdInfo.cmd) {
                    self.cmdInfoList.remove(at: index)
                    return cmdInfo
                }
                
                if Constants.debugOn {
                    NSLog("Mike parseForAcknowledgement cmd:  \(String(describing: cmdInfo.cmd))   %d", self.cmdInfoList.count)
                }
                
            }
            
            //If not found - trim the leading characters
            self.btDataStreamBytes.removeFirst()
            self.btDataStreamAscii.removeFirst()

        }
        
        return notFound
        
    }
    

    
    func removeDuplicateCommands(mCmdInfo: CmdInfo) {
        var newList: [CmdInfo] = []
        
        for (index, cmdInfo) in self.cmdInfoList.enumerated() {
            if cmdInfo.cmd == mCmdInfo.cmd {
                print("Mike removeDuplicateCommands: ", index, cmdInfo.cmd)
                
            }else {
                newList.append(cmdInfo)
            }
        }

        self.cmdInfoList = newList
    }
    
    
    func checkTimedout() {
        var newList: [CmdInfo] = []
        
        print("Mike in func checkTimedout:  self.cmdInfoList.count=", self.cmdInfoList.count)
        
        for (index, cmdInfo) in self.cmdInfoList.enumerated() {
            let currentTime = Date()
            
            if currentTime > cmdInfo.endTime {
                //Handle Timeout
                cmdInfo.timedoutAt = currentTime
                cmdInfo.cmdStatus = Constants.timedOut
                NotificationCenter.default.post(name: cmdInfo.notificationName, object: cmdInfo)    //Send timeout to each caller base on caller name
                print("Mike checkTimedout:  Command timedout:", index, cmdInfo.cmd)
                
            }else {
                newList.append(cmdInfo)
            }
        }
        
        self.cmdInfoList = newList
    }
    
    
    
    // MARK:  Helper methods

    @objc func interruptLocalTimer() {
        
        for keyDict in Array(BluetoothUtil.sharedInstance.peripheralDict.keys) {
            if ((BluetoothUtil.sharedInstance.peripheralDict[keyDict]!.timeStamp!).timeIntervalSinceNow < -15.0) {
                BluetoothUtil.sharedInstance.peripheralDict.removeValue(forKey: keyDict)
            }
        }
        
    }
    

    
}



