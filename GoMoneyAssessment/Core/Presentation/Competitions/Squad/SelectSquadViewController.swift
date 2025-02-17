//
//  SelectSquadViewController.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 14/02/2025.
//

import UIKit
import SDWebImage

class SelectSquadViewController: UIViewController {

    var team: Team
    private var teamNameLbl: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var cancelBtn: UIImageView = {
       let img = UIImageView(image: UIImage(systemName: "xmark"))
        img.isUserInteractionEnabled = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private var crest: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        return tableView
    }()
    
    init(team: Team) {
        self.team = team
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupUI()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SquadTableViewCell.self, forCellReuseIdentifier: "SquadTableViewCell")
    }

    private func setupUI() {
        let divider = UIView()
        divider.backgroundColor = .lightGray
        divider.translatesAutoresizingMaskIntoConstraints = false
        
        cancelBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissVC)))
        teamNameLbl.text = team.name
        if let url = URL(string: team.crest ?? "") {
            crest.sd_setImage(with: url, placeholderImage: UIImage(named: "ball"))
        } else {
            crest.image = UIImage(named: "ball")
        }
        view.addSubview(cancelBtn)
        view.addSubview(teamNameLbl)
        view.addSubview(crest)
        view.addSubview(tableView)
        view.addSubview(divider)
        
        NSLayoutConstraint.activate([
            cancelBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            cancelBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            
            teamNameLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            teamNameLbl.centerYAnchor.constraint(equalTo: cancelBtn.centerYAnchor),
            
            divider.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            divider.topAnchor.constraint(equalTo: teamNameLbl.bottomAnchor, constant: 20),
            divider.heightAnchor.constraint(equalToConstant: 3),
            
            crest.widthAnchor.constraint(equalToConstant: 50),
            crest.heightAnchor.constraint(equalToConstant: 40),
            crest.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            crest.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: crest.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}

extension SelectSquadViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        team.squad?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SquadTableViewCell", for: indexPath) as! SquadTableViewCell
        let index = indexPath.row + 1
        if let squad = team.squad {
            let player = squad[indexPath.row]
            cell.configure(index: index, player: player)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
