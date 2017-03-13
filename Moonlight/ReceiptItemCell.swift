//
//  ReceiptItemTitleCell.swift
//  Moonlight
//
//  Created by Khant Zaw Ko on 11/3/17.
//  Copyright © 2017 Khant Zaw Ko. All rights reserved.
//

import UIKit

class ReceiptItemCell: UITableViewCell {

    @IBOutlet weak var receiptTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
