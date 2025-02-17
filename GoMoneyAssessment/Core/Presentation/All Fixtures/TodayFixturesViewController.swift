//
//  TodayFixturesViewController.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 12/02/2025.
//

import UIKit

class TodayFixturesViewController: BaseViewController {
    let viewModel: TodayFixturesViewModel = TodayFixturesViewModel()
    var matches: [Match] = []
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.separatorColor = .lightGray
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Today's Fixtures"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MatchTableViewCell.self, forCellReuseIdentifier: "MatchCell")
        
        setupConstraints()
        showLoader()
        
        viewModel.onFetchMatches = { [weak self] matches in
            self?.matches = matches
            self?.tableView.reloadData()
            self?.hideLoader()
        }
        
        viewModel.onErrorOccured = { [weak self] error in
            self?.hideLoader()
            self?.showErrorAlert(message: error.message) {
                self?.showLoader()
                self?.viewModel.fetchTodaysMatches()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchTodaysMatches()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension TodayFixturesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCell", for: indexPath) as? MatchTableViewCell else {
            return UITableViewCell()
        }
        let match = matches[indexPath.row]
        cell.configure(match: match)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
