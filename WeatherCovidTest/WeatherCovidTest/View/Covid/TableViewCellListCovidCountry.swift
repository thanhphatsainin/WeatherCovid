//
//  TableViewCellListCovidCountry.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/19/21.
//

import UIKit

class TableViewCellListCovidCountry: UITableViewCell {

    @IBOutlet weak var viewListCovidCountry: UIView!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var confirmedLable: UILabel!
    @IBOutlet weak var deathsLable: UILabel!
    @IBOutlet weak var recoveredLable: UILabel!
    @IBOutlet weak var activeLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func khoitao(item: CovidCountry) {
        viewListCovidCountry.layer.cornerRadius = viewListCovidCountry.frame.height/3
        dateLable.text = item.date.subStringTime()
        confirmedLable.text = item.confirmed.format()
        deathsLable.text = item.deaths.format()
        recoveredLable.text = item.recovered.format()
        activeLable.text = item.active.format()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
