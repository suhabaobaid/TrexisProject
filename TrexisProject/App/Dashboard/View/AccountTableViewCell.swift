//
//  AccountTableViewCell.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/4/22.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(withAccount account: Account) {
        var config = self.defaultContentConfiguration()
        config.text = "Name: \(account.name)"
        config.secondaryText = "Balance: \(account.balance)"

        self.contentConfiguration = config
        self.accessoryType = .disclosureIndicator
    }

}
