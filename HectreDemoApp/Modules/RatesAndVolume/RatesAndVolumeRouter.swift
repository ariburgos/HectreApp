//
//  RatesAndVolumeRouter.swift
//  HectreDemoApp
//
//  Created by Viajeros Lado B on 01/08/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import UIKit

class RatesAndVolumeRouter: RatesAndVolumeRouterProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "RatesAndVolumeViewController") as! RatesAndVolumeViewController
        let navigation = UINavigationController(rootViewController: view)
        navigation.navigationBar.barTintColor = UIColor.AppColors.main
        navigation.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]


        let interactor = RatesAndVolumeInteractor()
        let router = RatesAndVolumeRouter()
        let presenter = RatesAndVolumePresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return navigation
    }
}
