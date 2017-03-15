//
//  ReceiptViewController.swift
//  Moonlight
//
//  Created by Khant Zaw Ko on 11/3/17.
//  Copyright © 2017 Khant Zaw Ko. All rights reserved.
//

import UIKit

class ReceiptViewController: UITableViewController, ItemViewDelegate {
    
    var itemArray = ["testing 1","testing 2"]
    let itemViewController = ItemViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        itemArray.append("what")
        self.itemViewController.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ReceiptItemCell
        cell.receiptTitle.text = itemArray[indexPath.row]
        return cell
    }
    
    func sendData(itemTitleArray: [String]) {
        if (tableView) != nil {
            itemArray = itemTitleArray
            self.tableView.reloadData()
            print("recieve data ->", itemArray)
        }
    }
}

