//
//  Textfield.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/3/22.
//

import UIKit

class Textfield: UITextField {

    // MARK: - Private properties
    private var textPadding = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    private var formItem: FormItem?
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        // FIXME: Might need to remove the editing didChange
        addTarget(self, action: #selector(updateValue), for: .editingDidEnd)
        addTarget(self, action: #selector(updateValue), for: .editingChanged)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(with formItem: FormItem) {
        self.formItem = formItem
        
        self.text = self.formItem?.value
        
        self.layer.cornerRadius = 18
        
        self.keyboardType = self.formItem?.uiProperties.keyboardType ?? .default
        self.tintColor = self.formItem?.uiProperties.tintColor
        self.attributedPlaceholder = NSAttributedString(string: formItem.placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor(hexString: Colors.TextField.textColor.toHexString(), alpha: 0.5), .font: Fonts.body])
        isSecureTextEntry = formItem.uiProperties.isSecureText
        returnKeyType = formItem.uiProperties.returnKeyType
        autocapitalizationType = .none
    }
    
}

// MARK: - Display Rect functions
extension Textfield {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}

// MARK: - FormItem
extension Textfield {
    @objc func updateValue() {
        self.formItem?.valueCompletion?(text)
    }
}
