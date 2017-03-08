//
//  MenuViewController.swift
//  Moonlight
//
//  Created by Khant Zaw Ko on 9/3/17.
//  Copyright © 2017 Khant Zaw Ko. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
    
    var menus = ["DASHBOARD", "MANAGE", "REPORTS", "PROFILE", "ABOUT"]
    var menusLabels = [UILabel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menus.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = self.tableView.cellForRow(at: indexPath)
        let selectedMenuLabel = selectedCell?.viewWithTag(10) as! UILabel
        
        for cell in tableView.visibleCells {
            let menuLabel = cell.viewWithTag(10) as! UILabel
            menusLabels.append(menuLabel)
        }
        
        for index in 0..<menus.count {
            menusLabels[index].text = menus[index]
        }
        
        selectedMenuLabel.text = "● " + menus[indexPath.row]
    }
}

