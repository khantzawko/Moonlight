//
//  ReportViewController.swift
//  Moonlight
//
//  Created by Khant Zaw Ko on 9/3/17.
//  Copyright © 2017 Khant Zaw Ko. All rights reserved.
//

import UIKit

class ReportViewController: UITableViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRevealViewController()
    }
    
    func loadRevealViewController() {
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.revealViewController().bounceBackOnOverdraw = true
        self.revealViewController().rightViewRevealWidth = 250
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}
