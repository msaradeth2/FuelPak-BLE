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
    
    // MARK:  Define Variables
    enum CommandCode {
        case UVIN00
        case UDEV00
        case UECM00
        case ALL

    }
    
    
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
    private var listOfItems = [String: String]()
    private var listOfTitle: [String] = []
    private var listOfItemsSection_0: [String] = []
    private var cmdResponseCounter = 0
    private var caller: String = "SystemInfoViewController"
    private var timeoutCounter = 0
    
    
    
    // MARK: - Default Methods
    override func viewDidLoad() {
        addObservers()
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
    
    
    // MARK: Initialize Data
    func initData() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
    
        
        
        //Title
        listOfTitle.append("VIN")
        listOfTitle.append("ECU Version")
        listOfTitle.append("ECU Calibration ID")
        listOfTitle.append("Fuelpak State")
        listOfTitle.append("Fuelpak Firmware Version")
        listOfTitle.append("Fuelpak Hardware Version")
        listOfTitle.append("Wideband State")
        listOfTitle.append("Wideband Firmware Version")
        listOfTitle.append("Wideband Hardware Version")
        listOfTitle.append("iOS Version")
        listOfTitle.append("App Build Version")
        listOfTitle.append("Bluetooth Version")
        listOfTitle.append("Bluetooth MAC Address")
        listOfTitle.append("Model")
        listOfTitle.append("Year")

        
        updateTable()
        
    }
    
    
    
    // MARK: Events Methods
    
    @IBAction func evtBackButton(_ sender: Any) {
        print("evtBackButton")
        if !Bike.sharedInstance.isDemoMode() {
            BluetoothUtil.sharedInstance.cancelConnect()
        }
        
        self.dismiss(animated: false, completion: exitViewController)
    }
    
    @IBAction func evtRefreshButton(_ sender: Any) {
        print("evtRefreshButton")
        
        resetCounter()
        sendCommand(cmdNum: 0)  //Send DEV command

    }
    
    

    
    // MARK: - TableView Delegation methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return listOfTitle.count
        
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

        return Bike.sharedInstance.getBtStatusStr()
    }
    


    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
        
        cell.textLabel?.text = listOfTitle[indexPath.row]
        cell.detailTextLabel?.text = listOfItems[listOfTitle[indexPath.row]]
