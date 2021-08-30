//
//  ViewControllerWeather.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/19/21.
//

import UIKit

class ViewControllerWeather: UIViewController {

    @IBOutlet weak var cityLable: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLable: UILabel!
    @IBOutlet weak var speedWindLable: UILabel!
    @IBOutlet weak var thoiTiet7NgayTableView: UITableView!
    
    private let repositoryAPIWeather = RepositoryAPIWeather()
    var thoitiet = ThoiTiet()
    var thoitiet3H6Day = ThoiTiet3H6Day()
    var thoitiet7Ngay = ThoiTiet7Ngay()
    var city = CityWorld(city: "Nam Định", lat: "20.4200", lon: "106.1683", country: "Vietnam", countryCode: "", adminCity: "", isCurrentLocation: false)
    var indexTemp = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadAPI()
    }
    
    func setup() {
        thoiTiet7NgayTableView.dataSource = self
        thoiTiet7NgayTableView.delegate = self
        indexTemp = UserDefaults.standard.value(forKey: KEYTEMPFORMAT) as? Int ?? 0
    }
    
    private func loadAPI() {
        let dispatchGroup = DispatchGroup()
        let lat = Double(city.lat) ?? 0
        let lon = Double(city.lon) ?? 0
        dispatchGroup.enter()
        repositoryAPIWeather.getThoiTietByLocate(lat: lat, lon: lon) { result in
            switch result {
            case .success(let thoitiet):
                self.thoitiet = thoitiet
                dispatchGroup.leave()
            case .failure(.badURL):
                print("error!")
            }
        }
        
        dispatchGroup.enter()
        repositoryAPIWeather.getThoiTiet7Ngay(lat: lat, lon: lon) { result in
            switch result {
            case .success(let thoitiet7Ngay):
                self.thoitiet7Ngay = thoitiet7Ngay
                dispatchGroup.leave()
            case .failure(.badURL):
                print("error!")
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.loadData()
            self.thoiTiet7NgayTableView.reloadData()
        }
    }
    
    func loadData() {
        self.cityLable.text = city.city
        self.countryLabel.text = city.country
        
//        self.cityLable.text = thoitiet.name
//        self.countryLabel.text = thoitiet.sys.country
        
        if thoitiet.weather.isEmpty {
            let alter = UIAlertController(title: "Thong bao", message: "Thanh Pho KHong co du lieu!", preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "OK", style: .default) { (_) in
            }
            alter.addAction(actionOk)
            self.present(alter, animated: true, completion: nil)
        } else {
            let urlString = "http://openweathermap.org/img/wn/" + thoitiet.weather[0].icon + ".png"
            if let url = URL(string: urlString) {
                self.iconImage.setImage(from: url)
            }
            self.mainLabel.text = thoitiet.weather[0].main
            if indexTemp == 0 {
                self.tempLabel.text = String(Int(round(thoitiet.main.temp - 273))) + "°C"
            } else {
                self.tempLabel.text = String(Int(round(thoitiet.main.temp))) + "°F"
            }
            
            self.humidityLable.text = String(thoitiet.main.humidity) + "%"
            self.speedWindLable.text = String(thoitiet.wind.speed) + " m/s"

            // thoi gian
            let dateFormatCoordinate = DateFormatter()
            dateFormatCoordinate.dateFormat = "EEEE yyyy-MM-dd HH:mm:ss"
            let time = thoitiet.dt
            let timeInterval = TimeInterval(time)
            let date = NSDate( timeIntervalSince1970: timeInterval)
            self.dateLabel.text = dateFormatCoordinate.string(from: date as Date)
        }
    }
    
    @IBAction func clickSettingTemp(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "chuyenMHSettingTemp", sender: nil)
    }
    
    @IBAction func clickChoseCity(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "showMHSearchCity", sender: nil)
    }
    
    @IBAction func clickSeeDetails(_ sender: UIButton) {
        if let MHSeeDetails = self.storyboard?.instantiateViewController(identifier: "MHSeeDetails") as? ViewControllerSeeDetail7Ngay {
            MHSeeDetails.city = self.city
            self.navigationController?.pushViewController(MHSeeDetails, animated: true)
        } else {
            print("Error click See Detail")
        }
    }
    
    func api1() {
        repositoryAPIWeather.getThoiTietByLocate(lat: 20.4200, lon: 106.1683) { result in
            switch result {
            case .success(let thoitiet):
                self.thoitiet = thoitiet
                dump(self.thoitiet)
            case .failure(.badURL):
                print("error!")
            }
        }
    }
    
    func api2() {
        repositoryAPIWeather.getThoiTiet7Ngay(lat: 20.4200, lon: 106.1683) { result in
            switch result {
            case .success(let thoitiet7Ngay):
                self.thoitiet7Ngay = thoitiet7Ngay
                dump(self.thoitiet7Ngay)
            case .failure(.badURL):
                print("error!")
            }
        }
    }
    
    func api3() {
        repositoryAPIWeather.getThoiTiet3H6Day(lat: 20.4200, lon: 106.1683) { result in
            switch result {
            case .success(let thoitiet3H6Day):
                self.thoitiet3H6Day = thoitiet3H6Day
                dump(self.thoitiet3H6Day)
            case .failure(.badURL):
                print("error!")
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension ViewControllerWeather : UITableViewDelegate, UITableViewDataSource {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ViewControllerSearchCity {
            controller.delegateSearchCity = self
        }
        
        if let controller = segue.destination as? ViewControllerSettingTemp {
            controller.delegateSettingTemp = self
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thoitiet7Ngay.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cellThoiTiet7Ngay") as? TableViewCellThoiTiet7Ngay {
            if indexTemp == 0 {
                cell.khoitaoTempC(listData: thoitiet7Ngay.data[indexPath.row])
            } else {
                cell.khoitaoTempF(listData: thoitiet7Ngay.data[indexPath.row])
            }
            return cell
        } else {
            print("DequeueReusableCell failed while casting")
        }
        return UITableViewCell()
    }
}

extension ViewControllerWeather : SearchCity, SettingTemp {
    func sendCity(city: CityWorld) {
        self.city = city
        self.loadAPI()
    }
    
    func sendIndexTemp(index: Int) {
        self.indexTemp = index
        print(indexTemp)
        self.loadAPI()
    }
}
