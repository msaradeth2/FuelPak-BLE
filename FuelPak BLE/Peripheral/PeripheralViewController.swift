//
//  PeripheralViewController.swift
//  FuelPak BLE
//
//  Created by Mike Saradeth on 9/28/17.
//  Copyright © 2017 Mike Saradeth. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth


class PeripheralViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    struct PeripheralsStructure {
        var peripheralInstance: CBPeripheral?
        var peripheralRSSI: NSNumber?
        var timeStamp: Date?
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var signalStrengthButton: UIBarButtonItem!
    @IBOutlet weak var demoModeButton: UIBarButtonItem!
    
    private var btUtil = BluetoothUtil.sharedInstance
    private var peripheral: CBPeripheral?
    private var centralManager = BluetoothUtil.sharedInstance.cbCentralManager
    let listOfItems = BluetoothUtil.sharedInstance.peripheralDict  //[String: PeripheralsStructure]()
    
    //NSMutableArray  *listOfItems;
    //NSMutableArray  *listOfKeyItems;
    
    override func viewDidLoad() {
        registerNotification()
        
        initData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        btUtil.startScan()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
//        BtUtil.sharedInstance.initBluetoothUtility()
       
        
        updateTable()
        
//        evtRefreshButton(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    
    func initData() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
        
        updateTable()
        
    }
    
    
    
    @IBAction func evtDemoModeButton(_ sender: Any) {
        
        print("evtDemoModeButton")
        
        Bike.sharedInstance.isDemoMode = true
        
        performSegue(withIdentifier: "PeripheralsOutTabViewControllerIn", sender: self)
    }
    
    
    
    @IBAction func evtRefreshButton(_ sender: Any) {
        
        print("evtRefreshButton")
//        btUtil.startScan()
        
        self.tableView.reloadData()
    }
    
    

