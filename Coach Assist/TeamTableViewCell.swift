//
//  TeamTableViewCell.swift
//  Coach Assist
//
//  Created by Pavel Asparouhov on 8/11/16.
//  Copyright © 2016 BigP inc. All rights reserved.
//

import UIKit

class TeamTableViewCell: UITableViewCell {

    @IBOutlet weak var teamName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
