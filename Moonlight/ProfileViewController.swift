//
//  ProfileViewController.swift
//  Moonlight
//
//  Created by Khant Zaw Ko on 9/3/17.
//  Copyright © 2017 Khant Zaw Ko. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

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

}
