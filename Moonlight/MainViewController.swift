//
//  MainViewController.swift
//  Moonlight
//
//  Created by Khant Zaw Ko on 8/3/17.
//  Copyright © 2017 Khant Zaw Ko. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

private let reuseIdentifier = "Cell"

class MainViewController: UICollectionViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var ref: DatabaseReference!
    
    var menuLists = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMenuTitle()
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
    
    func getMenuTitle() {
        ref = Database.database().reference().child("the-testing-one/menuList/")
        
        ref.observe(.childAdded, with: {(snapshot: DataSnapshot) in
            self.menuLists.append(snapshot.key)
            self.collectionView?.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuLists.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MenuCell
        cell.menuTitle.text = menuLists[indexPath.row]
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMenuItem" {
            let ivc: ItemViewController = segue.destination as! ItemViewController
            let indexPaths: [IndexPath] = (self.collectionView?.indexPathsForSelectedItems)!
            let indexPath : NSIndexPath = indexPaths[0] as NSIndexPath
            ivc.menuTitle = menuLists[indexPath.row]
        }
    }

}
