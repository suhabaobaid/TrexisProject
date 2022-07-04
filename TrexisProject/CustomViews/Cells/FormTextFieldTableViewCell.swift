//
//  FormTextFieldTableViewCell.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/3/22.
//

import UIKit

class FormTextFieldTableViewCell: UITableViewCell {
    
    // MARK: - UI
    private lazy var textField: Textfield = Textfield()
    
    // MARK: - Dependencies
    var formItem: FormItem?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(textField)
        
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Padding.small),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Padding.horizontal),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Padding.horizontal),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Padding.small),
            textField.heightAnchor.constraint(equalToConstant: Size.TextField.height)
        ])
    }
    
}

// MARK: - FormUpdatable
extension FormTextFieldTableViewCell: FormUpdatable {
    func update(with formItem: FormItem) {
        self.formItem = formItem
        
        textField.set(with: formItem)
        
        // FIXME: make sure the color changes
        let bgColor: UIColor = self.formItem?.isValid  == false ? Colors.TextField.errorBackground : Colors.TextField.background
        textField.layer.backgroundColor = bgColor.cgColor
    }
    
}
