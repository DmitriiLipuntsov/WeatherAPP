//
//  FloatingBannerView.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 23.02.2026.
//

import UIKit

final class FloatingBannerView: UIView {

    // MARK: - UI
    private var blurBackgroundView: UIVisualEffectView?
    private let label = UILabel()
    private let actionButton = UIButton(type: .system)
    private var action: (() -> Void)?

    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }
}

// MARK: - Configure
extension FloatingBannerView {
    func configure(
        message: String,
        buttonTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        label.text = message
        self.action = action

        if let title = buttonTitle {
            actionButton.setTitle(title, for: .normal)
            actionButton.isHidden = false
        } else {
            actionButton.isHidden = true
        }
    }
}

// MARK: - Show / Hide
extension FloatingBannerView {
    func show() {
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
    }

    func hide() {
        UIView.animate(withDuration: 0.25) {
            self.alpha = 0
        }
    }
}

// MARK: - Actions
private extension FloatingBannerView {
    @objc func buttonTapped() {
        action?()
    }
}

// MARK: - Setup UI
private extension FloatingBannerView {
    func setupUI() {
        setupBlurBackground()
        setupLabel()
        setupActionButton()
    }

    func setupBlurBackground() {
        alpha = 0
        layer.cornerRadius = 16
        layer.masksToBounds = true

        let blur = UIBlurEffect(style: .systemThinMaterial)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.layer.cornerRadius = 16
        blurView.layer.masksToBounds = true
        blurView.alpha = 0.6

        addSubview(blurView)
        blurBackgroundView = blurView
        setBlurConstraints()
    }

    func setupLabel() {
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0

        addSubview(label)
        setLabelConstraints()
    }

    func setupActionButton() {
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        actionButton.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        actionButton.layer.cornerRadius = 12
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        addSubview(actionButton)
        setActionButtonConstraints()
    }
}

// MARK: - Constraints
private extension FloatingBannerView {

    func setBlurConstraints() {
        guard let blur = blurBackgroundView else { return }
        blur.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blur.topAnchor.constraint(equalTo: topAnchor),
            blur.bottomAnchor.constraint(equalTo: bottomAnchor),
            blur.leadingAnchor.constraint(equalTo: leadingAnchor),
            blur.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func setLabelConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    func setActionButtonConstraints() {
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12),
            actionButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 40),
            actionButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 120),
            actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
