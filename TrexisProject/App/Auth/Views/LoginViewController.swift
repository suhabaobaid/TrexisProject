//
//  LoginViewController.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/3/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - UI
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    lazy var authenticateButton = PrimaryButton(title: "", textColor: .white, backgroundColor: Colors.Button.background)
    
    // MARK: - Dependencies
    fileprivate var form: Form
    weak var delegate: AuthenticateDelegate?
    
    init(form: Form) {
        self.form = form
        super.init(nibName: nil, bundle: nil)
        self.authenticateButton.setTitle(form.authenticateButtonTitle, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
        configureButtons()
    }
    
    // MARK: - Configure
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        self.title = form.title
    }
    
    private func configureTableView() {
        //Prepare tableView
        FormItemCellType.registerCells(for: self.tableView)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self
        
        addSubviews([tableView])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Padding.medium),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureButtons() {
        addSubviews([authenticateButton])
        
        NSLayoutConstraint.activate([
            authenticateButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -Padding.xsmall),
            authenticateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.horizontal),
            authenticateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Padding.horizontal),
        ])
        
        authenticateButton.addTarget(self, action: #selector(didTapValidate(_:)), for: .touchUpInside)
    }
    
    
    @objc func didTapValidate(_ sender: Any) {
        // we can use the string as a reason if needed to display a message
        let (isFormValid, _) = form.isValid()
        
        if isFormValid {
            delegate?.authenticateUser()
        } else {
            tableView.reloadData()
        }
    }
    
}

// MARK: - UITableViewDataSource
extension LoginViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.form.formItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.form.formItems[indexPath.row]
        let cell: UITableViewCell
        if let cellType = self.form.formItems[indexPath.row].uiProperties.cellType {
            cell = cellType.dequeueCell(for: tableView, at: indexPath)
        } else {
            cell = UITableViewCell() //or anything you want
        }
        
        if let formUpdatableCell = cell as? FormUpdatable {
            item.indexPath = indexPath
            formUpdatableCell.update(with: item)
        }
        
        return cell
    }
}
