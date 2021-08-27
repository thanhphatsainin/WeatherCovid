//
//  ViewControllerListCovidCountry.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/19/21.
//

import UIKit

class ViewControllerListCovidCountry: UIViewController {

    @IBOutlet private weak var navigation: UINavigationItem!
    @IBOutlet private weak var listCovidCountryTableView: UITableView!
    var listCovidCountryNoChange = [CovidCountry]()
    var listCovidShow = [CovidCountry]()
    var nameCountry = ""
    var isTop = false
    var date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigation.title = nameCountry
        listCovidShow = listCovidCountryNoChange
        listCovidCountryTableView.delegate = self
        listCovidCountryTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ViewControllerChoseDate {
            controller.delegateChooseDate = self
            controller.listCovidCountry = self.listCovidCountryNoChange
        }
    }


    @IBAction func actionFitlerListCovidCountry(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "showDatePicker", sender: nil)
    }
    
    //  hien thi nguoc lai danh sach
    func reverseListCovidCountry() {
        //        let image = isTop ? UIImage(systemName: "arrowtriangle.down.fill") : UIImage(systemName: "shift.fill")
        //        if isTop {
        //            reverseListCovidCountry()
        //            let image = UIImage(systemName: "shift.fill")
        //            sender.setBackgroundImage(image, for: .normal, barMetrics: .default)
        //            isTop = false
        //        }
        //        else{
        //            reverseListCovidCountry()
        //            let image = UIImage(systemName: "shift") //arrowtriangle.down.fill
        //            sender.setBackgroundImage(image, for: .normal, barMetrics: .defaultPrompt)
        //            isTop = true
        //        }
        
        listCovidShow.reverse()
        listCovidCountryTableView.reloadData()
    }
    
    func loadTableChoseDate(stringDate : String) {
        listCovidShow.removeAll()
        for i in listCovidCountryNoChange {
            if i.date.subStringTime() == stringDate {
                listCovidShow.append(i)
            }
        }
        listCovidCountryTableView.reloadData()
    }
}

extension ViewControllerListCovidCountry : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listCovidShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellListCovidCountry") as! TableViewCellListCovidCountry
        let item = listCovidShow[indexPath.row]
        cell.khoitao(item: item)
        return cell
    }
}

extension ViewControllerListCovidCountry : ChooseDate{
    func sendDate(date: Date) {
        self.date = date
        let datefomat = DateFormatter()
        datefomat.dateFormat = "yyyy-MM-dd"
        let stringDate = datefomat.string(from: date)
        print(stringDate)
        loadTableChoseDate(stringDate: stringDate)
    }
}
