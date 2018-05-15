//
//  CountryListAssembly.swift
//  Country List
//
//  Created by rahman fad on 12/05/18.
//  Copyright © 2018 rahman fad. All rights reserved.
//

import Foundation

class CountryListAssembly {
    
    static let sharedInstance = CountryListAssembly()
    
    func configure(_ viewController: ViewController){
        let APIManager = CountryListDataManager()
        let interactor = CountryListInteractor()
        let presenter  = CountryListPresenter()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        presenter.interactor = interactor
        interactor.APIDataManager = APIManager
    }
}
