//
//  TeamCell.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 13/02/2025.
//

import Foundation
import UIKit
import SDWebImage

class TeamCell: UICollectionViewCell {
    let teamImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let teamNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(teamImage)
        contentView.addSubview(teamNameLabel)
        
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: 0, height: 3)
        contentView.layer.shadowRadius = 5
        
        NSLayoutConstraint.activate([
            teamImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            teamImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            teamImage.widthAnchor.constraint(equalToConstant: 80),
            teamImage.heightAnchor.constraint(equalToConstant: 80),
            
            teamNameLabel.topAnchor.constraint(equalTo: teamImage.bottomAnchor, constant: 8),
            teamNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            teamNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
    
    public func configure(team: Team) {
        if let url = URL(string: team.crest ?? "") {
            teamImage.sd_setImage(with: url, placeholderImage: UIImage(named: "ball"))
        } else {
            teamImage.image = UIImage(named: "ball")
        }
        teamNameLabel.text = team.name
    }
}
