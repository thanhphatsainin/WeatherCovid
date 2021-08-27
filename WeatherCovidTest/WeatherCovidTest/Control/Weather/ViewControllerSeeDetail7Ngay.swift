//
//  ViewControllerSeeDetail7Ngay.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/22/21.
//

import UIKit
import CoreData

class ViewControllerSeeDetail7Ngay: UIViewController {

    @IBOutlet weak var seeDetailsTableView: UITableView!
    
    @IBOutlet weak var navigationWeatherDetail: UINavigationItem!
    private let repositoryAPIWeather = RepositoryAPIWeather()
    var thoitiet3H6Day = ThoiTiet3H6Day()
    var arrayWeatherDetailData : [WeatherDetail] = []
    var city = CityWorld(city: "Nam Định", lat: "20.4200", lon: "106.1683", country: "Vietnam", countryCode: "", adminCity: "", isCurrentLocation: false)
    var indexTemp = UserDefaults.standard.value(forKey: KEY_TEMP_FORMAT) as! Int
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seeDetailsTableView.dataSource = self
        seeDetailsTableView.delegate = self
        setup()
    }
    
    func setup() {
        loadAPI()
        showListWeatherDetail()
        navigationWeatherDetail.title = "Weather Details of " + city.city
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setup()
    }
    
    private func loadAPI() {
        let dispatchGroup = DispatchGroup()
        let lat = Double(city.lat) ?? 0
        let lon = Double(city.lon) ?? 0
        
        dispatchGroup.enter()
        repositoryAPIWeather.getThoiTiet3H6Day(lat: lat, lon: lon) { result in
            switch result {
            case .success(let thoitiet3H6Day):
                self.thoitiet3H6Day = thoitiet3H6Day
                dispatchGroup.leave()
            case .failure(.badURL):
                print("error!")
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.seeDetailsTableView.reloadData()
        }
    }
    //---- core data
    func addWeatherDetail(weather2 : Weather2) {
        
        //lay persistentContainer
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let container = appDelegate.persistentContainer
        
        // lay context du lieu
        let context = container.viewContext
        
        // load mo ta du lieu student
        let description = NSEntityDescription.entity(forEntityName: "WeatherDetail", in: context)!

        //tao student
        let weatherDetail = WeatherDetail(entity: description, insertInto: context)
        weatherDetail.icon = weather2.weather[0].icon
        weatherDetail.time = Double(weather2.dt)
        weatherDetail.humidity = weather2.main.humidity
        weatherDetail.temp = weather2.main.temp
        weatherDetail.speed = weather2.wind.speed
        weatherDetail.main = weather2.weather[0].main
        weatherDetail.city = city.city
        
        //save du lieu
        if let _ = try? context.save(){
            print("Add succses!")
        }
        else{
            print("Add false!")
        }
    }
    
    // database
    func showListWeatherDetail() {
        arrayWeatherDetailData.removeAll()
        //lay persistentContainer
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let container = appDelegate.persistentContainer
        
        // lay context du lieu
        let context = container.viewContext
        
        //tao truy van (request) du lieu
        let request = NSFetchRequest<WeatherDetail>(entityName: "WeatherDetail")
        
        //truy van tu context
        if let weatherDetails = try? context.fetch(request){
//            print("Have \(weatherDetails.count) weatherDetail")
            for s in weatherDetails{
                arrayWeatherDetailData.append(s)
            }
        }else{
            print("Error!")
        }
    }
    
    func deleteWeatherDetail(index : Int) {
        //lay persistentContainer
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let container = appDelegate.persistentContainer
        
        // lay context du lieu
        let context = container.viewContext
        
        context.delete(arrayWeatherDetailData[index])
        
        //save du lieu
        if let _ = try? context.save(){
            print("Delete succses!")
        }
        else{
            print("Delete false!")
        }
    }
    //----------

}

extension ViewControllerSeeDetail7Ngay : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thoitiet3H6Day.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSeeDetails") as! TableViewCellSeeDetails7Ngay
        if indexTemp == 0 {
            cell.khoitaoDoC(item: thoitiet3H6Day.list[indexPath.row])
        }
        else{
            cell.khoitaoDoF(item: thoitiet3H6Day.list[indexPath.row])
        }
        cell.backgroundColor = UIColor.white
        cell.clipsToBounds = true
        cell.view.layer.cornerRadius = cell.view.frame.height/3
        cell.img.layer.cornerRadius = cell.img.frame.height/3
        cell.markButton.tag = indexPath.row
        
        let isMark = checkExitMark(item: thoitiet3H6Day.list[indexPath.row])
        let image = isMark ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        cell.markButton.setImage(image, for: .normal)
        cell.markButton.addTarget(self, action: #selector(tickClicked), for: .touchUpInside)
        return cell
    }
    
    @objc func tickClicked(_ sender: UIButton!) {
        showListWeatherDetail()
        let cellTop = seeDetailsTableView.cellForRow(at: NSIndexPath(row: sender.tag, section: 0) as IndexPath) as! TableViewCellSeeDetails7Ngay
        
        let isMark = checkExitMark(item: thoitiet3H6Day.list[sender.tag])
        let image = isMark ? UIImage(systemName: "heart") : UIImage(systemName: "heart.fill")
        DispatchQueue.main.async {
            cellTop.markButton.setImage(image, for: .normal)
        }
//        print(isMark)
        if !isMark {
            addWeatherDetail(weather2: thoitiet3H6Day.list[sender.tag])
        }
        else{
            let index = getIndex(item: thoitiet3H6Day.list[sender.tag])
            deleteWeatherDetail(index: index)
        }
        
        print(thoitiet3H6Day.list[sender.tag].dt)
        
    }
    
    func checkExitMark(item : Weather2) -> Bool {
        if arrayWeatherDetailData.count > 0 {
            for i in 0...arrayWeatherDetailData.count - 1{
                if item.dt ==  Int(arrayWeatherDetailData[i].time)
                && city.city == arrayWeatherDetailData[i].city {
                    return true
                }
            }
        }
        return false
    }
    
    // lay vi tri trong coredata
    func getIndex(item : Weather2) -> Int {
        for i in 0...arrayWeatherDetailData.count - 1{
            if item.dt ==  Int(arrayWeatherDetailData[i].time)
            && city.city == arrayWeatherDetailData[i].city {
                return i
            }
        }
        return 0
    }
    
    // animation
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.5, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
            },completion: { finished in
                UIView.animate(withDuration: 0.2, animations: {
                    cell.layer.transform = CATransform3DMakeScale(1,1,1)
                })
        })
    }
}

