//
//  SystemInfoViewController.swift
//  FuelPak BLE
//
//  Created by Mike Saradeth on 10/2/17.
//  Copyright © 2017 Mike Saradeth. All rights reserved.
//


import Foundation
import UIKit
import CoreBluetooth


class SystemInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CBPeripheralDelegate {
    
    struct PeripheralsStructure {
        var peripheralInstance: CBPeripheral?
        var peripheralRSSI: NSNumber?
        var timeStamp: Date?
    }
    
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var signalStrengthButton: UIBarButtonItem!
    
    
    private var btUtil = BluetoothUtil.sharedInstance
    private var listOfItems: [String] = []
    private var listOfItemsSection_0: [String] = []
    
    
    
    override func viewDidLoad() {
        registerNotification()
        
        initData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {

        
        
        updateTable()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    
    func initData() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
//        self.tableView.register(UINib(nibName: "CustomHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomHeaderView")
        
        updateTable()
        
    }
    
    
    
    
    
    
    @IBAction func evtBackButton(_ sender: Any) {
        print("evtBackButton")
        if !Bike.sharedInstance.isDemoMode {
            BluetoothUtil.sharedInstance.cancelConnect()
        }
        
        self.dismiss(animated: false, completion: exitViewController)
    }
    
    @IBAction func evtRefreshButton(_ sender: Any) {
        print("evtRefreshButton")
        
        print("BluetoothUtil.sharedInstance.write(cmd: \"UVIN00\")")
        BluetoothUtil.sharedInstance.write(cmd: "UVIN00")
        
        self.tableView.reloadData()
    }
    
    
    
    func exitViewController() {
        print("exitViewController")
    }
    
    
    func updateTable() {
        
        self.tableView.reloadData()
        
        print(btUtil.peripheralDict.count)
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
        
        
        
        
        
//                        for i in 0...20 {
//                            listOfItems.append("\(i)")
//                        }
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 0:
            return listOfItemsSection_0.count
            
        case 1:
            return listOfItems.count
            
        default:
            return 0
        }

        
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93.0
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let vw = UIView()
//        vw.backgroundColor = UIColor.red
//
//        let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier("CustomHeaderView") as! CustomHeaderView
//
//        headerView.customLabel.text = BleDevice.sharedInstance.isConnected
//        headerView.sectionNumber = section
//        headerView.delegate = self
//
//        return headerView
//    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        var sectionTitle: String

        switch section {
        case 0:
            if (Bike.sharedInstance.isDemoMode == true) {
                sectionTitle = "Status:  Demo Mode"
            }else {
                if (Bike.sharedInstance.isConnected) {
                    sectionTitle = "Status:  Connected"
                }else {
                    sectionTitle = "Status:  Disconnected"
                }
            }


        case 1:
            sectionTitle = "Perpherals Nearby"

        default:
            sectionTitle = " "
        }

        return sectionTitle
    }
    
    
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//
//        switch section {
//        case 0:
//            return 93.0
//
//        case 1:
//            return 50.0
//
//        default:
//            return 0
//        }
//    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "CellIdentifier")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        
        
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
        
        
        cell.textLabel?.text = self.listOfItems[indexPath.row]
        cell.detailTextLabel?.text = self.listOfItems[indexPath.row]
        
//        // Configure the cell...
//        var iconImage: UIImage? = UIImage(named: "nav_flash.png")
//        cell.textLabel?.text = Array(btUtil.peripheralDict.keys)[indexPath.row]
//        //
//        let peripheralRSSIValue = btUtil.peripheralDict[Array(btUtil.peripheralDict.keys)[indexPath.row]]!.peripheralRSSI!
//        //        cell.detailTextLabel?.text = "RSSI: \(peripheralRSSIValue)dB"
//
        
        
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        indexPath.row
        tableView.deselectRow(at: indexPath, animated: false)
        

        
        
        //        let alertController = UIAlertController(title: "Hint", message: "You have selected row \(indexPath.row).", preferredStyle: .alert)
        //
        //        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        //
        //        alertController.addAction(alertAction)
        //
        //        present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    func registerNotification() {
        
//        NotificationCenter.default.addObserver(self, selector: #selector(didConnectPeripheral(notification:)), name: .didConnectPeripheralNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateValueForcharacteristic(notfication:)), name: .didUpdateValueForcharacteristicNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didDiscoverCharacteristic(notfication:)), name: .didDiscoverCharacteristicsNotification, object: nil)
        
    }
    
    
    
    
    @objc func didDiscoverCharacteristic(notfication: NSNotification) {

        BluetoothUtil.sharedInstance.write(cmd: "UVIN00")
        
//        for ii in 0...20 {
//            print("BluetoothUtil.sharedInstance.write(\(ii) cmd: \"UVIN00\")")
//
//            BluetoothUtil.sharedInstance.write(cmd: "UVIN00")
//        }
        
        
    }
    
    
    @objc func didUpdateValueForcharacteristic(notfication: NSNotification) {
        
//        listOfItems.removeAll()
        listOfItems.append(BluetoothUtil.sharedInstance.resultString)
        tableView.reloadData()
        
        
    }
    
    
    
    

    
    
}

//
extension Notification.Name {
    static let didDiscoverCharacteristicsNotification = Constants.didDiscoverCharacteristicsNotification
    static let didUpdateValueForcharacteristicNotification = Constants.didUpdateValueForcharacteristicNotification
    
//    
//    static let didConnectPeripheralNotification = Constants.didConnectPeripheralNotification
//    static let didFailToConnectNotification = Constants.didFailToConnectNotification
//    static let didDiscoverPeripheralNotification = Constants.didDiscoverPeripheralNotification
}

