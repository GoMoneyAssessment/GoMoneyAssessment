//
//  SelectCompetitionFixturesViewController.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 13/02/2025.
//

import UIKit

class SelectCompetitionFixturesViewController: BaseViewController {
    
    let viewModel: SelectCompetitionFixturesViewModel = SelectCompetitionFixturesViewModel()
    var competitionCode: String
    var fixtures: [Match] = []
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.separatorColor = .lightGray
        return tableView
    }()
    
    private let noFixturesContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
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
        setupNoFixturesView()
        noFixturesContainer.isHidden = true
        tableView.isHidden = true
        showLoader()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MatchTableViewCell.self, forCellReuseIdentifier: "MatchCell")
        
        viewModel.competitionCode = competitionCode
        viewModel.onFixturesFetched = { [weak self] fixtures in
            guard let self else { return }
            self.fixtures = fixtures
            tableView.reloadData()
            hideLoader()
            if fixtures.isEmpty {
                noFixturesContainer.isHidden = false
                tableView.isHidden = true
            } else {
                noFixturesContainer.isHidden = true
                tableView.isHidden = false
            }
        }
        viewModel.onErrorOccured = { [weak self] error in
            self?.hideLoader()
            self?.showErrorAlert(message: error.message) {
                self?.showLoader()
                self?.viewModel.fetchFixtures()
            }
        }
        viewModel.fetchFixtures()
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
    
    private func setupNoFixturesView() {
        view.addSubview(noFixturesContainer)
        
        let ballImage = UIImageView(image: UIImage(named: "ball")?.withRenderingMode(.alwaysTemplate))
        ballImage.tintColor = .gray
        ballImage.translatesAutoresizingMaskIntoConstraints = false
        noFixturesContainer.addSubview(ballImage)
        
        let messagelabel = UILabel()
        messagelabel.text = "No Fixtures"
        messagelabel.font = .systemFont(ofSize: 12)
        messagelabel.translatesAutoresizingMaskIntoConstraints = false
        noFixturesContainer.addSubview(messagelabel)
        
        let retryBtn = UIButton()
        retryBtn.setTitle("Retry", for: .normal)
        retryBtn.backgroundColor = .lightGray.withAlphaComponent(0.5)
        retryBtn.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        retryBtn.setTitleColor(.darkGray, for: .normal)
        retryBtn.layer.cornerRadius = 5
        retryBtn.addTarget(self, action: #selector(fetchFixtures), for: .touchUpInside)
        retryBtn.translatesAutoresizingMaskIntoConstraints = false;
        noFixturesContainer.addSubview(retryBtn)
        
        NSLayoutConstraint.activate([
            noFixturesContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noFixturesContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noFixturesContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            ballImage.topAnchor.constraint(equalTo: noFixturesContainer.topAnchor),
            ballImage.widthAnchor.constraint(equalToConstant: 100),
            ballImage.heightAnchor.constraint(equalToConstant: 100),
            ballImage.centerXAnchor.constraint(equalTo: noFixturesContainer.centerXAnchor),
            
            messagelabel.topAnchor.constraint(equalTo: ballImage.bottomAnchor, constant: 30),
            messagelabel.centerXAnchor.constraint(equalTo: noFixturesContainer.centerXAnchor),
            
            retryBtn.topAnchor.constraint(equalTo: messagelabel.bottomAnchor, constant: 20),
            retryBtn.widthAnchor.constraint(equalToConstant: 150),
            retryBtn.heightAnchor.constraint(equalToConstant: 48),
            retryBtn.centerXAnchor.constraint(equalTo: noFixturesContainer.centerXAnchor),
            retryBtn.bottomAnchor.constraint(equalTo: noFixturesContainer.bottomAnchor)
        ])
    }
    
    @objc private func fetchFixtures() {
        viewModel.fetchFixtures()
    }
}

extension SelectCompetitionFixturesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fixtures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCell", for: indexPath) as? MatchTableViewCell else {
            return UITableViewCell()
        }
        let match = fixtures[indexPath.row]
        cell.configure(match: match)
        return cell
    }
}
