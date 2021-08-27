//
//  ViewControllerSave.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/19/21.
//

import UIKit
import UserNotifications
import CoreData

class ViewControllerSave: UIViewController {

    @IBOutlet weak var markWeatherTableView: UITableView!
    @IBOutlet weak var notificationSegment: UISegmentedControl!
    
    private let repositoryAPIWeather = RepositoryAPIWeather()
    var thoitiet3H6Day = ThoiTiet3H6Day()
    var city = CityWorld(city: "Nam Định", lat: "20.4200", lon: "106.1683", country: "Vietnam", countryCode: "", adminCity: "", isCurrentLocation: false)
    var indexTemp = 0
    var indexMark = 0
    var arrayWeatherDetailData : [WeatherDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        markWeatherTableView.dataSource = self
        markWeatherTableView.delegate = self
        setup()
        
//        let a = currentTimeInMilliSeconds()
//        print(a)
//        let dateFormatCoordinate = DateFormatter()
//        dateFormatCoordinate.dateFormat = "EEEE yyyy-MM-dd HH:mm:ss"
//        let timeInterval = TimeInterval(a)
//        let date = NSDate(timeIntervalSince1970: timeInterval)
//        print(dateFormatCoordinate.string(from: date as Date))
    }
    
    func setup() {
        indexTemp = UserDefaults.standard.value(forKey: KEY_TEMP_FORMAT) as! Int
        showListWeatherDetail()
        notification(index: indexMark)
        checkSegment()
    }
    
    func currentTimeInMilliSeconds()-> Int
    {
            let currentDate = Date()
            let since1970 = currentDate.timeIntervalSince1970
            return Int(since1970)
    }
    
    func checkExpires(weatherDetail : WeatherDetail) -> Bool{
        let currentTime = currentTimeInMilliSeconds()
        if Int(weatherDetail.time) >= currentTime {
            return true
        }
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        showListWeatherDetail()
        setup()
        markWeatherTableView.reloadData()
    }
    
    func notification(index : Int) {
        NotificationLocal.shared.clear()
        for i in arrayWeatherDetailData {
//            print("ok : \(i.time)")
            NotificationLocal.shared.create(title: "Sự kiện sắp diễn ra", body: i.city ?? "", time: CLong(i.time), index: index)
        }
    }
    
    @IBAction func clickSegmentNotifi(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        let index = sender.selectedSegmentIndex
        switch index {
        case 0:
            notification(index: 0)
            indexMark = 0
        case 1:
            notification(index: 1)
            indexMark = 1
        case 2:
            notification(index: 2)
            indexMark = 2
        default:
            notification(index: 0)
            indexMark = 0
        }
        UserDefaults.standard.set(indexMark, forKey: KEY_MARK_WEATHER)
        checkSegment()
    }
    
    func checkSegment() {
        let index = UserDefaults.standard.integer(forKey: KEY_MARK_WEATHER)
        switch index {
        case 0:
            notification(index: 0)
            indexMark = 0
            notificationSegment.selectedSegmentIndex = 0
        case 1:
            notification(index: 1)
            indexMark = 1
            notificationSegment.selectedSegmentIndex = 1
        case 2:
            notification(index: 2)
            indexMark = 2
            notificationSegment.selectedSegmentIndex = 2
        default:
            notification(index: 0)
            indexMark = 0
            notificationSegment.selectedSegmentIndex = 0
        }
    }
    //------- core data
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
                if checkExpires(weatherDetail: s) {
                    arrayWeatherDetailData.append(s)
                }
            }
        }else{
            print("Error!")
        }
    }
    
    func updateWeatherDetail() {
        //lay persistentContainer
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let container = appDelegate.persistentContainer
        
        // lay context du lieu
        let context = container.viewContext
        
        // tim student
        //tao truy van (request) du lieu
        let request = NSFetchRequest<WeatherDetail>(entityName: "WeatherDetail")
        let time = 1
        request.predicate = NSPredicate(format: "time == %@", time)
        let weatherDetails = try? context.fetch(request)
        
        //update student
        if let weatherDetails = weatherDetails{
            for w in weatherDetails{
                w.time = 1
            }
        }
        
        //save du lieu
        if let _ = try? context.save(){
            print("Update succses!")
        }
        else{
            print("Update false!")
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
    //------

}

extension ViewControllerSave : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayWeatherDetailData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMarkWeather") as! TableViewCellMarkWeather
        if indexTemp == 0 {
            cell.khoitaoDoC(item: arrayWeatherDetailData[indexPath.row])
        }
        else{
            cell.khoitaoDoF(item: arrayWeatherDetailData[indexPath.row])
        }
        cell.backgroundColor = UIColor.white
        cell.clipsToBounds = true
        cell.view.layer.cornerRadius = cell.view.frame.height/3
        cell.img.layer.cornerRadius = cell.img.frame.height/3

        return cell
    }
    
    // ham de Delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [self] (action, view, nil) in
            deleteWeatherDetail(index: indexPath.row)
            arrayWeatherDetailData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .middle)
            self.markWeatherTableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [delete])
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

