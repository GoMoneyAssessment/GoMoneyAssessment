//
//  SelectCompetitionViewController.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 12/02/2025.
//

import UIKit

class SelectCompetitionViewController: BaseViewController {
    public var selectedCompetition: Competition?
    public var selectCompTitle: String = ""
    
    var segmentStack: UIStackView = {
            var stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .equalSpacing
            stack.alignment = .fill
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        var TablesBtn: UIButton = {
            var btn = UIButton()
            btn.setTitle("Table", for: .normal)
            btn.setTitleColor(.label, for: .normal)
            return btn
        }()
        
        var FixturesBtn: UIButton = {
            var btn = UIButton()
            btn.setTitle("Fixtures", for: .normal)
            btn.setTitleColor(.label, for: .normal)
            return btn
        }()
        
        var TeamsBtn: UIButton = {
            var btn = UIButton()
            btn.setTitle("Teams", for: .normal)
            btn.setTitleColor(.label, for: .normal)
            return btn
        }()
        
        private let containerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    private var currentViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = selectCompTitle
        setupBackButton()
        view.backgroundColor = .systemBackground
        view.addSubview(segmentStack)
        view.addSubview(containerView)
        
        setupSegmentStack()
                
                segmentChanged(TablesBtn)
                
                TablesBtn.addTarget(self, action: #selector(segmentChanged), for: .touchUpInside)
                FixturesBtn.addTarget(self, action: #selector(segmentChanged), for: .touchUpInside)
                TeamsBtn.addTarget(self, action: #selector(segmentChanged), for: .touchUpInside)
    }
    
    private func setupSegmentStack() {
           
           NSLayoutConstraint.activate([
               segmentStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
               segmentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
               segmentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
               segmentStack.heightAnchor.constraint(equalToConstant: 50),
               containerView.topAnchor.constraint(equalTo: segmentStack.bottomAnchor),
               containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
           ])
           
           
           segmentStack.addArrangedSubview(TablesBtn)
           segmentStack.addArrangedSubview(FixturesBtn)
           segmentStack.addArrangedSubview(TeamsBtn)
       }
    
    @objc private func segmentChanged(_ Sender: UIButton) {
            let selectedVC: UIViewController
            
            if Sender == TablesBtn {
                selectedVC = SelectCompetitionStandingsViewController(competitionCode: selectedCompetition?.code ?? "")
                TablesBtn.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
                FixturesBtn.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
                TeamsBtn.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
            } else if Sender == FixturesBtn {
                selectedVC = SelectCompetitionFixturesViewController(competitionCode: selectedCompetition?.code ?? "")
                TablesBtn.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
                FixturesBtn.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
                TeamsBtn.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
            } else if Sender == TeamsBtn {
                selectedVC = SelectCompetitionTeamsViewController(competitionCode: selectedCompetition?.code ?? "")
                TablesBtn.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
                FixturesBtn.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
                TeamsBtn.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
            } else {
                selectedVC = SelectCompetitionStandingsViewController(competitionCode: selectedCompetition?.code ?? "")
                TablesBtn.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
                FixturesBtn.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
                TeamsBtn.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
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
