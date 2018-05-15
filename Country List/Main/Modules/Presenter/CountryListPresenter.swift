//
//  CountryListPresenter.swift
//  Country List
//
//  Created by rahman fad on 12/05/18.
//  Copyright © 2018 rahman fad. All rights reserved.
//

import Foundation

protocol CountryListPresenterInput: ListViewControllerOutput, CountryListInteractorOutput {
}

class CountryListPresenter: CountryListPresenterInput {
    
    var interactor: CountryListInteractorInput!
    weak var view: ListViewControllerInput!
    
    func fetchList(_ search: String){
        interactor?.getAllList(search)
    }
    
    func providedCountry(_ list: [CountryModel]) {
        self.view.displayCountry(list)
    }
    
    func servicesError(_ error: NSError ) {
        self.view.showErrorView(defaultErrorMessage)
    }
}
