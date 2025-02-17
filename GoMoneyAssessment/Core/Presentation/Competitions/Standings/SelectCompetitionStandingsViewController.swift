//
//  SelectCompetitionStandingsViewController.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 13/02/2025.
//

import UIKit

class SelectCompetitionStandingsViewController: BaseViewController {
    let viewModel: SelectCompetitionStandingsViewModel = SelectCompetitionStandingsViewModel()
    var competitionCode: String
    var standings: [Standing] = []
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        return tableView
    }()
    
    init(competitionCode: String) {
        self.competitionCode = competitionCode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        showLoader()
        
        viewModel.competitionCode = competitionCode
        viewModel.onStandingsFetched = { [weak self] standings in
            guard let self else { return }
            self.standings = standings
            tableView.reloadData()
            hideLoader()
        }
        viewModel.onErrorOccured = { [weak self] error in
            self?.hideLoader()
            self?.showErrorAlert(message: error.message) {
                self?.showLoader()
                self?.viewModel.fetchStandings()
            }
        }
        
        tableView.register(StandingsTableViewCell.self, forCellReuseIdentifier: "StandingsTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        viewModel.fetchStandings()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension SelectCompetitionStandingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        standings.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        standings[section].table?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        standings[section].group
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StandingsTableViewCell", for: indexPath) as? StandingsTableViewCell else { return UITableViewCell() }
        if let standing = standings[indexPath.section].table?[indexPath.row] {
            cell.configure(standing: standing)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
