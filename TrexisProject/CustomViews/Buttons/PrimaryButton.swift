//
//  PrimaryButton.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/3/22.
//

import UIKit

class PrimaryButton: UIButton {
    
    var title: String

    override init(frame: CGRect) {
        self.title = ""
        super.init(frame: frame)
        configure(title: "", textColor: Colors.primaryColor, backgroundColor: Colors.Button.background, isEnabled: true)
    }
    
    convenience init(title: String, textColor: UIColor, backgroundColor: UIColor, isEnabled: Bool = true) {
        self.init(frame: .zero)
        self.title = title
        configure(title: title, textColor: textColor, backgroundColor: backgroundColor, isEnabled: isEnabled)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(title: String, textColor: UIColor, backgroundColor: UIColor, isEnabled: Bool) {
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.baseBackgroundColor = backgroundColor
        configuration.baseForegroundColor = textColor
        configuration.cornerStyle = .capsule
        configuration.buttonSize = .large
        self.configuration = configuration

        self.isEnabled = isEnabled
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setEnable() {
        isEnabled = true
    }
    
    func showActivityIndicator() {
        self.configuration?.title = ""
        self.configuration?.showsActivityIndicator = true
    }
    
    func removeActivityIndicator() {
        DispatchQueue.main.async {
            self.configuration?.title = self.title
            self.configuration?.showsActivityIndicator = false
        }
        
    }
}
