//
//  ViewControllerChoseDate.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/21/21.
//

import UIKit

protocol ChooseDate{
    func sendDate(date : Date)
}

class ViewControllerChoseDate: UIViewController {

    @IBOutlet weak var choseDatePicker: UIDatePicker!
    var delegateChooseDate : ChooseDate?
    var chooseDate = Date()
    var listCovidCountry = [CovidCountry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
    }
    
    func setupDatePicker() {
        let size = listCovidCountry.count
        if size > 0 {
            let minDate = listCovidCountry[0].date.subStringTime()
            let minDateFormat = DateFormatter()
            minDateFormat.dateFormat = "yyyy-MM-dd"
            let dateMin = minDateFormat.date(from: minDate)
            choseDatePicker.minimumDate = dateMin
            
            let maxDate = listCovidCountry[size-1].date.subStringTime()
            let maxDateFormat = DateFormatter()
            maxDateFormat.dateFormat = "yyyy-MM-dd"
            let dateMax = maxDateFormat.date(from: maxDate)
            choseDatePicker.maximumDate = dateMax
        }
    }
    

    @IBAction func clickDatePicker(_ sender: UIDatePicker) {
        let chooseDate = sender.date
        self.chooseDate = chooseDate
    }
    
    @IBAction func clickOk(_ sender: Any) {
        self.delegateChooseDate?.sendDate(date: chooseDate)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
