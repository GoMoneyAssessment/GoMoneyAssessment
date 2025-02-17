//
//  HomeViewController.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 12/02/2025.
//

import UIKit

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private func setup() {
        let todayFixturesVC = TodayFixturesViewController()
        let allCompsVC = AllCompetitionsViewController()
        
        let todayFixturesNav = UINavigationController(rootViewController: todayFixturesVC)
        let allCompsNav = UINavigationController(rootViewController: allCompsVC)
        
        todayFixturesVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "ball"), tag: 1)
        allCompsVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "pitch"), tag: 2)
        
        todayFixturesVC.tabBarItem.accessibilityIdentifier = "TodayFixturesTab"
        allCompsVC.tabBarItem.accessibilityIdentifier = "AllCompetitionsTab"
        
        viewControllers = [todayFixturesNav, allCompsNav]
    }
}
