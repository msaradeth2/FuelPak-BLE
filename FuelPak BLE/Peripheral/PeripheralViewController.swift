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



class PeripheralViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CBPeripheralDelegate {
    
    // MARK:  Define Variables
    
    struct PeripheralsStructure {
        var peripheralInstance: CBPeripheral?
        var peripheralRSSI: NSNumber?
        var timeStamp: Date?
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var signalStrengthButton: UIBarButtonItem!
    @IBOutlet weak var demoModeButton: UIBarButtonItem!

    private var peripheral: CBPeripheral?
    private var centralManager = BluetoothUtil.sharedInstance.cbCentralManager
    private var localTimer: Timer = Timer()

    
    
    
    //MARK:  Default Methods
    
    override func viewDidLoad() {
        registerNotification()
        
        initData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        BluetoothUtil.sharedInstance.peripheralDict.removeAll()
        tableView.reloadData()
        BluetoothUtil.sharedInstance.startScan()
       
//        localTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(interruptLocalTimer), userInfo: nil, repeats: true)
        updateTable()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    
    
    //MARK:  Init Data
    func initData() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
        
        updateTable()
        
    }
    
    
    

    
    // MARK: Events Methods
    
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
    

    
    

    
    
    // MARK: - TableView Delegation methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return BluetoothUtil.sharedInstance.peripheralDict.count
        
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
        cell.textLabel?.text = Array(BluetoothUtil.sharedInstance.peripheralDict.keys)[indexPath.row]
//
        let peripheralRSSIValue = BluetoothUtil.sharedInstance.peripheralDict[Array(BluetoothUtil.sharedInstance.peripheralDict.keys)[indexPath.row]]!.peripheralRSSI!
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
        
        peripheral = BluetoothUtil.sharedInstance.peripheralDict[Array(BluetoothUtil.sharedInstance.peripheralDict.keys)[indexPath.row]]!.peripheralInstance!
        BluetoothUtil.sharedInstance.connect(peripheral: peripheral)
        
    }
        


    

    // MARK:  Register/Remove Notification and Notification Delegation Methods
    
    func registerNotification() {

        NotificationCenter.default.addObserver(self, selector: #selector(didConnectPeripheral(notification:)), name: .didConnectPeripheralNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didFailToConnect(notfication:)), name: .didFailToConnectNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didDiscoverPeripheral(notfication:)), name: .didDiscoverPeripheralNotification, object: nil)
        
    }

    
    @objc func didConnectPeripheral(notification: NSNotification) {
        Bike.sharedInstance.isDemoMode = false
        BluetoothUtil.sharedInstance.stopScan()

        performSegue(withIdentifier: "PeripheralsOutTabViewControllerIn", sender: self)
    }
    
    @objc func didFailToConnect(notfication: NSNotification) {

    }
    
    @objc func didDiscoverPeripheral(notfication: NSNotification) {

        self.tableView.reloadData()
        print("self.tableView.reloadData")
    }
    
//    @objc func interruptLocalTimer() {
//        
//        for keyDict in Array(BluetoothUtil.sharedInstance.peripheralDict.keys) {
//            if ((BluetoothUtil.sharedInstance.peripheralDict[keyDict]!.timeStamp!).timeIntervalSinceNow < -15.0) {
//                BluetoothUtil.sharedInstance.peripheralDict.removeValue(forKey: keyDict)
//            }
//        }
//    }
    
    
    // MARK: Helper Methods
    func updateTable() {
        
        self.tableView.reloadData()
        
        
    }
    
    
    
    // MARK:  Prepare For Segue
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
    

}





