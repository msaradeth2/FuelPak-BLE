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


final class BluetoothUtil: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    // MARK: - Shared Instance
    static let sharedInstance: BluetoothUtil = {
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

    //        2017-09-27 14:27:38.957635-0700 MLDPDemo[699:147395] Service discovered: 49535343-FE7D-4AE5-8FA9-9FAFD205E455
    //        2017-09-27 14:27:39.019055-0700 MLDPDemo[699:147395] Characteristics discovered: 49535343-1E4D-4BD9-BA61-23C647249616
    //        2017-09-27 14:27:39.019819-0700 MLDPDemo[699:147395] Characteristics discovered: 49535343-8841-43F4-A8D4-ECBE34729BB3
    
//    fileprivate let mchpServiceUUID = CBUUID(string: "00035B03-58E6-07DD-021A-08123A000300")
//    fileprivate let mchpTxUUID = CBUUID(string: "00035B03-58E6-07DD-021A-08123A000301")
//    fileprivate let mchpRxUUID = CBUUID(string: "00035B03-58E6-07DD-021A-08123A000301")
//    fileprivate let mchpRemoteTxUUID = CBUUID(string: "00035B03-58E6-07DD-021A-08123A0003FF")
//    fileprivate let mchpRemoteRxUUID = CBUUID(string: "00035B03-58E6-07DD-021A-08123A0003FF")
//
//    fileprivate var customServiceUUID = CBUUID(string: "00000000-0000-0000-0000-000000000000")
//    fileprivate var customTxUUID = CBUUID(string: "00000000-0000-0000-0000-000000000000")
//    fileprivate var customRxUUID = CBUUID(string: "00000000-0000-0000-0000-000000000000")
//    fileprivate let isscServiceUUID = CBUUID(string: "49535343-FE7D-4AE5-8FA9-9FAFD205E455")
//    fileprivate let isscTxUUID = CBUUID(string: "49535343-8841-43F4-A8D4-ECBE34729BB3")
//    fileprivate let isscRxUUID = CBUUID(string: "49535343-1E4D-4BD9-BA61-23C647249616")
    //    fileprivate var characteristicTxInstance: CBCharacteristic?
    //    fileprivate var characteristicRxInstance: CBCharacteristic?
    //    fileprivate var characteristicRemoteTxInstance: CBCharacteristic?
    //    fileprivate var characteristicRemoteRxInstance: CBCharacteristic?

    
    
    //Start here
    fileprivate let serviceUUID = CBUUID(string: "49535343-FE7D-4AE5-8FA9-9FAFD205E455")
    fileprivate let characteristicUUID = CBUUID(string: "49535343-8841-43F4-A8D4-ECBE34729BB3")
    fileprivate let characteristicUUID2 = CBUUID(string: "49535343-1E4D-4BD9-BA61-23C647249616")
    fileprivate var characteristicInstance: CBCharacteristic?
//    fileprivate var characteristicInstance2: CBCharacteristic?
    
    fileprivate var alertController: UIAlertController?
    fileprivate var localTimer: Timer = Timer()
    fileprivate var rssiTime: Date = Date()
//    fileprivate var cbCentralManager: CBCentralManager!
//    fileprivate var peripheralDict = [String: PeripheralsStructure]()
    
    fileprivate var previousPeripheralRSSIValue: Int = 0
    fileprivate var indexPathForSelectedRow: IndexPath?
    fileprivate var remoteCommandEnabled: Bool = false
    fileprivate var upgradeEnabled: Bool = false
    fileprivate var appDelegate: AppDelegate = AppDelegate()
//    fileprivate var appContext: NSManagedObjectContext = NSManagedObjectContext()
    fileprivate var appResults: NSArray = NSArray()
    
    fileprivate var peripheralInstance: CBPeripheral?

    
    var cbCentralManager: CBCentralManager!
    var peripheralDict = [String: PeripheralsStructure]()
    var discoveredSevice: CBService?
//    var selectedPeripheral: CBPeripheral?
//    var selectCharacteristic: CBCharacteristic?
    
//    @property (strong,nonatomic)CBPeripheral* selectPeripheral;
//    @property (strong,nonatomic)CBService* discoveredSevice;
//    @property (strong,nonatomic)CBCharacteristic *selectCharacteristic;
    
    
    func initData() {
        
        
//        navigationController?.delegate = self
        peripheralDict.removeAll()
        
//        tableView.reloadData()
//        peripheralsIndicator.startAnimating()
        appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        
        
        
        
//        let concurrentQueue = DispatchQueue(label:"com.myBLEQueue", attributes: .concurrent) //Swift 3 version
//        cbCentralManager = CBCentralManager(delegate: self, queue: concurrentQueue)
        cbCentralManager = CBCentralManager(delegate: self, queue: nil)
        
        
        
        
//        appContext = appDelegate.managedObjectContext!
//
//        let appRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PrivateServiceSerialData")
//
//        appRequest.returnsObjectsAsFaults = false
//        appResults = try! appContext.fetch(appRequest) as NSArray
//
//        if (appResults.count > 0) {
//            customServiceUUID = CBUUID(string: ((appResults.firstObject as! NSManagedObject).value(forKey: "serviceUUID") as? String)!)
//            customTxUUID = CBUUID(string: ((appResults.firstObject as! NSManagedObject).value(forKey: "transmitUUID") as? String)!)
//            customRxUUID = CBUUID(string: ((appResults.firstObject as! NSManagedObject).value(forKey: "receiveUUID") as? String)!)
//
//        }
//
//        localTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(PeripheralsTableViewController.interruptLocalTimer), userInfo: nil, repeats: true)
//
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
//        self.peripheralInstance = peripheral
//        NSLog("connect: \(String(describing: peripheralInstance?.name))")
        cbCentralManager.connect(peripheral!, options: nil)
    }
    
    public func cancelConnect() {
        

        cbCentralManager .cancelPeripheralConnection(peripheralInstance!)
        
//        if (self.selectedPeripheral!=nil) {
//        if(self.selectedPeripheral.state == CBPeripheralStateConnecting){
//            NSLog("timeout cancel connect to peripheral:%@",self.selectPeripheral.name);
//
//            [cbCentralManager cancelPeripheralConnection:self.selectedPeripheral];
//        }
//
    }
    

//    public func write(cmd: String) {
//        NSLog("write: \(cmd)")
//
//
////        [UInt8](cmd)
//
//
////        let array: [UInt8] = Array(cmd.utf8)
//
//        let bytesData: [UInt8] = Array(cmd.utf8)
////        var bytesData = [UInt8](cmd)
////        let writeData = Data(bytes: &bytesData, count: bytesData.count)
//
//
////                let writeData = Data(bytes: UnsafePointer<UInt8>(&bytesData), count: bytesData.count)
//        let writeData = Data(bytes: &bytesData, count: bytesData.count)
//        peripheralInstance!.writeValue(writeData, for: characteristicTxInstance! as CBCharacteristic, type:CBCharacteristicWriteType.withResponse)
//        //
//
//    }
    
//    @IBAction func sendButton(_ sender: AnyObject) {
//        var bytesData = [UInt8] (sendField.text!.utf8)
//        //Mike
//        //        let writeData = Data(bytes: UnsafePointer<UInt8>(&bytesData), count: bytesData.count)
//        let writeData = Data(bytes: &bytesData, count: bytesData.count)
//        peripheralInstance!.writeValue(writeData, for: characteristicTxInstance! as CBCharacteristic, type:CBCharacteristicWriteType.withResponse)
//        //
//        sendField.text = ""
//        sendField.resignFirstResponder()
//    }
    
    func write(cmd: String) {
        let cmd = "UVIN00"
        var bytesData = [UInt8] (cmd.utf8)
        //        let writeData = Data(bytes: UnsafePointer<UInt8>(&bytesData), count: bytesData.count)
        let writeData = Data(bytes: &bytesData, count: bytesData.count)
        
        NSLog("connect peripheralInstance: \(String(describing: peripheralInstance?.name))")
        NSLog("connect characteristicInstance uuid: \(String(describing: characteristicInstance?.uuid))")
        
//        peripheralInstance!.writeValue(writeData, for: characteristicInstance! as CBCharacteristic, type:CBCharacteristicWriteType.withResponse)
        
        
//        var bytesData = [UInt8] (cmd)
////        var bytesData: [UInt8] = [UInt8](cmd.utf8)
//        var bytesData = [UInt8](cmd.utf8)
//        Data
//        let writeData = Data(bytes: &bytesData, count: bytesData.count)
//        peripheralInstance!.writeValue(writeData, for: characteristicInstance! as CBCharacteristic, type:CBCharacteristicWriteType.withResponse)
    }
    
    
    
    
    func scanForPeripherals() {
        cbCentralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
        
        let triggerTime = (Int64(NSEC_PER_SEC) * 90000)
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
//            cbCentralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
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
            peripheralDict.updateValue(PeripheralsStructure(peripheralInstance: peripheral, peripheralRSSI: RSSI, timeStamp: Date()), forKey: peripheralName)
            
            
            // Post notification
            NotificationCenter.default.post(name: Constants.didDiscoverPeripheralNotification, object: nil)
            
            NSLog("didDiscover peripheral: \(peripheralName)")
            
//            peripheralDict.updateValue(PeripheralsStructure(peripheralInstance: peripheral, peripheralRSSI: RSSI, timeStamp: Date()), forKey: peripheralName)
//            peripheralsIndicator.stopAnimating()
//            tableView.reloadData()
        }
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        Bike.sharedInstance.isConnected = true
        peripheral.delegate = self
        peripheral.discoverServices([serviceUUID])
        
        peripheralInstance = peripheral
        
        // Post notification
        NotificationCenter.default.post(name: Constants.didConnectPeripheralNotification, object: nil)
        
        NSLog("didConnect peripheral: \(peripheral.name)")
        
//        peripheral.discoverServices([mchpServiceUUID, isscServiceUUID, customServiceUUID])
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        Bike.sharedInstance.isConnected = false
     
        NSLog("didDisconnectPeripheral peripheral: \(peripheral.name)")
        
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
            
            
//            if (service.uuid == mchpServiceUUID) {
//                peripheral.discoverCharacteristics([mchpTxUUID, mchpRxUUID, mchpRemoteTxUUID, mchpRemoteRxUUID], for: service )
//            }
//            else if (service.uuid == isscServiceUUID) {
//                peripheral.discoverCharacteristics([isscTxUUID, isscRxUUID], for: service )
//            }
//            else if (service.uuid == customServiceUUID) {
//                peripheral.discoverCharacteristics([customTxUUID, customRxUUID], for: service )
//            }
            
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

                if (characteristic.uuid == characteristicUUID) {
                    characteristicInstance = characteristic
                    NSLog("connect Characteristics discovered: \(characteristic.uuid)")
                }
//                if (characteristic.uuid == characteristicUUID2) {
//                    characteristicInstance2 = characteristic
//                }
                
            }
        }
        
        
        // Post notification
        NotificationCenter.default.post(name: Constants.didDiscoverCharacteristicsNotification, object: nil)
            
