//
//  CountryListTableViewCell.swift
//  Country List
//
//  Created by rahman fad on 13/05/18.
//  Copyright © 2018 rahman fad. All rights reserved.
//

import UIKit

class CountryListTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var countryNameLabel: UILabel!
    @IBOutlet weak private var countryCodeView: UIView!
    @IBOutlet weak private var countryCodeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configurationView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configurationLabel(_ countryName: String = "", countryCode: String = ""){
        countryNameLabel.text = countryName
        countryCodeLabel.text = countryCode
    }
    
    private func configurationView(){
        countryCodeView.layer.cornerRadius = 10
    }
    
}
