//
//  TableViewCellSeeDetails7Ngay.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/22/21.
//

import UIKit

class TableViewCellSeeDetails7Ngay: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var timeLB: UILabel!
    @IBOutlet weak var mainLB: UILabel!
    @IBOutlet weak var humidityLB: UILabel!
    @IBOutlet weak var speedLB: UILabel!
    @IBOutlet weak var tempLB: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var markButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func khoitaoDoC(item : Weather2?) {
        guard let item = item else {
            return
        }
        let urlString = "http://openweathermap.org/img/wn/" + item.weather[0].icon + ".png"
        
        if let url = URL(string: urlString) {
            self.img.setImage(from: url)
        }
        
        // thoi gian
        let dateFormatCoordinate = DateFormatter()
        dateFormatCoordinate.dateFormat = "EEEE yyyy-MM-dd HH:mm:ss"
        let time = item.dt
        let timeInterval = TimeInterval(time)
        let date = NSDate( timeIntervalSince1970: timeInterval)
        self.timeLB.text = dateFormatCoordinate.string(from: date as Date)
        
        self.mainLB.text = item.weather[0].main
        self.humidityLB.text = String(item.main.humidity) + "%"
        self.tempLB.text = String(round(item.main.temp - 273)) + "°C"
        self.speedLB.text = String(item.wind.speed) + " m/s"
    }
    
    func khoitaoDoF(item : Weather2?) {
        guard let item = item else {
            return
        }
        let urlString = "http://openweathermap.org/img/wn/" + item.weather[0].icon + ".png"
        
        if let url = URL(string: urlString) {
            self.img.setImage(from: url)
        }
        
        // thoi gian
        let dateFormatCoordinate = DateFormatter()
        dateFormatCoordinate.dateFormat = "EEEE yyyy-MM-dd HH:mm:ss"
        let time = item.dt
        let timeInterval = TimeInterval(time)
        let date = NSDate( timeIntervalSince1970: timeInterval)
        self.timeLB.text = dateFormatCoordinate.string(from: date as Date)
        
        self.mainLB.text = item.weather[0].main
        self.humidityLB.text = String(item.main.humidity) + "%"
        self.tempLB.text = String(round(item.main.temp)) + "°F"
        self.speedLB.text = String(item.wind.speed) + " m/s"
    }

    
    @IBAction func clickMarkButton(_ sender: UIButton) {
//        sender.addTarget(self, action: #selector(self.goodieButton(sender:)), for: .touchUpInside)
    }
}
