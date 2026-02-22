//
//  AssemblyModuleBuilderProtocol.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 21.02.2026.
//

import UIKit

protocol AssemblyModuleBuilderProtocol: AnyObject {
    func createVC(_ type: MapRouter, coordinator: AppCoordinatorProtocol) -> UIViewController
}
