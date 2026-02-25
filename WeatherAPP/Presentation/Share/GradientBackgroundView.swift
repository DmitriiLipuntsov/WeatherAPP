//
//  GradientBackgroundView.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 23.02.2026.
//

import Foundation
import UIKit

final class GradientBackgroundView: UIView {
    
    // MARK: - Layers
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}

// MARK: - Setup UI
private extension GradientBackgroundView {
    func setupUI() {
        setupGradientLayer()
    }
    
    func setupGradientLayer() {
        gradientLayer.colors = [
            UIColor(red: 24/255, green: 41/255, blue: 71/255, alpha: 1).cgColor,
            UIColor(red: 111/255, green: 87/255, blue: 100/255, alpha: 1).cgColor
        ]
        
        gradientLayer.locations = [0.346, 1.0]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint   = CGPoint(x: 0.5, y: 1.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
