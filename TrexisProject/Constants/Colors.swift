//
//  Colors.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/3/22.
//

import Foundation
import UIKit

enum Colors {
    static let primaryColor = UIColor.systemMint
    static let cautionColor = UIColor.systemOrange
    static let errorColor = UIColor.systemRed
    static let successColor = UIColor.systemGreen
    static let infoColor = UIColor.systemBlue
    enum TextField {
        static let background = UIColor(hexString: "#000000", alpha: 0.1)
        static let errorBackground: UIColor = .red.withAlphaComponent(0.66)
        static let opacity = 0.25
        static let textColor: UIColor = .darkText
    }
    enum Button {
        static let background = Colors.primaryColor
    }
}
