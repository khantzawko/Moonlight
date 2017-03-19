//
//  ReceiptViewController.swift
//  Moonlight
//
//  Created by Khant Zaw Ko on 11/3/17.
//  Copyright © 2017 Khant Zaw Ko. All rights reserved.
//

import UIKit
import CoreBluetooth

class ReceiptViewController: UIViewController, ItemViewControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var itemTitles = ["Please selete one"]
    var itemPrices = ["10000"]
    var itemQuantity = ["1"]
    
    let controller = ItemViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        controller.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ReceiptItemCell
        cell.menuItemTitle.text = itemTitles[indexPath.row]
        cell.menuItemPrice.text = itemPrices[indexPath.row] + " Ks"
        cell.menuItemQuantity.text = itemQuantity[indexPath.row]
        return cell
    }
    
    func didSelectItem(controller: ItemViewController, itemData: String) {
        print("recieve data ->", itemData)
    }
}
