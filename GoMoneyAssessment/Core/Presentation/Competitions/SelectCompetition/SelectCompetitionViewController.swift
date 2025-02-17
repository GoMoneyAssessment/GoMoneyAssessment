//
//  SelectCompetitionViewController.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 12/02/2025.
//

import UIKit

class SelectCompetitionViewController: UIViewController {
    public var selectedCompetition: Competition?
    public var selectCompTitle: String = ""
    
    var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Table", "Fixtures", "Teams"])
        control.selectedSegmentIndex = 0
        control.subviews.forEach { subview in
          subview.backgroundColor = .white
        }
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var currentViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = selectCompTitle
        view.backgroundColor = .white
        view.addSubview(segmentedControl)
        view.addSubview(containerView)
        
        setupConstraints()
        
        segmentChanged(segmentedControl)
        
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            containerView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func segmentChanged(_ Sender: UISegmentedControl) {
        let selectedVC: UIViewController
        switch Sender.selectedSegmentIndex {
        case 0:
            selectedVC = SelectCompetitionStandingsViewController(competitionCode: selectedCompetition?.code ?? "")
        case 1:
            selectedVC = SelectCompetitionFixturesViewController()
        case 2:
            selectedVC = SelectCompetitionTeamsViewController()
        default:
            return
        }
        
        switchChildController(to: selectedVC)
    }
    
    private func switchChildController(to selectedController: UIViewController) {
        if let currentVC = currentViewController {
            currentVC.willMove(toParent: nil)
            currentVC.view.removeFromSuperview()
            currentVC.removeFromParent()
        }
        
        addChild(selectedController)
        containerView.addSubview(selectedController.view)
        selectedController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            selectedController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            selectedController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            selectedController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            selectedController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        selectedController.didMove(toParent: self)
        currentViewController = selectedController
    }
}
