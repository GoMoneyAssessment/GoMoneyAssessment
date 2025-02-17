//
//  MatchTableViewCell.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 12/02/2025.
//

import Foundation
import UIKit

class MatchTableViewCell: UITableViewCell {
    private let matchStatusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let matchTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let matchdayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .light)
        //label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let homeTeamLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let awayTeamLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let homeScoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let awayScoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currentMatchTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(matchStatusLabel)
        contentView.addSubview(matchTimeLabel)
        contentView.addSubview(homeTeamLabel)
        contentView.addSubview(awayTeamLabel)
        contentView.addSubview(homeScoreLabel)
        contentView.addSubview(awayScoreLabel)
        contentView.addSubview(currentMatchTimeLabel) // **Added**
        contentView.addSubview(matchdayLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            matchStatusLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            matchStatusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            matchTimeLabel.topAnchor.constraint(equalTo: matchStatusLabel.bottomAnchor, constant: 6),
            matchTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            matchdayLabel.topAnchor.constraint(equalTo: matchTimeLabel.bottomAnchor, constant: 6),
            matchdayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            matchdayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            homeTeamLabel.topAnchor.constraint(equalTo: matchStatusLabel.centerYAnchor),
            homeTeamLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            
            awayTeamLabel.bottomAnchor.constraint(equalTo: matchdayLabel.centerYAnchor),
            awayTeamLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            
            homeScoreLabel.centerYAnchor.constraint(equalTo: homeTeamLabel.centerYAnchor),
            homeScoreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            awayScoreLabel.centerYAnchor.constraint(equalTo: awayTeamLabel.centerYAnchor),
            awayScoreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            currentMatchTimeLabel.centerYAnchor.constraint(equalTo: matchTimeLabel.centerYAnchor),
            currentMatchTimeLabel.trailingAnchor.constraint(equalTo: awayScoreLabel.leadingAnchor, constant: -12),
        ])
    }
    
    func configure(match: Match) {
        matchStatusLabel.text = match.status ?? "TIMED"
        matchTimeLabel.text = match.utcDate?.getTimeFromDate()
        matchdayLabel.text = "MD: \(match.matchday ?? 0)"
        homeTeamLabel.text = match.homeTeam?.name
        awayTeamLabel.text = match.awayTeam?.name
        homeScoreLabel.text = "\(match.score?.fullTime?.home ?? 0)"
        awayScoreLabel.text = "\(match.score?.fullTime?.away ?? 0)"
        currentMatchTimeLabel.text = "\(match.elapsedTime ?? "00")"
    }
}
