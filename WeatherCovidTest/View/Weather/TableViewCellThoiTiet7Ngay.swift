//
//  TableViewCellThoiTiet7Ngay.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/22/21.
//

import UIKit

class TableViewCellThoiTiet7Ngay: UITableViewCell {

    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var tempLable: UILabel!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    func khoitaoTempC(listData :  ListData) {
        view.layer.cornerRadius = view.frame.height/3
        let dateFormatCoordinate = DateFormatter()
        dateFormatCoordinate.dateFormat = "EEEE"
        let time = listData.ts
        let timeInterval = TimeInterval(time)
        let date = NSDate( timeIntervalSince1970: timeInterval)
        dateLable.text = dateFormatCoordinate.string(from: date as Date)
        
        iconImage.image = UIImage(named: listData.weather.icon)
        tempLable.text = String(Int(round(listData.temp))) + "°C"
    }
    
    func khoitaoTempF(listData :  ListData) {
        view.layer.cornerRadius = view.frame.height/3
        let dateFormatCoordinate = DateFormatter()
        dateFormatCoordinate.dateFormat = "EEEE"
        let time = listData.ts
        let timeInterval = TimeInterval(time)
        let date = NSDate( timeIntervalSince1970: timeInterval)
        dateLable.text = dateFormatCoordinate.string(from: date as Date)
        
        iconImage.image = UIImage(named: listData.weather.icon)
        tempLable.text = String(Int(round(listData.temp + 273))) + "°F"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