    func updateTable() {

        self.tableView.reloadData()
        
//        print(btUtil.peripheralDict.count)
//        if (btUtil.peripheralDict.count>0) {
//            for ii in 0...btUtil.peripheralDict.count-1 {
//                let text = Array(btUtil.peripheralDict.keys)[ii]
//                let peripheralRSSIValue = btUtil.peripheralDict[Array(btUtil.peripheralDict.keys)[ii]]!.peripheralRSSI!
//
//
//                let tmpString = "text= \(text).   peripheralRSSIValue= \(peripheralRSSIValue)"
//
//                print(tmpString)
//            }
//        }

        
//        listOfItems.removeAll()
//
//        listOfItems.append(BleDevice.sharedInstance.name)
//        listOfItems.append(BleDevice.sharedInstance.deviceStatus)
//
//        listOfItems.append(BleDevice.sharedInstance.manufacturerName)
//        listOfItems.append(BleDevice.sharedInstance.modelNumber)
//        listOfItems.append(BleDevice.sharedInstance.serialNumber)
//        listOfItems.append(BleDevice.sharedInstance.hardwareVersion)
//        listOfItems.append(BleDevice.sharedInstance.firmwareVersion)
//        listOfItems.append(BleDevice.sharedInstance.appVersion)
//        listOfItems.append(BleDevice.sharedInstance.systemId)
//
//        listOfItems.append(BleDevice.sharedInstance.serviceName)
//        listOfItems.append(BleDevice.sharedInstance.charactericName)
//
//        print(BleDevice.sharedInstance.charactericName)
//        print(listOfItems.count)
        
        
        
        
//
//                for i in 0...20 {
//                    listOfItems.append("\(i)")
//                }
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return btUtil.peripheralDict.count
        
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93.0
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionTitle = "Perpherals Nearby"

        return sectionTitle
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


//        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "CellIdentifier")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        

        cell.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
    
    
        // Configure the cell...
        var iconImage: UIImage? = UIImage(named: "nav_flash.png")
        cell.textLabel?.text = Array(btUtil.peripheralDict.keys)[indexPath.row]
//
        let peripheralRSSIValue = btUtil.peripheralDict[Array(btUtil.peripheralDict.keys)[indexPath.row]]!.peripheralRSSI!
//        cell.detailTextLabel?.text = "RSSI: \(peripheralRSSIValue)dB"

        
        if (peripheralRSSIValue.intValue < -27 && peripheralRSSIValue.intValue > -110) {
            
            if (peripheralRSSIValue.intValue <= -27 && peripheralRSSIValue.intValue > -60 ) {
                iconImage = UIImage(named: "rssiStrength100")
            }
            
            if (peripheralRSSIValue.intValue <= -60 && peripheralRSSIValue.intValue > -70 ) {
                iconImage = UIImage(named: "rssiStrength75")
            }
            
            if (peripheralRSSIValue.intValue <= -70 && peripheralRSSIValue.intValue > -80 ) {
                iconImage = UIImage(named: "rssiStrength50")
            }
            
            if (peripheralRSSIValue.intValue <= -80 && peripheralRSSIValue.intValue > -90 ) {
                iconImage = UIImage(named: "rssiStrength25")
            }
            
            if (peripheralRSSIValue.intValue <= -90 && peripheralRSSIValue.intValue > -110 ) {
                iconImage = UIImage(named: "rssiStrength0")
            }
            
            
            cell.detailTextLabel?.text = "RSSI: \(peripheralRSSIValue)dB"
            cell.imageView?.image = iconImage
        }
        
    
    return cell

    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        indexPath.row
        tableView.deselectRow(at: indexPath, animated: false)
        
        peripheral = btUtil.peripheralDict[Array(btUtil.peripheralDict.keys)[indexPath.row]]!.peripheralInstance!
        
//        btUtil.cbCentralManager.connect(<#T##peripheral: CBPeripheral##CBPeripheral#>, options: <#T##[String : Any]?#>)
//        CBPeripheral peripheral = btUtil.
//        indexPathForSelectedRow = indexPath
        btUtil.cbCentralManager.connect(peripheral!, options: nil)
        
        
//        PeripheralsStructure peripheralsStructure = self.btUtil.peripheralDict[indexPath.row];

        
//        [self.defaultBTServer readValue:ch];
//        [ProgressHUD show:@"reading characteristic"];
        
        

        
        
        
//        let alertController = UIAlertController(title: "Hint", message: "You have selected row \(indexPath.row).", preferredStyle: .alert)
//
//        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
//
//        alertController.addAction(alertAction)
//
//        present(alertController, animated: true, completion: nil)
        
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
    


    

    
    
    func registerNotification() {

        NotificationCenter.default.addObserver(self, selector: #selector(didConnectPeripheral(notification:)), name: .didConnectPeripheralNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didFailToConnect(notfication:)), name: .didFailToConnectNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didDiscoverPeripheral(notfication:)), name: .didDiscoverPeripheralNotification, object: nil)
        
    }

    
    @objc func didConnectPeripheral(notification: NSNotification) {
        Bike.sharedInstance.isDemoMode = false
        if self.centralManager!.isScanning{
            self.centralManager?.stopScan()
        }
        
        performSegue(withIdentifier: "PeripheralsOutTabViewControllerIn", sender: self)
    }
    
    @objc func didFailToConnect(notfication: NSNotification) {

    }
    
    @objc func didDiscoverPeripheral(notfication: NSNotification) {
//        listOfItems = btUtil.peripheralDict
//        self.listOfItems = BluetoothUtil.sharedInstance.peripheralDict
        self.tableView.reloadData()
        
        print("self.tableView.reloadData")
    }
    
    
}


extension Notification.Name {
    static let didConnectPeripheralNotification = Constants.didConnectPeripheralNotification
    static let didFailToConnectNotification = Constants.didFailToConnectNotification
    static let didDiscoverPeripheralNotification = Constants.didDiscoverPeripheralNotification
}




