//
//  TextTableViewCell.swift
//  FocusStartAleshkov
//
//  Created by andrey on 10.02.17.
//  Copyright © 2017 andrey. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
