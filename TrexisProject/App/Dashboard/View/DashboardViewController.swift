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
            self.shouldShowEmptyView(accounts.count == 0)
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
            self.delegate?.didTapOnAccount(item)
        })
        
        view.addSubview(genericTable)
    }
    
    func shouldShowEmptyView(_ show: Bool) {
        if show {
            let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
            emptyLabel.text = "No Data"
            emptyLabel.textAlignment = NSTextAlignment.center
            self.genericTable.backgroundView = emptyLabel
        } else {
            self.genericTable.backgroundView = nil
        }
    }
    
    func fetchData() {
        let loadingIndicator = LoadingViewController()
        add(loadingIndicator)
        
        viewModel.getAccounts { [weak self] accounts in
            loadingIndicator.remove()
            self?.accounts = accounts
            
        }
    }
}
