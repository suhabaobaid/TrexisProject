//
//  TransactionViewController.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/4/22.
//

import UIKit

class TransactionViewController: UIViewController {

    // MARK: - UI
    var genericTable: GenericTableViewController<Transaction, TransactionTableViewCell>!
    
    // MARK: - Properties
    var viewModel: TransactionAbledViewModel
    var account: Account
    var transactions: [Transaction] = [] {
        didSet {
            self.genericTable.reload(data: transactions)
            self.shouldShowEmptyView(transactions.count == 0)
        }
    }
    
    init(title: String, account: Account, viewModel: TransactionAbledViewModel) {
        self.viewModel = viewModel
        self.account = account
        super.init(nibName: nil, bundle: nil)
        self.title = title
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
        genericTable = GenericTableViewController(frame: view.bounds, items: transactions, config: { item, cell in
            cell.set(withTransaction: item)
        }, selectHandler: { item in
            print(item)
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
        
        viewModel.getTransactions(forAccountID: account.id) { [weak self] transactions in
            loadingIndicator.remove()
            self?.transactions = transactions
        }
    }

}
