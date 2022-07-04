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
    
    func fetchData() {
        viewModel.getTransactions(forAccountID: account.id) { [weak self] transactions in
            self?.transactions = transactions
        }
    }

}
