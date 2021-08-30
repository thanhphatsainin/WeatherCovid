//
//  TableViewCellMarkWeather.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/23/21.
//

import UIKit

class TableViewCellMarkWeather: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var timeLB: UILabel!
    @IBOutlet weak var mainLB: UILabel!
    @IBOutlet weak var humidityLB: UILabel!
    @IBOutlet weak var speedLB: UILabel!
    @IBOutlet weak var tempLB: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var city: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func khoitaoDoC(item: WeatherDetail) {
        let urlString = "http://openweathermap.org/img/wn/" + item.icon! + ".png"
        
        if let url = URL(string: urlString) {
            self.img.setImage(from: url)
        }
        
        // thoi gian
        let dateFormatCoordinate = DateFormatter()
        dateFormatCoordinate.dateFormat = "EEEE yyyy-MM-dd HH:mm:ss"
        let time = item.time
        let timeInterval = TimeInterval(time)
        let date = NSDate( timeIntervalSince1970: timeInterval)
        self.timeLB.text = dateFormatCoordinate.string(from: date as Date)
        
        self.mainLB.text = item.main
        self.humidityLB.text = String(item.humidity) + "%"
        self.tempLB.text = String(round(item.temp - 273)) + "°C"
        self.speedLB.text = String(item.speed) + " m/s"
        self.city.text = item.city
    }
    
    func khoitaoDoF(item: WeatherDetail) {
        let urlString = "http://openweathermap.org/img/wn/" + item.icon! + ".png"
        
        if let url = URL(string: urlString) {
            self.img.setImage(from: url)
        }
        
        // thoi gian
        let dateFormatCoordinate = DateFormatter()
        dateFormatCoordinate.dateFormat = "EEEE yyyy-MM-dd HH:mm:ss"
        let time = item.time
        let timeInterval = TimeInterval(time)
        let date = NSDate( timeIntervalSince1970: timeInterval)
        self.timeLB.text = dateFormatCoordinate.string(from: date as Date)
        
        self.mainLB.text = item.main
        self.humidityLB.text = String(item.humidity) + "%"
        self.tempLB.text = String(round(item.temp)) + "°F"
        self.speedLB.text = String(item.speed) + " m/s"
        self.city.text = item.city
    }
}
