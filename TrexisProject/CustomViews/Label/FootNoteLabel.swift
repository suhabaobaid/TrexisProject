//
//  FootNoteLabel.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/4/22.
//

import UIKit

class FootNoteLabel: UILabel {

    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(bodyText: String, textColor: UIColor = .label, textAlignment: NSTextAlignment = .left) {
        self.init(frame: .zero)
        configure()
        text = bodyText
        self.textColor = textColor
        self.textAlignment = textAlignment
    }
    
    private func configure() {
        font = UIFont.preferredFont(forTextStyle: .footnote)
        textAlignment = .left
        numberOfLines = 0
        textColor = .darkGray
        
        translatesAutoresizingMaskIntoConstraints = false
    }

}
