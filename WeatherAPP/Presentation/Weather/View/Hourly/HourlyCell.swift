//
//  HourlyCell.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 23.02.2026.
//

import UIKit

final class HourlyCell: UICollectionViewCell {

    // MARK: - UI
    private let timeLabel = UILabel()
    private let iconImageView = UIImageView()
    private let tempLabel = UILabel()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Configuration
    func configure(with model: HourWeather) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        timeLabel.text = formatter.string(from: model.date)
        tempLabel.text = "\(Int(model.temperature))°"
        
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
private extension HourlyCell {
    func setupUI() {
        setupTimeLabel()
        setupIconImageView()
        setupTempLabel()
        setupStack()
    }
    
    func setupTimeLabel() {
        timeLabel.font = .systemFont(ofSize: 14)
        timeLabel.textColor = .white
        timeLabel.textAlignment = .center
    }
    
    func setupIconImageView() {
        iconImageView.contentMode = .scaleAspectFit
    }
    
    func setupTempLabel() {
        tempLabel.font = .systemFont(ofSize: 14)
        tempLabel.textColor = .white
        tempLabel.textAlignment = .center
    }
    
    func setupStack() {
        let stack = UIStackView(arrangedSubviews: [timeLabel, iconImageView, tempLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        contentView.addSubview(stack)
        setStackConstraints(stack)
    }
}

// MARK: - Set Constraints
private extension HourlyCell {
    func setStackConstraints(_ stack: UIStackView) {
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4)
        ])
    }
}
