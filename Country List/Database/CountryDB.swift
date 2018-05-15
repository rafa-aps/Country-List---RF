//
//  CountryDB.swift
//  Country List
//
//  Created by rahman fad on 13/05/18.
//  Copyright © 2018 rahman fad. All rights reserved.
//

//import Foundation
import SQLite

class CountryDB {
    
    static let instance = CountryDB()
    
    private var db: Connection?

    private let country = Table("country")
    private let id = Expression<Int64>("id")
    private let name = Expression<String?>("name")
    private let code = Expression<String>("code")
    
    private init() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        
        do {
            db = try Connection("\(path)/Stephencelis.sqlite3")
        } catch {
            db = nil
            print ("Unable to open database")
        }
        
        createTable()
    }

    
    func createTable() {
        do {
            try db!.run(country.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(name)
                table.column(code, unique: true)
            })
        } catch {
            print("Unable to create table")
        }
    }
    
    func addCountry(cName: String, cCode: String) -> Bool {
        do {
            let insert = country.insert(name <- cName, code <- cCode)
            try db!.run(insert)
            
            return true
        } catch {
            print("Insert failed")
            return false
        }
    }
    
    func getCountry() -> [CountryModel] {
        var country = [CountryModel]()
        
        do {
            for countryList in try db!.prepare(self.country) {
                country.append(CountryModel(
                    id: countryList[id],
                    name: countryList[name]!,
                    code: countryList[code]))
            }
        } catch {
            print("Select failed")
        }
        
        return country
    }
    
}
