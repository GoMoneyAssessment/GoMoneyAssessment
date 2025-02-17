//
//  SquadTableViewCell.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 14/02/2025.
//

import Foundation
import UIKit

class SquadTableViewCell: UITableViewCell {
    
    private var playerNumberLbl: UILabel = {
       let label = UILabel()
        label.textAlignment  = .right
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var playerNameLbl: UILabel = {
       let label = UILabel()
        label.textAlignment  = .left
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var playerPositionLbl: UILabel = {
       let label = UILabel()
        label.textAlignment  = .right
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
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
        contentView.addSubview(playerNumberLbl)
        contentView.addSubview(playerNameLbl)
        contentView.addSubview(playerPositionLbl)
        
        NSLayoutConstraint.activate([
            playerNumberLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            playerNumberLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            playerNumberLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
            
            playerNameLbl.centerYAnchor.constraint(equalTo: playerNumberLbl.centerYAnchor),
            playerNameLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            
            playerPositionLbl.centerYAnchor.constraint(equalTo: playerNumberLbl.centerYAnchor),
            playerPositionLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
    
    public func configure(index: Int, player: Player) {
        playerNumberLbl.text = "\(index)"
        playerNameLbl.text = player.name
        playerPositionLbl.text = player.position
    }
}
