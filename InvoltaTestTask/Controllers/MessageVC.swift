//
//  ViewController.swift
//  InvoltaTestTask
//
//  Created by Vadim Voronkov on 06.05.2022.
//

import UIKit
import SnapKit

class MessageVC: UIViewController {
    
    //MARK: - Properties
    
    private var offset = 20
    
    //MARK: - Views
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: MessageTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        return tableView
    }()
    
    private var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .gray
        return indicator
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Networking.FetchData(offset: 0) { success in
            switch success {
            case false:
                self.checkСonnection()
            case true:
                self.indicatorView.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupLayout()
    }
    
    //MARK: - Methods
    
    private func setupLayout() {
        self.setupTableView()
        self.setupIndicator()
        self.setupView()
    }
    
    private func setupTableView() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.bottom.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupIndicator() {
        self.view.addSubview(self.indicatorView)
        self.indicatorView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.indicatorView.startAnimating()
    }
    
    private func checkСonnection() {
        if Messages.shared.messages.isEmpty {
            let alert = UIAlertController(title: "Error", message: "Check your internet connection!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try again", style: .cancel, handler: { [weak self] alert in
                self?.indicatorView.startAnimating()
                Networking.FetchData(offset: 0) { success in
                    if success == true {
                        self?.tableView.reloadData()
                        self?.indicatorView.stopAnimating()
                    } else {
                        self?.checkСonnection()
                    }
                }
            }))
            self.present(alert, animated: true)
        }
    }
    
}

extension MessageVC: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Messages.shared.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.identifier, for: indexPath) as? MessageTableViewCell else  { return UITableViewCell() }
        cell.configureTableViewCell(label: Messages.shared.messages[indexPath.row])
        cell.backgroundColor = UIColor(red: 179/255, green: 179/255, blue: 179/255, alpha: 1)
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.transform = tableView.transform
        
         return cell
    }
    
    //MARK: - TableView Delegate
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        Networking.FetchData(offset: offset) { success in
            if success == true {
                self.offset += 20
            }
        }
        self.tableView.reloadData()
    }
    
}

//end

