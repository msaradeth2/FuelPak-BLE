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
//        btUtil.startScan()
        
        self.tableView.reloadData()
    }
    
    
    
    // WE REGISTER FOR SYSTEM NOTIFICATION (APP WILL RESIGN ACTIVE)
    
//    // Register without parameter
//    NotificationCenter.default.addObserver(self, selector: #selector(MyReceivingClass.handleNotification), name: .UIApplicationWillResignActive, object: nil)
//
//    // Register WITH parameter
//    NotificationCenter.default.addObserver(self, selector: #selector(MyReceivingClass.handle(withNotification:)), name: .UIApplicationWillResignActive, object: nil)

    
    func registerToReceiveNotification() {
        let notificationName = Notification.Name("NotificationIdentifier")
        
//        NotificationCenter.default.addObserver(self, selector: #selector(setToPeru(notification:)), name: .peru, object: nil)
        
//        NotificationCenter.default.addObserver(self, selector: Selector, name: notificationName, object: nil)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(didDiscoverPeripheral(sender:)), name: notificationName, object: nil)
        
        // Register to receive notification
//        NotificationCenter.default.addObserver(self, selector: #selector(self.didDiscoverPeripheral(withNotification:)), name: notificationName, object: nil)
        
        
//        NotificationCenter.default.addObserver(self, selector: (didDiscoverPeripheral:), name: notificationName, object: nil)
//        NotificationCenter.default.addObserver(<#T##observer: Any##Any#>, selector: <#T##Selector#>, name: <#T##NSNotification.Name?#>, object: <#T##Any?#>)
    }
//    func setToPeru(notification: NSNotification) {
    
//    func didDiscoverPeripheral(notification: NSNotification) {
//
//    }
    
//    #pragma mark - Start/Remove Observers
//
//    - (void) startObservers
//    {
//    //Start notification observers
//    [[NSNotificationCenter defaultCenter] addObserver:self
//    selector:@selector(enableSwipe:)
//    name:[Constant shared].enableSwipeNotification
//    object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//    selector:@selector(disableSwipe:)
//    name:[Constant shared].disableSwipeNotification
//    object:nil];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//    selector:@selector(showAutotuneToturial:)
//    name:[Constant shared].showAutotuneToturialNotification
//    object:nil];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//    selector:@selector(autotuneOutTransferIn:)
//    name:[Constant shared].autotuneOutTransferInNotification
//    object:nil];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//    selector:@selector(evt_pageControlButtonPressed:)
//    name:[Constant shared].pageControlEventNotification
//    object:nil];
//
//    }
//
//
//
//    - (void) removeObservers
//    {
//    //Remove observers
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:[Constant shared].disableSwipeNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:[Constant shared].enableSwipeNotification object:nil];
//
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:[Constant shared].autotuneOutTransferInNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:[Constant shared].showAutotuneToturialNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:[Constant shared].pageControlEventNotification object:nil];
//    }
//
//
//
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
        
        
//        PeripheralsStructure peripheralsStructure = self.btUtil.peripheralDict[indexPath.row];

        
//        [self.defaultBTServer readValue:ch];
//        [ProgressHUD show:@"reading characteristic"];
        
        
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
