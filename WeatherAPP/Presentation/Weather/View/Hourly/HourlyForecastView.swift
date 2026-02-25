//
//  HourlyForecastView.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 23.02.2026.
//

import UIKit

final class HourlyForecastView: UIView {

    // MARK: - Properties
    private var items: [HourWeather] = []

    // MARK: - UI
    private var blurBackgroundView: UIVisualEffectView?
    private var collectionView: UICollectionView?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - Configuration
    func configure(with items: [HourWeather]) {
        self.items = items
        collectionView?.reloadData()
    }
}

// MARK: - Setup UI
private extension HourlyForecastView {
    func setupUI() {
        setupBlurBackground()
        setupCollectionView()
    }

    func setupBlurBackground() {
        let blur = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.layer.cornerRadius = 16
        blurView.layer.masksToBounds = true
        blurView.alpha = 0.5
        addSubview(blurView)
        blurBackgroundView = blurView
        setBlurBackgroundConstraints()
    }

    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(HourlyCell.self, forCellWithReuseIdentifier: "HourlyCell")
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        addSubview(cv)
        collectionView = cv
        setCollectionViewConstraints()
    }
}

// MARK: - Set Constraints
private extension HourlyForecastView {
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

    private func setCollectionViewConstraints() {
        guard let cv = collectionView else { return }
        cv.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cv.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            cv.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            cv.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            cv.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -0),
            cv.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

// MARK: - UICollectionView DataSource & Delegate
extension HourlyForecastView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyCell", for: indexPath) as! HourlyCell
        cell.configure(with: items[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 60, height: 100)
    }
}
