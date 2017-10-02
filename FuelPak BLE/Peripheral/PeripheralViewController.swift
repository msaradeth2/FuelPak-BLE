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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var signalStrengthButton: UIBarButtonItem!
    @IBOutlet weak var demoModeButton: UIBarButtonItem!
    
    private var btDevice = BTDevice.sharedInstance
    

    
    
    
    override func viewDidLoad() {
        
        initData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
//        BtUtil.sharedInstance.initBluetoothUtility()
       
        
        updateTable()
        
        evtRefreshButton(self)
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
        
        self.tableView.reloadData()
    }
    
    
    
    func updateTable() {

        self.tableView.reloadData()
        
//        print(btDevice.peripheralDict.count)
//        if (btDevice.peripheralDict.count>0) {
//            for ii in 0...btDevice.peripheralDict.count-1 {
//                let text = Array(btDevice.peripheralDict.keys)[ii]
//                let peripheralRSSIValue = btDevice.peripheralDict[Array(btDevice.peripheralDict.keys)[ii]]!.peripheralRSSI!
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
        
        return btDevice.peripheralDict.count
        
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
        cell.textLabel?.text = Array(btDevice.peripheralDict.keys)[indexPath.row]
//
        let peripheralRSSIValue = btDevice.peripheralDict[Array(btDevice.peripheralDict.keys)[indexPath.row]]!.peripheralRSSI!
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
        
        Bike.sharedInstance.isDemoMode = false
        performSegue(withIdentifier: "PeripheralsOutTabViewControllerIn", sender: self)
        
        
        
//        let alertController = UIAlertController(title: "Hint", message: "You have selected row \(indexPath.row).", preferredStyle: .alert)
//
//        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
//
//        alertController.addAction(alertAction)
//
//        present(alertController, animated: true, completion: nil)
        
    }
}
