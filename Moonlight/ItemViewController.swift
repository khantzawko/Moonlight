//
//  ItemViewController.swift
//  Moonlight
//
//  Created by Khant Zaw Ko on 9/3/17.
//  Copyright © 2017 Khant Zaw Ko. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

private let reuseIdentifier = "Cell"

class ItemViewController: UICollectionViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var receiptItemTitleArray = [String]()
    var ref: FIRDatabaseReference!
    var itemLists = [String]()
    var itemPriceLists = [String]()
    var menuTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = menuTitle

        ref = FIRDatabase.database().reference().child("the-testing-one/itemList/\(menuTitle)")
        getItemData()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(doThisWhenNotify), name: NSNotification.Name(rawValue: myNotificationKey), object: nil)
        
        loadRevealViewController()
    }
    
//    func doThisWhenNotify() {
//        print("loaded")
//    }
    
    func loadRevealViewController() {
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.revealViewController().bounceBackOnOverdraw = true
        self.revealViewController().rightViewRevealWidth = 250
    }
    
    func getItemData() {
        ref.observe(.childAdded, with: {(snapshot: FIRDataSnapshot) in
            self.itemLists.append(snapshot.key)
            self.itemPriceLists.append(snapshot.childSnapshot(forPath: "price").value as! String)
            self.collectionView?.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemLists.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ItemCell
        cell.itemTitle.text = itemLists[indexPath.row]
        cell.itemPrice.text = itemPriceLists[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ItemCell
        NotificationCenter.default.post(name: Notification.Name(rawValue: myNotificationKey), object: self, userInfo: ["name": cell.itemTitle.text!, "price": cell.itemPrice.text!, "quantity": "1"])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



