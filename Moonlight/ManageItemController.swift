//
//  ManageItemViewController.swift
//  Moonlight
//
//  Created by Khant Zaw Ko on 10/3/17.
//  Copyright © 2017 Khant Zaw Ko. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

private let reuseIdentifier = "Cell"

class ManageItemController: UICollectionViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var menuTitle = String()
    var ref: DatabaseReference!
    var itemLists = [String]()
    var itemPriceLists = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.title = menuTitle
        ref = Database.database().reference().child("the-testing-one/itemList/\(menuTitle)")
        getItemData()
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
    
    func getItemData() {
        ref.observe(.childAdded, with: {(snapshot: DataSnapshot) in
            self.itemLists.append(snapshot.key)
            self.itemPriceLists.append(snapshot.childSnapshot(forPath: "price").value as! String)
            self.collectionView?.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    func addNewMenuItem(itemTitle: String, itemPrice: String) {
        let post = ["price":itemPrice]
        ref.child(itemTitle).setValue(post)
    }

    @objc func addTapped() {
        let alertController = UIAlertController(title: "New Item", message: "Fill in the new item you want to add.", preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: { (itemTextField) -> Void in
            itemTextField.placeholder = "Item - eg. Pepsi, Cola"
            
            alertController.addTextField(configurationHandler: { (priceTextField) -> Void in
                priceTextField.placeholder = "Price - 100, 200, 300"
                
                alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: {
                    alert -> Void in
                    self.addNewMenuItem(itemTitle: itemTextField.text!, itemPrice: priceTextField.text!)
                    self.collectionView?.reloadData()
                }))
            })
            
        })
        
        self.present(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return itemLists.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ManageItemCell
        //cell.backgroundColor = UIColor.orange
        cell.itemTitle.text = itemLists[indexPath.row]
        cell.itemPrice.text = itemPriceLists[indexPath.row] + " Ks"
        return cell
    }
}
