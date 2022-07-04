//
//  TransactionTableViewCell.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/4/22.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(withTransaction transaction: Transaction) {
        var config = self.defaultContentConfiguration()
        config.text = "Title: \(transaction.title)"
        config.secondaryText = "Balance: \(transaction.balance)"

        self.contentConfiguration = config
    }

}
