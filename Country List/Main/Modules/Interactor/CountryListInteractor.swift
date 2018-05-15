//
//  CountryListInteractor.swift
//  Country List
//
//  Created by rahman fad on 12/05/18.
//  Copyright © 2018 rahman fad. All rights reserved.
//

import UIKit

protocol CountryListInteractorInput: class {
    func getAllList(_ search: String)
}

protocol CountryListInteractorOutput: class {
    func providedCountry(_ list: [CountryModel])
    func servicesError(_ error: NSError )
}

class CountryListInteractor: CountryListInteractorInput {
    
    var APIDataManager: CountryListDataProtocol!
    weak var presenter: CountryListInteractorOutput!

    func getAllList(_ search: String) {
        APIDataManager.countryListSearchText(searchText: search) { (error, list) in
            if let listData = list {
                self.presenter.providedCountry(listData)
                
                    for i in 0..<listData.count {
                        let country = CountryDB.instance.addCountry(cName: listData[i].name, cCode: listData[i].code)
                        if country {
                            print("Data Saved")
                        }
                    }
                
            } else if let error = error {
               self.presenter.servicesError(error)
            }
        }
    }
}
