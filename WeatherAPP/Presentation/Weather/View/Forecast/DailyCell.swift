//
//  DailyCell.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 23.02.2026.
//

import UIKit

final class DailyCell: UITableViewCell {

    // MARK: - UI
    private let dateLabel = UILabel()
    private let iconImageView = UIImageView()
    private let tempLabel = UILabel()
    private var stack: UIStackView?

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - Configuration
    func configure(with model: ForecastDay) {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM"
        dateLabel.text = formatter.string(from: model.date)
        tempLabel.text = "\(Int(model.minTemperature))° / \(Int(model.maxTemperature))°"

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
private extension DailyCell {
    func setupUI() {
        setupDateLabel()
        setupIconImageView()
        setupTempLabel()
        setupStack()
    }

    func setupDateLabel() {
        dateLabel.font = .systemFont(ofSize: 16)
        dateLabel.textColor = .white
    }

    func setupIconImageView() {
        iconImageView.contentMode = .scaleAspectFit
    }

    func setupTempLabel() {
        tempLabel.font = .systemFont(ofSize: 16)
        tempLabel.textColor = .white
    }

    func setupStack() {
        let stack = UIStackView(arrangedSubviews: [dateLabel, iconImageView, tempLabel])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 12
        contentView.addSubview(stack)
        self.stack = stack
        setStackConstraints(stack)
        setIconConstraints()
    }
}

// MARK: - Set Constraints
private extension DailyCell {
    func setStackConstraints(_ stack: UIStackView) {
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    func setIconConstraints() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 32),
            iconImageView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
