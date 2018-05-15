//
//  ViewController.swift
//  Country List
//
//  Created by rahman fad on 12/05/18.
//  Copyright © 2018 rahman fad. All rights reserved.
//

import UIKit

protocol ListViewControllerOutput: class {
    func fetchList(_ search: String)
}

protocol ListViewControllerInput: class {
    func displayCountry(_ list: [CountryModel])
    func showErrorView(_ errorMessage: String)
}

class ViewController: UIViewController, ListViewControllerInput {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    private let listReuseIdentifier = "CountryListCell"
    
    var presenter: ListViewControllerOutput!
    var listOfCountry: [CountryModel] = []
    let countryDB = CountryDB.instance.getCountry()
    var reloadDataInteger: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CountryListAssembly.sharedInstance.configure(self)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CountryListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: listReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        //fungsi untuk search sudah dibuat, belum sempat implement
        performSearchText("in")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func performSearchText(_ searchText: String){
        presenter.fetchList(searchText)
    }
    
    func displayCountry(_ list: [CountryModel]){
        self.listOfCountry.append(contentsOf: list)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showErrorView(_ errorMessage: String){
        let alertView = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        
        alertView.addAction(UIAlertAction(title: okTitle, style: .default, handler: { (action) in
            alertView.dismiss(animated: true, completion: nil)
        }))
        
        present(alertView, animated: true, completion: nil)
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryDB.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: listReuseIdentifier, for: indexPath) as! CountryListTableViewCell
        
        let list = self.countryDB[indexPath.row]
        cell.configurationLabel(list.name, countryCode: list.code)
        
        return cell
    }
}

