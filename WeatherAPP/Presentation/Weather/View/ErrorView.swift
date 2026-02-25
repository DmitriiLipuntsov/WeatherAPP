//
//  ErrorView.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 23.02.2026.
//

import UIKit

final class ErrorView: UIView {
    
    // MARK: - UI
    private var blurBackgroundView: UIVisualEffectView?
    private let stackView = UIStackView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let retryButton = UIButton(type: .system)
    
    private var retryAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

// MARK: - Configure
extension ErrorView {
    func configure(
        icon: String,
        title: String,
        subtitle: String,
        retry: @escaping () -> Void
    ) {
        iconImageView.image = UIImage(systemName: icon)
        titleLabel.text = title
        subtitleLabel.text = subtitle
        retryAction = retry
    }
}

// MARK: - Actions
private extension ErrorView {
    @objc private func retryTapped() {
        retryAction?()
    }
}

// MARK: - Setup UI
private extension ErrorView {
    func setupUI() {
        setupBlurBackground()
        setupStackView()
        setupIcon()
        setupTitleLabel()
        setupSubtitleLabel()
        setupRetryButton()
        setConstraints()
    }
    
    private func setupBlurBackground() {
        layer.cornerRadius = 20
        layer.masksToBounds = true
        
        let blur = UIBlurEffect(style: .systemThinMaterial)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.alpha = 0.9
        
        addSubview(blurView)
        blurView.layer.zPosition = 0
        blurView.layer.cornerRadius = 20
        blurView.clipsToBounds = true
        blurBackgroundView = blurView
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.layer.zPosition = 10
        
        addSubview(stackView)
    }
    
    private func setupIcon() {
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .white
        iconImageView.preferredSymbolConfiguration =
            UIImage.SymbolConfiguration(pointSize: 40, weight: .medium)
        
        stackView.addArrangedSubview(iconImageView)
    }
    
    private func setupTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        stackView.addArrangedSubview(titleLabel)
    }
    
    private func setupSubtitleLabel() {
        subtitleLabel.font = .systemFont(ofSize: 16)
        subtitleLabel.textColor = .white.withAlphaComponent(0.85)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        
        stackView.addArrangedSubview(subtitleLabel)
    }
    
    private func setupRetryButton() {
        var config = UIButton.Configuration.filled()
        config.title = "Retry"
        config.baseForegroundColor = .white
        config.baseBackgroundColor = UIColor.white.withAlphaComponent(0.2)
        config.cornerStyle = .medium
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24)
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 16, weight: .semibold)
            return outgoing
        }

        retryButton.configuration = config
        retryButton.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)

        stackView.addArrangedSubview(retryButton)
    }
}

// MARK: - Set Constraints
private extension ErrorView {
    private func setConstraints() {
        setStackViewConstraints()
        setBlurConstraints()
    }
    private func setStackViewConstraints() {
        let forView = stackView
        forView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            forView.centerXAnchor.constraint(equalTo: centerXAnchor),
            forView.centerYAnchor.constraint(equalTo: centerYAnchor),
            forView.leadingAnchor.constraint(
                greaterThanOrEqualTo: leadingAnchor,
                constant: 48
            ),
            forView.trailingAnchor.constraint(
                lessThanOrEqualTo: trailingAnchor,
                constant: -48
            )
        ])
    }
    
    private func setBlurConstraints() {
        guard let blur = blurBackgroundView else { return }
        blur.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blur.topAnchor.constraint(equalTo: stackView.topAnchor, constant: -24),
            blur.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -24),
            blur.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 24),
            blur.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 24)
        ])
    }
}
