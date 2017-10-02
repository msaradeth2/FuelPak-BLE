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


class SystemInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var signalStrengthButton: UIBarButtonItem!
    
    
    private var btDevice = BTDevice.sharedInstance
    private var listOfItems: [String] = []
    private var listOfItemsSection_1: [String] = []
    
    
    
    override func viewDidLoad() {
        
        initData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //        BtUtil.sharedInstance.initBluetoothUtility()
        
        
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
        
        updateTable()
        
    }
    
    
    
    
    
    
    @IBAction func evtBackButton(_ sender: Any) {
        print("evtBackButton")
        self.dismiss(animated: false, completion: exitViewController)
    }
    
    @IBAction func evtRefreshButton(_ sender: Any) {
        print("evtRefreshButton")
    }
    
    
    
    func exitViewController() {
        print("exitViewController")
    }
    
    
    func updateTable() {
        
        self.tableView.reloadData()
        
        print(btDevice.peripheralDict.count)
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
        
        
        
        
        
                        for i in 0...20 {
                            listOfItems.append("\(i)")
                        }
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 1:
            return listOfItemsSection_1.count
            
        case 2:
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
    //    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var sectionTitle: String

        switch section {
        case 1:
            sectionTitle = "Status:  Connected"
            
        case 2:
            sectionTitle = "Perpherals Nearby"
            
        default:
            sectionTitle = " "
        }

        return sectionTitle
    }
    
    
    
    
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
//        cell.textLabel?.text = Array(btDevice.peripheralDict.keys)[indexPath.row]
//        //
//        let peripheralRSSIValue = btDevice.peripheralDict[Array(btDevice.peripheralDict.keys)[indexPath.row]]!.peripheralRSSI!
//        //        cell.detailTextLabel?.text = "RSSI: \(peripheralRSSIValue)dB"
//
        
        
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        indexPath.row
        tableView.deselectRow(at: indexPath, animated: false)
        
        performSegue(withIdentifier: "PeripheralOutSystemInfoIn", sender: self)
        
        
        
        //        let alertController = UIAlertController(title: "Hint", message: "You have selected row \(indexPath.row).", preferredStyle: .alert)
        //
        //        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        //
        //        alertController.addAction(alertAction)
        //
        //        present(alertController, animated: true, completion: nil)
        
    }
    
}

