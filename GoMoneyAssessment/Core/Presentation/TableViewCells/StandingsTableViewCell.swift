//
//  StandingsTableViewCell.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 13/02/2025.
//

import Foundation
import UIKit
import SDWebImage

class StandingsTableViewCell: UITableViewCell {
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let positionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    private let teamCrest: UIImageView = {
        let crest = UIImageView()
        crest.translatesAutoresizingMaskIntoConstraints = false
        return crest
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    private let matchesPlayedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    private let goalDifferenceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        contentView.addSubview(positionLabel)
        contentView.addSubview(teamCrest)
        contentView.addSubview(nameLabel)
        contentView.addSubview(matchesPlayedLabel)
        contentView.addSubview(goalDifferenceLabel)
        contentView.addSubview(pointsLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
            containerView.heightAnchor.constraint(equalToConstant: 30),
            
            positionLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            positionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            
            teamCrest.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            teamCrest.widthAnchor.constraint(equalToConstant: 20),
            teamCrest.heightAnchor.constraint(equalToConstant: 20),
            teamCrest.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
            
            nameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 60),
            
            pointsLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            pointsLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            goalDifferenceLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            goalDifferenceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -35),
            
            matchesPlayedLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            matchesPlayedLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -70)
            
        ])
    }
    
    public func configure(standing: TeamStanding) {
        positionLabel.text = "\(standing.position ?? 0)"
        nameLabel.text = standing.team?.name
        matchesPlayedLabel.text = "\(standing.playedGames ?? 0)"
        goalDifferenceLabel.text = "\(standing.goalDifference ?? 0)"
        pointsLabel.text = "\(standing.points ?? 0)"
        if let url = URL(string: standing.team?.crest ?? "") {
            teamCrest.sd_setImage(with: url, placeholderImage: UIImage(named: "ball"))
        } else {
            teamCrest.image = UIImage(named: "ball")
        }
        
    }
}
