//
//  LaunchScreenViewController.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 22.02.2026.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    private let titleLabel = UILabel()
    
    required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyMainGradientBackground()
        setupUI()
    }
}

//MARK: Setup UI
extension LaunchScreenViewController {
    private func setupUI() {
        setupTitleLabel()
    }
    
    private func setupTitleLabel() {
        let label = titleLabel
        label.text = "Weather App"
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26, weight: .bold)
        view.addSubview(label)
        setTitleLableConstraints()
    }
}

//MARK: - set constraints
extension LaunchScreenViewController {
    private func setTitleLableConstraints() {
        let forView = titleLabel
        forView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            forView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
