//
//  MinimumAlertViewController.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/4/22.
//

import UIKit

class MinimumAlertViewController: UIViewController {

    // MARK: - UI
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#ffffff", alpha: 1)
        view.layer.cornerRadius = 10
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var icon: UIImageView
    var messageLabel: FootNoteLabel

    
    // MARK: - init
    init(message: String, icon: UIImage?, color: UIColor = Colors.successColor) {
        self.messageLabel = FootNoteLabel(bodyText: message, textColor: .white, textAlignment: .left)
        self.icon = UIImageView(image: icon)
        self.icon.tintColor = .white
        self.containerView.backgroundColor = color
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContainerView()
        configureIcon()
        configureBodyLabel()
    }
    
    func configureContainerView() {
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Padding.xsmall),
            containerView.widthAnchor.constraint(equalToConstant: view.bounds.width - 30)
        ])
        
        containerView.addSubview(icon)
        containerView.addSubview(messageLabel)
    }
    
    func configureIcon() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Padding.small),
            icon.centerYAnchor.constraint(equalTo: messageLabel.centerYAnchor),
            icon.heightAnchor.constraint(equalToConstant: 24),
            icon.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configureBodyLabel() {
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: Padding.small),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Padding.xsmall),
            messageLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Padding.small),
            messageLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Padding.small),
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }

}
