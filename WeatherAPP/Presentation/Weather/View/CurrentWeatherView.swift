//
//  CurrentWeatherView.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 23.02.2026.
//

import UIKit

final class CurrentWeatherView: UIView {

    // MARK: - Properties
    private var model: Weather?

    // MARK: - UI
    private var blurBackgroundView: UIVisualEffectView?
    private let cityLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let conditionLabel = UILabel()
    private let iconImageView = UIImageView()
    private let humidityLabel = UILabel()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - Configuration
    func configure(with model: Weather) {
        self.model = model

        cityLabel.text = model.city
        temperatureLabel.text = "\(Int(model.temperature))°C"
        conditionLabel.text = model.condition
        humidityLabel.text = "Humidity: \(model.humidity)%"

        if let url = model.iconURL {
            Task {
                if let data = try? await fetchData(from: url) {
                    iconImageView.image = UIImage(data: data)
                }
            }
        }
    }

    private func fetchData(from url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}

// MARK: - Setup UI
private extension CurrentWeatherView {
    func setupUI() {
        setupBlurBackground()
        setupCityLabel()
        setupTemperatureLabel()
        setupConditionLabel()
        setupIconImageView()
        setupHumidityLabel()
        setupStack()
    }

    func setupBlurBackground() {
        let blur = UIBlurEffect(style: .systemThinMaterial)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.layer.cornerRadius = 16
        blurView.layer.masksToBounds = true
        blurView.alpha = 0.5
        addSubview(blurView)
        blurBackgroundView = blurView
        setBlurBackgroundConstraints()
    }

    func setupCityLabel() {
        let label = cityLabel
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
    }

    func setupTemperatureLabel() {
        let label = temperatureLabel
        label.font = .systemFont(ofSize: 48, weight: .bold)
        label.textColor = .white
    }

    func setupConditionLabel() {
        let label = conditionLabel
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
    }

    func setupIconImageView() {
        let icon = iconImageView
        icon.contentMode = .scaleAspectFit
    }

    func setupHumidityLabel() {
        let label = humidityLabel
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
    }

    func setupStack() {
        let stack = UIStackView(arrangedSubviews: [cityLabel, iconImageView, temperatureLabel, conditionLabel, humidityLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        addSubview(stack)
        setStackConstraints(stack)
    }
}

// MARK: - Set Constraints
private extension CurrentWeatherView {
    private func setBlurBackgroundConstraints() {
        guard let blurView = blurBackgroundView else { return }
        blurView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func setStackConstraints(_ stack: UIStackView) {
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
}
