//
//  ManageViewController.swift
//  Moonlight
//
//  Created by Khant Zaw Ko on 9/3/17.
//  Copyright © 2017 Khant Zaw Ko. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class ManageMenuController: UICollectionViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    var ref: DatabaseReference!
    var menuLists = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        ref = Database.database().reference().child("the-testing-one/menuList/")
        getMenuData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
    
    @objc func addTapped() {
        let alertController = UIAlertController(title: "New Menu", message: "Fill in the new menu you want to add.", preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "Menu - eg. Food, Drink!"
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: {
                alert -> Void in
                self.addNewMenu(menuTitle: textField.text!)
                self.collectionView?.reloadData()
            }))
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getMenuData() {
        ref = Database.database().reference().child("the-testing-one/menuList/")
        
        ref.observe(.childAdded, with: {(snapshot: DataSnapshot) in
            self.menuLists.append(snapshot.key)
            self.collectionView?.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func addNewMenu(menuTitle: String) {

//        let today = Date()
//        let formatter: DateFormatter = DateFormatter()
//        formatter.dateFormat = "MMM dd yyyy"
//        let date = formatter.string(from: today)
//        formatter.dateFormat = "hh:mm:ss +zzzz"
//        let time = formatter.string(from: today)
        
        ref.child(menuTitle).setValue(true)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuLists.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ManageMenuCell
        cell.frame.size.width = 162
        cell.frame.size.height = 162
        cell.menuTitle.text = menuLists[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMenuItem" {
            let vc: ManageItemController = segue.destination as! ManageItemController
            let indexPaths: [IndexPath] = (self.collectionView?.indexPathsForSelectedItems)!
            let indexPath : NSIndexPath = indexPaths[0] as NSIndexPath
            vc.menuTitle = menuLists[indexPath.row]
        }
    }
}
