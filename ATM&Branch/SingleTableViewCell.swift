//
//  SingleTableViewCell.swift
//  ATM&Branch
//
//  Created by sunny on 10/23/16.
//  Copyright © 2016 sunny. All rights reserved.
//

import UIKit

class SingleTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var detaiLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
