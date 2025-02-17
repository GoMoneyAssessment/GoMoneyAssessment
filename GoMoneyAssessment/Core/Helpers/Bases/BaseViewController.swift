//
//  BaseViewController.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 13/02/2025.
//

import UIKit

class BaseViewController: UIViewController {
    
    private var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupBackButton() {
        navigationItem.hidesBackButton = true
        
        let backBtn = UIBarButtonItem(image: UIImage(systemName: "arrow.left"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backBtn
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func showLoader() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.accessibilityIdentifier = "activityIndicator"
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    func hideLoader() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    func showErrorAlert(message: String?, retryAction: @escaping () -> ()) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.view.accessibilityIdentifier = "errorAlert"
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
            retryAction()
        }))
        present(alert, animated: true)
    }
}
