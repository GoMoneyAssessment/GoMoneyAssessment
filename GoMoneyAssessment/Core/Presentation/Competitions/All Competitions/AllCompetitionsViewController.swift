//
//  AllCompetitionsViewController.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 12/02/2025.
//

import UIKit

class AllCompetitionsViewController: UIViewController {
    
    let viewModel: AllCompetitionsViewModel = AllCompetitionsViewModel()
    var competitions: [Competition] = []
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
        
        view.backgroundColor = .white
        navigationItem.title = "Competitions"
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CompetitionsCell")
        
        setupConstraints()
        
        viewModel.onFetchCompetitions = { [weak self] comps in
            self?.competitions = comps
            self?.tableView.reloadData()
        }
        viewModel.fetchCompetitions()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension AllCompetitionsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return competitions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompetitionsCell", for: indexPath)
        let competition = competitions[indexPath.row]
        let compName = competition.name
        let startYear = competition.currentSeason?.startDate?.getdateFromShortDateString().getYearCompFromDate()
        let endYear = (competition.currentSeason?.endDate?.getdateFromShortDateString().getYearCompFromDate() ?? 100) % 100
        let wholeTitle = "\(compName ?? "") \(startYear ?? 0)/\(endYear)"
        cell.textLabel?.text = wholeTitle
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let competition = competitions[indexPath.row]
        let compName = competition.name
        let startYear = competition.currentSeason?.startDate?.getdateFromShortDateString().getYearCompFromDate()
        let endYear = (competition.currentSeason?.endDate?.getdateFromShortDateString().getYearCompFromDate() ?? 100) % 100
        let wholeTitle = "\(compName ?? "") \(startYear ?? 0)/\(endYear)"
        let selectCompVC = SelectCompetitionViewController()
        selectCompVC.selectedCompetition = competition
        selectCompVC.selectCompTitle = wholeTitle
        selectCompVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(selectCompVC, animated: true)
    }
}
