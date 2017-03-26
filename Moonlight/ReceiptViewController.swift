//
//  ReceiptViewController.swift
//  Moonlight
//
//  Created by Khant Zaw Ko on 11/3/17.
//  Copyright © 2017 Khant Zaw Ko. All rights reserved.
//

import UIKit
import CoreBluetooth

class ReceiptViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkOutButton: UIButton!
    
    var itemTitles = [[String](), ["Sub Total", "Service Charge 10%", "Vat 7%"]]
    var itemPrices = [[String](), ["0", "0", "0"]]
    var itemQuantities = [[String](), ["", "", ""]]
    var headerTitle = ["items", "tax incl"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: myNotificationKey),
                                               object: nil,
                                               queue: nil,
                                               using:catchNotification)
    }
    
    func catchNotification(notification:Notification) -> Void {
        guard let name = notification.userInfo!["name"] else { return }
        guard let price = notification.userInfo!["price"] else { return }
        guard let quantity = notification.userInfo!["quantity"] else { return }
        
        receiptCalculation(selectedTitle: name as! String, selectedPrice: price as! String, selectedQuantity: quantity as! String)
    }
    
    func receiptCalculation(selectedTitle: String, selectedPrice: String, selectedQuantity: String) {
        
        var total: Int = 0
        var subTotal: Int = 0
        var isItemExist: Bool = false
        let firstSection = 0
        let lastSection = 1
        
        // ---> first section
        
        if itemTitles[firstSection].count != 0 {
            for x in 0 ..< itemTitles[firstSection].count {
                if selectedTitle == itemTitles[firstSection][x] {
                    itemQuantities[firstSection][x] = String(Int(itemQuantities[firstSection][x])! + 1)
                    itemPrices[firstSection][x] = String(Int(itemPrices[firstSection][x])! + Int(selectedPrice)!)
                    isItemExist = true
                } else {


                }
            }

            if !isItemExist {
                itemTitles[firstSection].append(selectedTitle)
                itemPrices[firstSection].append(selectedPrice)
                itemQuantities[firstSection].append(selectedQuantity)
            }

        } else {
            itemTitles[firstSection].append(selectedTitle)
            itemPrices[firstSection].append(selectedPrice)
            itemQuantities[firstSection].append(selectedQuantity)
        }
        
        for price in itemPrices[firstSection] {
            subTotal += Int(price)!
        }
        
        print(subTotal)
        print(itemTitles)
        
        // ---> last section

        if itemTitles[lastSection].count != 0 {
            itemPrices[lastSection][0] = String(subTotal)
            itemPrices[lastSection][1] = String(Int(Double(subTotal) * 0.1))
            itemPrices[lastSection][2] = String(Int(Double(subTotal) * 0.07))
        }
        
        for price in itemPrices[lastSection] {
            total += Int(price)!
        }

        checkOutButton.setTitle("Total: " + String(total) + " Ks", for: .normal)
        tableView.reloadData()
    }
    
    @IBAction func pressedCheckOut(_ sender: Any) {
        print("checkout")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemTitles[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return itemTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitle[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ReceiptItemCell
        cell.menuItemTitle.text = itemTitles[indexPath.section][indexPath.row]
        cell.menuItemPrice.text = itemPrices[indexPath.section][indexPath.row] + " Ks"
        cell.menuItemQuantity.text = itemQuantities[indexPath.section][indexPath.row]
        return cell
    }
}
