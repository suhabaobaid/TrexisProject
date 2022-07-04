//
//  DashboardViewController.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/4/22.
//

import UIKit

class DashboardViewController: UIViewController {

    // MARK: - UI
    var genericTable: GenericTableViewController<Account, AccountTableViewCell>!
    
    // MARK: - Properties
    var viewModel: DashboardViewModel
    weak var delegate: DashboardDelegate?
    var accounts: [Account] = [] {
        didSet {
            self.genericTable.reload(data: accounts)
        }
    }
    
    init(title: String, viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    deinit {
        print("Deinit: DashboardViewController")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureTableView()
        fetchData()
    }

    // MARK: - Config
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureTableView() {
        genericTable = GenericTableViewController(frame: view.bounds, items: accounts, config: { item, cell in
            cell.set(withAccount: item)
        }, selectHandler: { item in
            print(self.delegate)
            self.delegate?.didTapOnAccount(item)
        })
        
        view.addSubview(genericTable)
    }
    
    func fetchData() {
        viewModel.getAccounts { [weak self] accounts in
            self?.accounts = accounts
        }
    }
}
