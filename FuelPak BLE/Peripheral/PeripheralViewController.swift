//
//  PeripheralViewController.swift
//  FuelPak BLE
//
//  Created by Mike Saradeth on 9/28/17.
//  Copyright © 2017 Mike Saradeth. All rights reserved.
//

import Foundation
import UIKit



class PeripheralViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var signalStrengthButton: UIBarButtonItem!
    @IBOutlet weak var demoModeButton: UIBarButtonItem!
    

    
    private var listOfItems: [String] = []
    
    
    
    override func viewDidLoad() {
        
        initData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        BtUtil.sharedInstance.initBluetoothUtility()
        
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
    
    
    func updateTable() {

        listOfItems.removeAll()
        
        listOfItems.append(BleDevice.sharedInstance.name)
        listOfItems.append(BleDevice.sharedInstance.deviceStatus)
        
        listOfItems.append(BleDevice.sharedInstance.manufacturerName)
        listOfItems.append(BleDevice.sharedInstance.modelNumber)
        listOfItems.append(BleDevice.sharedInstance.serialNumber)
        listOfItems.append(BleDevice.sharedInstance.hardwareVersion)
        listOfItems.append(BleDevice.sharedInstance.firmwareVersion)
        listOfItems.append(BleDevice.sharedInstance.appVersion)
        listOfItems.append(BleDevice.sharedInstance.systemId)
        
        listOfItems.append(BleDevice.sharedInstance.serviceName)
        listOfItems.append(BleDevice.sharedInstance.charactericName)
        
        print(BleDevice.sharedInstance.charactericName)
        print(listOfItems.count)
        
        
        
        tableView.reloadData()
        
        //        for i in 0...20 {
        //            listOfItems.append("\(i)")
        //        }
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfItems.count
        
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
        let sectionTitle = "DEVICE INFORMATION"

        return sectionTitle
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath as IndexPath) as UITableViewCell

        let text = listOfItems[indexPath.row] //2.
        
        cell.textLabel?.text = text //3.
        
        return cell //4.
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
}