//            if (service.uuid == mchpServiceUUID) {
//
//                if (characteristic.uuid == mchpTxUUID) {
//                    characteristicTxInstance = characteristic
//                }
//
//                if (characteristic.uuid == mchpRxUUID) {
//                    peripheral.setNotifyValue(true, for: characteristic )
//                    characteristicRxInstance = characteristic
//                }
//
//                if (characteristic.uuid == mchpRemoteTxUUID) {
//                    remoteCommandEnabled = true
//                    upgradeEnabled = true
//                    characteristicRemoteTxInstance = characteristic
//                }
//
//                if (characteristic.uuid == mchpRemoteRxUUID) {
//                    remoteCommandEnabled = true
//                    upgradeEnabled = true
//                    characteristicRemoteRxInstance = characteristic
//                }
//            }
//            else if (service.uuid == isscServiceUUID) {
//                if (characteristic.uuid == isscTxUUID) {
//                    characteristicTxInstance = characteristic
//                }
//
//                if (characteristic.uuid == isscRxUUID) {
//                    peripheral.setNotifyValue(true, for: characteristic )
//                    characteristicRxInstance = characteristic
//                }
//            }
//            else if (service.uuid == customServiceUUID) {
//                if (characteristic.uuid == customTxUUID) {
//                    characteristicTxInstance = characteristic
//                }
//
//                if (characteristic.uuid == customRxUUID) {
//                    peripheral.setNotifyValue(true, for: characteristic )
//                    characteristicRxInstance = characteristic
//                }
//            }
//        }
        
//        performSegue(withIdentifier: "ActivityViewController", sender: self)
        
    }

    
}
