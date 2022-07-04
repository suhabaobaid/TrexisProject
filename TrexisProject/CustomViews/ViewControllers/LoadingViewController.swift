//
//  LoadingViewController.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/3/22.
//

import UIKit

class LoadingViewController: UIViewController {
    
    private lazy var activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.startAnimating()
    }

}
