//
//  WeatherViewController.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 21.02.2026.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    private let viewModel: WeatherViewModel
    
    // MARK: - UI
    private let backgroundView = GradientBackgroundView()
    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()
    
    private let currentWeatherView = CurrentWeatherView()
    private let hourlyForecastView = HourlyForecastView()
    private let dailyForecastView = DailyForecastView()
    private let loadingView = UIActivityIndicatorView(style: .large)
    private let errorView = ErrorView()
    
    private let networkBanner = FloatingBannerView()
    private let locationBanner = FloatingBannerView()
    
    private let bannerToggleButton = UIButton(type: .system)
    private var isLocationBannerVisible = true
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        applyMainGradientBackground()
        setupUI()
        setupBindings()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let state = viewModel.state
        changeState(state)
        let lbState = viewModel.locationBannerState
        changeLocationBannerState(lbState)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.requestWeatherWithLocation()
    }
}

// MARK: - Setup UI
private extension WeatherViewController {
    func setupUI() {
        setupScrollView()
        setupContentStack()
        setupLoadingView()
        setupErrorView()
        setupLocationBanner()
        setupBannerToggleButton()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        setScrollViewConstraints()
    }
    
    private func setupContentStack() {
        scrollView.addSubview(contentStack)
        contentStack.axis = .vertical
        contentStack.spacing = 16
        setContentStackConstraints()
        contentStackAddArrangedSubview()
    }
    
    private func contentStackAddArrangedSubview() {
        contentStack.addArrangedSubview(currentWeatherView)
        contentStack.addArrangedSubview(hourlyForecastView)
        contentStack.addArrangedSubview(dailyForecastView)
        currentWeatherView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        hourlyForecastView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        dailyForecastView.heightAnchor.constraint(equalToConstant: 220).isActive = true
    }
    
    private func setupLoadingView() {
        loadingView.color = .white
        loadingView.hidesWhenStopped = true
        view.addSubview(loadingView)
        setLoadingViewConstraints()
    }
    
    private func setupErrorView() {
        errorView.isHidden = true
        view.addSubview(errorView)
        setErrorViewConstraints()
    }
    
    private func setupLocationBanner() {
        view.addSubview(locationBanner)
        setLocationBannerConstraints()
    }
    
    private func setupNetworkBanner() {
        view.addSubview(networkBanner)
        setNetworkBannerConstraints()
    }
    
    private func setupBannerToggleButton() {
        view.addSubview(bannerToggleButton)
        bannerToggleButton.setImage(UIImage(systemName: "chevron.down.circle.fill"), for: .normal)
        bannerToggleButton.tintColor = .white.withAlphaComponent(0.8)
        bannerToggleButton.addTarget(self, action: #selector(toggleLocationBanner), for: .touchUpInside)
        setBannerToggleButtonConstraints()
    }
    
    @objc
    private func toggleLocationBanner() {
        isLocationBannerVisible.toggle()
        if isLocationBannerVisible {
            locationBanner.show()
        } else {
            locationBanner.hide()
        }
    }
}

// MARK: - Set Constraints
private extension WeatherViewController {
    private func setScrollViewConstraints() {
        let forView = scrollView
        forView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            forView.leftAnchor.constraint(equalTo: view.leftAnchor),
            forView.rightAnchor.constraint(equalTo: view.rightAnchor),
            forView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setContentStackConstraints() {
        let contentGuide = scrollView.contentLayoutGuide
        let frameGuide = scrollView.frameLayoutGuide
        let forView = contentStack
        forView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forView.topAnchor.constraint(equalTo: contentGuide.topAnchor, constant: 16),
            forView.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor, constant: 16),
            forView.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor, constant: -16),
            forView.bottomAnchor.constraint(equalTo: contentGuide.bottomAnchor, constant: -16),
            forView.widthAnchor.constraint(equalTo: frameGuide.widthAnchor, constant: -32)
        ])
    }
    
    private func setErrorViewConstraints() {
        let forView = errorView
        forView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            forView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            forView.topAnchor.constraint(equalTo: view.topAnchor),
            forView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setLocationBannerConstraints() {
        let forView = locationBanner
        forView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            forView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            forView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    private func setNetworkBannerConstraints() {
        let forView = locationBanner
        forView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            forView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            forView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    private func setLoadingViewConstraints() {
        let forView = loadingView
        forView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            forView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setBannerToggleButtonConstraints() {
        let forView = bannerToggleButton
        forView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            forView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            forView.widthAnchor.constraint(equalToConstant: 44),
            forView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

// MARK: - Bindings
private extension WeatherViewController {
    func setupBindings() {
        setupLocationBindings()
        setupStateBindings()
    }
    
    private func setupLocationBindings() {
        viewModel.onLocationDenied = { [weak self] state in
            self?.changeLocationBannerState(state)
        }
    }
    
    private func setupStateBindings() {
        viewModel.onStateChange = { [weak self] state in
            guard let self = self else { return }
            changeState(state)
        }
    }
}

// MARK: - Changes
private extension WeatherViewController {
    private func changeLocationBannerState(_ state: LocationBannerState) {
        switch state {
        case .denied:
            showLocationIssue("Location access denied. Please grant permission to update weather.")
        case .none:
            networkBanner.hide()
            locationBanner.hide()
            hideBannerToggleButton()
        }
    }
    
    private func changeState(_ state: WeatherViewState) {
        switch state {
        case .idle:
            self.loadingView.stopAnimating()
            self.errorView.isHidden = true
        case .loading:
            self.loadingView.startAnimating()
            self.errorView.isHidden = true
        case .loaded(let aggregate):
            self.loadingView.stopAnimating()
            self.errorView.isHidden = true
            self.currentWeatherView.configure(with: aggregate.current)
            
            let hourly = aggregate.forecast.flatMap { $0.hours }
            self.hourlyForecastView.configure(with: hourly)
            
            self.dailyForecastView.configure(with: Array(aggregate.forecast.prefix(3)))
        case .error(let message):
            self.loadingView.stopAnimating()
            self.errorView.isHidden = false
            self.errorView.configure(
                icon: "exclamationmark.triangle",
                title: message,
                subtitle: ""
            ) { [weak self] in
                self?.viewModel.requestWeatherWithLocation()
            }
        }
    }
}

// MARK: - Banners
private extension WeatherViewController {
    private func showNetworkIssue(_ message: String) {
        networkBanner.configure(message: message, buttonTitle: "Retry") { [weak self] in
            self?.viewModel.requestWeatherWithLocation()
        }
        networkBanner.show()
        showBannerToggleButton()
    }

    private func showLocationIssue(_ message: String) {
        locationBanner.configure(message: message, buttonTitle: "Grant Access") {
            self.viewModel.handleGrantLocationAccessTapped()
        }
        locationBanner.show()
        showBannerToggleButton()
    }
    
    private func hideBannerToggleButton() {
        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0.6,
            options: [.curveEaseInOut]
        ) {
            self.bannerToggleButton.alpha = 0
        }
    }
    
    private func showBannerToggleButton() {
        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0.6,
            options: [.curveEaseInOut]
        ) {
            self.bannerToggleButton.alpha = 1
        }
    }
}
