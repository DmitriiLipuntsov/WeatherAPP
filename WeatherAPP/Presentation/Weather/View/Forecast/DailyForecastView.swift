//
//  DailyForecastView.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 23.02.2026.
//

import UIKit

final class DailyForecastView: UIView {

    // MARK: - Properties
    private var items: [ForecastDay] = []
    private var tableHeightConstraint: NSLayoutConstraint?
    
    // MARK: - UI
    private var blurBackgroundView: UIVisualEffectView?
    private var tableView: UITableView?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Configuration
    func configure(with items: [ForecastDay]) {
        self.items = items
        tableView?.reloadData()
        tableView?.layoutIfNeeded()
        tableHeightConstraint?.constant = tableView?.contentSize.height ?? 0
    }
}

// MARK: - Setup UI
private extension DailyForecastView {
    func setupUI() {
        setupBlurBackground()
        setupTableView()
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
    
    func setupTableView() {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.register(DailyCell.self, forCellReuseIdentifier: "DailyCell")
        tv.dataSource = self
        tv.delegate = self
        tv.isScrollEnabled = false
        tv.separatorStyle = .none
        addSubview(tv)
        tableView = tv
        setTableViewConstraints()
    }
}

// MARK: - Set Constraints
private extension DailyForecastView {
    func setBlurBackgroundConstraints() {
        guard let blurView = blurBackgroundView else { return }
        blurView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setTableViewConstraints() {
        guard let tv = tableView else { return }
        tv.translatesAutoresizingMaskIntoConstraints = false
        tableHeightConstraint = tv.heightAnchor.constraint(equalToConstant: 0)
        tableHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            tv.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            tv.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            tv.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            tv.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
}

// MARK: - UITableView DataSource & Delegate
extension DailyForecastView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyCell", for: indexPath) as! DailyCell
        cell.configure(with: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}