//        cell.detailTextLabel?.text = "detailTextLabel"
        

        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    // MARK:  Send Commands
    func sendCommand(cmdNum: Int) {
        switch cmdNum {
        case 0:
            sendCommand(cmdCode: .UDEV00)
            
        case 1:
            sendCommand(cmdCode: .UVIN00)
            
        case 2:
           sendCommand(cmdCode: .UECM00)
            
        default:
            break
        }
        
    }
    
    
    // MARK:  Send Commands
    func sendCommand(cmdCode: CommandCode) {

        switch cmdCode {
        case .UDEV00:
            BluetoothUtil.sharedInstance.write(cmd: "UDEV00", timeoutInSeconds: 1, notificationName: Constants.devCommandNotification, caller: Constants.systemInfoViewController)
            
        case .UVIN00:
            BluetoothUtil.sharedInstance.write(cmd: "UVIN00", timeoutInSeconds: 1, notificationName: Constants.vinCommandNotification, caller: Constants.systemInfoViewController)

        case .UECM00:
            BluetoothUtil.sharedInstance.write(cmd: "UECM00", timeoutInSeconds: 1, notificationName: Constants.ecmCommandNotification, caller: Constants.systemInfoViewController)
            
        case .ALL:
            sendCommand(cmdCode: .UVIN00)
            sendCommand(cmdCode: .UECM00)
            sendCommand(cmdCode: .UDEV00)
        }
        
    }
    

    

    // MARK:  Add/Remove Notification Observers.  Notification Delegation Methods
    func addObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationCallback(notification:)), name: .devCommandNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notificationCallback(notification:)), name: .vinCommandNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notificationCallback(notification:)), name: .ecmCommandNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(sendAllCommands(notification:)), name: .didDiscoverCharacteristicsNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI(notification:)), name: .didConnectPeripheralNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI(notification:)), name: .didDisconnectPeripheralNotification, object: nil)
        
    }
    
    func removeObservers() {
        
        NotificationCenter.default.removeObserver(self, name: .devCommandNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: .vinCommandNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: .ecmCommandNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: .didDiscoverCharacteristicsNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: .didConnectPeripheralNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: .didDisconnectPeripheralNotification, object: nil)
        
    }
    
    


    @objc func sendAllCommands(notification: NSNotification) {

        resetCounter()
        sendCommand(cmdNum: 0)  //send the first command
    }
    
    @objc func updateUI(notification: NSNotification) {
        
        switch Bike.sharedInstance.btStatus {
        case .Connected:
            self.tableView.reloadData()
            
        case .NotConnected:
            self.tableView.reloadData()
            
        default:
            break
        }
        
    }
    
    
    // MARK: Notification Callback - process response
    
    
    @objc func notificationCallback(notification: NSNotification) {
        
        print("Mike notificationCallback:", cmdResponseCounter)
        if handledTimeout(notification: notification) {
            //If time out - No UI update
            timeoutCounter = timeoutCounter + 1
            if timeoutCounter < 3 {
                sendCommand(cmdNum: cmdResponseCounter) //Resend command
            }
            return
        }
        
        if cmdResponseCounter < 2 {
            cmdResponseCounter = cmdResponseCounter + 1
            timeoutCounter = 0
            sendCommand(cmdNum: cmdResponseCounter)
        }
        
        updateUI()
        
    }
    
    
    func updateUI() {
        
        //Update UI
        listOfItems.removeAll()
        
        listOfItems[listOfTitle[0]] = Bike.sharedInstance.VINnumber
        listOfItems[listOfTitle[1]] = Bike.sharedInstance.ECMversion
        listOfItems[listOfTitle[2]] = Bike.sharedInstance.ECMcalib
        listOfItems[listOfTitle[3]] = Bike.sharedInstance.deviceStatus
        listOfItems[listOfTitle[4]] = Bike.sharedInstance.firmwareVersion
        listOfItems[listOfTitle[5]] = Bike.sharedInstance.hardwareVersion
        listOfItems[listOfTitle[6]] = Bike.sharedInstance.widebandState
        listOfItems[listOfTitle[7]] = Bike.sharedInstance.widebandfversion
        listOfItems[listOfTitle[8]] = Bike.sharedInstance.widebandhversion
        listOfItems[listOfTitle[9]] = Bike.sharedInstance.iosVersion
        listOfItems[listOfTitle[10]] = Bike.sharedInstance.appVersion
        listOfItems[listOfTitle[11]] = Bike.sharedInstance.appBuildVersion
        listOfItems[listOfTitle[12]] = Bike.sharedInstance.DEVbtversion
        listOfItems[listOfTitle[13]] = Bike.sharedInstance.DEVbtmacid
        listOfItems[listOfTitle[14]] = Bike.sharedInstance.VINyear
        
        tableView.reloadData()
    }
    
    
    func handledTimeout(notification: NSNotification) -> Bool {
        var cmdInfo: CmdInfo
        var timedout: Bool = false
        
        guard let notificationObject = notification.object else { return false} //No time out if return false
        cmdInfo = notificationObject as! CmdInfo
        
        
        if cmdInfo.cmdStatus == Constants.timedOut && cmdInfo.caller == Constants.systemInfoViewController {
            
            switch cmdInfo.cmdCode {
            case .UDEV00:
                print("Timed Out:", cmdInfo.cmd, cmdInfo.startTime, cmdInfo.endTime, cmdInfo.timedoutAt)
                timedout = true
                
            case .UVIN00:
                print("Timed Out:", cmdInfo.cmd, cmdInfo.startTime, cmdInfo.endTime, cmdInfo.timedoutAt)
                timedout = true
                
            case .UECM00:
                print("Timed Out:", cmdInfo.cmd, cmdInfo.startTime, cmdInfo.endTime, cmdInfo.timedoutAt)
                timedout = true

            default:
                break
            }
        }
        
        return timedout

    }
    
    
    // MARK: Helper Methods
    
    func exitViewController() {
        print("exitViewController")
    }
    
    func resetCounter() {
        timeoutCounter = 0
        cmdResponseCounter = 0
    }
    
    func updateTable() {
        
        self.tableView.reloadData()
        
        
    }
    
}



