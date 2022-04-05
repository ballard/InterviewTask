//
//  ViewController.swift
//  Fit2
//
//  Created by ISLAZAREV on 05.04.2022.
//

import UIKit

final class ViewController: UIViewController {
    
    private lazy var tableView: UITableView = { [weak self] in
        guard let self = self else {
            fatalError()
        }
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UsersCell")
        return tableView
    }()

    private var presenter: Presenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
        assemble()
        loadData()
    }

    private func setupUI() {
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func assemble() {
        let adapter = Adapter(tableView: tableView)
        presenter = Presenter(adapter: adapter)
    }
    
    private func loadData() {
        presenter?.loadData()
    }

}
