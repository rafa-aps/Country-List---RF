//
//  CountryListDataManager.swift
//  Country List
//
//  Created by rahman fad on 12/05/18.
//  Copyright © 2018 rahman fad. All rights reserved.
//

import Foundation
import SQLite

enum JSONError: String, Error {
    case NoData = "ERROR: no data"
    case ConversionFailed = "ERROR: conversion from JSON failed"
}

protocol CountryListDataProtocol: class {
    func countryListSearchText(searchText: String, clousure: @escaping (NSError?, [CountryModel]?) -> Void) -> Void
}

class CountryListDataManager: CountryListDataProtocol {
    
    var db: Connection?
    static let sharedInstance = CountryListDataManager()
    
    struct ListAPI {
        static let tagSearch = "https://battuta.medunes.net/api/country/all/?key=bed982a49270c3913a14ca53da15fc09"
    }
    
    func countryListSearchText(searchText: String, clousure: @escaping (NSError?, [CountryModel]?) -> Void) -> Void {
        
        guard let url = NSURL(string: ListAPI.tagSearch) else {
            return
        }
    
        let request = URLRequest(url: url as URL)
//        let table = Table("country")
//        let itExists = try db?.scalar(table.exists)
//        if itExists! {
//            //Do stuff
//        }
        
        // =============================================================================================================
        // Why i set user default, to check if seearchTask have call api, because SqlLite table.exists always return nil
        // =============================================================================================================
        // i think is version 3 not support or different mehod to use, in under 3 version, its run
        
        let setCall = UserDefaults.standard.integer(forKey: "setCall")
        
        if (setCall != 1) {
            let searchTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    print("Error : \(String(describing: error))")
                    clousure(error! as NSError, nil)
                }
                do {
                    
                    guard let data = data else {
                        throw JSONError.NoData
                    }
                    guard let resultArray = try JSONSerialization.jsonObject(with: data, options: []) as? NSArray else {
                        throw JSONError.ConversionFailed
                    }
                    print(resultArray)
                    
                    guard let result =  resultArray as? [NSDictionary] else { return }
                    
                    let countryList: [CountryModel] = result.map({ (listDictionary) -> CountryModel in
                        let code = listDictionary["code"] as? String ?? ""
                        let name = listDictionary["name"] as? String ?? ""
                        
                        let country = CountryModel(id: 1, name: name, code: code)
                        
                        return country
                    })
                    
                    UserDefaults.standard.set(1, forKey: "setCall")
                    
                    clousure(nil, countryList)
                    
                } catch let error as JSONError {
                    print(error.rawValue)
                } catch let error as NSError {
                    print("Error JSON: \(error)")
                    clousure(error, nil)
                    return
                }
            }
            searchTask.resume()
        }
    }
}
