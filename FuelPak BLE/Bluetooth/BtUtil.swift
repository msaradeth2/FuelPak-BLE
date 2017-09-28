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


//        2017-09-27 14:27:38.957635-0700 MLDPDemo[699:147395] Service discovered: 49535343-FE7D-4AE5-8FA9-9FAFD205E455
//        2017-09-27 14:27:39.019055-0700 MLDPDemo[699:147395] Characteristics discovered: 49535343-1E4D-4BD9-BA61-23C647249616
//        2017-09-27 14:27:39.019819-0700 MLDPDemo[699:147395] Characteristics discovered: 49535343-8841-43F4-A8D4-ECBE34729BB3


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

        initBluetoothUtility()
    }
    
    
    public enum AppError : Error {
        case dataCharactertisticNotFound
        case enabledCharactertisticNotFound
        case updateCharactertisticNotFound
        case serviceNotFound
        case invalidState
        case resetting
        case poweredOff
        case unknown
    }
    
    

    
    var dataCharacteristic : Characteristic?
    
    
    
    
    // MARK: - Init BlueTooth
    func initBluetoothUtility() {
        var peripheral: Peripheral?
        
        
        //Init Service UUID and Characteristic UUID for FuelPak BLE
        let serviceUUID = CBUUID(string:"49535343-FE7D-4AE5-8FA9-9FAFD205E455") //The service UUID
        let dataCharacteristicUUID = CBUUID(string:"49535343-8841-43F4-A8D4-ECBE34729BB3")
        //let dataCharacteristicUUID = CBUUID(string:"49535343-1E4D-4BD9-BA61-23C647249616")
        
        //initialize a central manager with a restore key. The restore key allows to resuse the same central manager in future calls
        let manager = CentralManager(options: [CBCentralManagerOptionRestoreIdentifierKey : "CentralMangerKey" as NSString])
        
        //A future stram that notifies us when the state of the central manager changes
        let stateChangeFuture = manager.whenStateChanges()
        
        
        
        //handle state changes and return a scan future if the bluetooth is powered on.
        let scanFuture = stateChangeFuture.flatMap { state -> FutureStream<Peripheral> in
            switch state {
            case .poweredOn:
                DispatchQueue.main.async {
//                    self.connectionStatusLabel.text = "start scanning"
//                    print(self.connectionStatusLabel.text!)
                }
                //scan for peripherlas that advertise the ec00 service
                //                return manager.startScanning(forServiceUUIDs: [serviceUUID])
                return manager.startScanning()
            case .poweredOff:
                throw AppError.poweredOff
            case .unauthorized, .unsupported:
                throw AppError.invalidState
            case .resetting:
                throw AppError.resetting
            case .unknown:
                //generally this state is ignored
                throw AppError.unknown
            }
        }
        
        scanFuture.onFailure { error in
            guard let appError = error as? AppError else {
                return
            }
            switch appError {
            case .invalidState:
                break
            case .resetting:
                manager.reset()
            case .poweredOff:
                break
            case .unknown:
                break
            default:
                break;
            }
        }
        
        //We will connect to the first scanned peripheral
        let connectionFuture = scanFuture.flatMap { p -> FutureStream<Void> in
            //stop the scan as soon as we find the first peripheral
            manager.stopScanning()
            peripheral = p
            guard let peripheral = peripheral else {
                throw AppError.unknown
            }
            DispatchQueue.main.async {
//                self.connectionStatusLabel.text = "Found peripheral \(peripheral.identifier.uuidString). Trying to connect"
//                print(self.connectionStatusLabel.text!)
                
                let tmpString = "Found peripheral \(peripheral.identifier.uuidString). Trying to connect"
                print(tmpString)
            }
            //connect to the peripheral in order to trigger the connected mode
            return peripheral.connect(connectionTimeout: 10, capacity: 5)
        }
        
        //we will next discover the "ec00" service in order be able to access its characteristics
        let discoveryFuture = connectionFuture.flatMap { _ -> Future<Void> in
            guard let peripheral = peripheral else {
                throw AppError.unknown
            }
            return peripheral.discoverServices([serviceUUID])
            }.flatMap { _ -> Future<Void> in
                guard let discoveredPeripheral = peripheral else {
                    throw AppError.unknown
                }
                guard let service = discoveredPeripheral.services(withUUID:serviceUUID)?.first else {
                    throw AppError.serviceNotFound
                }
                peripheral = discoveredPeripheral
                DispatchQueue.main.async {
//                    self.connectionStatusLabel.text = "Discovered service \(service.uuid.uuidString). Trying to discover characteristics"
//                    print(self.connectionStatusLabel.text!)
                    
                    let tmpString = "Discovered service \(service.uuid.uuidString). Trying to discover characteristics"
                    print(tmpString)
                }
                //we have discovered the service, the next step is to discover the "ec0e" characteristic
                return service.discoverCharacteristics([dataCharacteristicUUID])
        }
        
        /**
         1- checks if the characteristic is correctly discovered
         2- Register for notifications using the dataFuture variable
         */
        let dataFuture = discoveryFuture.flatMap { _ -> Future<Void> in
            guard let discoveredPeripheral = peripheral else {
                throw AppError.unknown
            }
            guard let dataCharacteristic = discoveredPeripheral.services(withUUID:serviceUUID)?.first?.characteristics(withUUID:dataCharacteristicUUID)?.first else {
                throw AppError.dataCharactertisticNotFound
            }
            self.dataCharacteristic = dataCharacteristic
            DispatchQueue.main.async {
//                self.connectionStatusLabel.text = "Discovered characteristic \(dataCharacteristic.uuid.uuidString). COOL :)"
//                print(self.connectionStatusLabel.text!)
                
                let tmpString = "Discovered characteristic \(dataCharacteristic.uuid.uuidString). COOL :)"
                print(tmpString)
                
            }
            //when we successfully discover the characteristic, we can show the characteritic view
            DispatchQueue.main.async {
//                self.loadingView.isHidden = true
//                self.characteristicView.isHidden = false
            }
            //read the data from the characteristic
            self.read()
            //Ask the characteristic to start notifying for value change
            return dataCharacteristic.startNotifying()
            }.flatMap { _ -> FutureStream<Data?> in
                guard let discoveredPeripheral = peripheral else {
                    throw AppError.unknown
                }
                guard let characteristic = discoveredPeripheral.services(withUUID:serviceUUID)?.first?.characteristics(withUUID:dataCharacteristicUUID)?.first else {
                    throw AppError.dataCharactertisticNotFound
                }
                //regeister to recieve a notifcation when the value of the characteristic changes and return a future that handles these notifications
                return characteristic.receiveNotificationUpdates(capacity: 10)
        }
        
        //The onSuccess method is called every time the characteristic value changes
        dataFuture.onSuccess { data in
            let s = String(data:data!, encoding: .utf8)
            DispatchQueue.main.async {
//                self.notifiedValueLabel.text = "notified value is \(String(describing: s))"
                
                let tmpString = "notified value is \(String(describing: s))"
                print(tmpString)
                
            }
        }
        
        //handle any failure in the previous chain
        dataFuture.onFailure { error in
            switch error {
            case PeripheralError.disconnected:
                peripheral?.reconnect()
            case AppError.serviceNotFound:
                break
            case AppError.dataCharactertisticNotFound:
                break
            default:
                break
            }
        }
    }
    
    
    
    // MARK: - Read
    func read(){
        //read a value from the characteristic
        let readFuture = self.dataCharacteristic?.read(timeout: 5)
        readFuture?.onSuccess { (_) in
            //the value is in the dataValue property
            let s = String(data:(self.dataCharacteristic?.dataValue)!, encoding: .utf8)
            DispatchQueue.main.async {
//                self.valueLabel.text = "Read value is \(String(describing: s))"
//                print(self.valueLabel.text!)
                
                let tmpString = "Read value is \(String(describing: s))"
                print(tmpString)
                
            }
        }
        readFuture?.onFailure { (_) in
//            self.valueLabel.text = "read error"
        }
    }
    
    
    // MARK: - write
    func write(cmd: String){
//        self.valueToWriteTextField.resignFirstResponder()
//        guard let text = self.valueToWriteTextField.text else{
//            return;
//        }
        
        print(cmd)
        
        //write a value to the characteristic
        let writeFuture = self.dataCharacteristic?.write(data:cmd.data(using: .utf8)!)
        writeFuture?.onSuccess(completion: { (_) in
            print("write succes")
        })
        writeFuture?.onFailure(completion: { (e) in
            print("write failed")
        })
    }
    
}
