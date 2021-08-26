//
//  ViewControllerSettingTemp.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/23/21.
//

import UIKit

protocol SettingTemp {
    func sendIndexTemp(index : Int)
}

class ViewControllerSettingTemp: UIViewController {
    @IBOutlet weak var settingTempTableView: UITableView!
    
    var delegateSettingTemp : SettingTemp?
    var currentIndexTempFormat: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTempTableView.delegate = self
        settingTempTableView.dataSource = self
        loadTempFormatFromUserDefaults()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadTempFormatFromUserDefaults()
    }
    
    private func updateTempFormatInUserDefaults(newValue: Int) {
        UserDefaults.standard.set(newValue,forKey: KEY_TEMP_FORMAT)
    }
    
    private func loadTempFormatFromUserDefaults() {
        if let indexTempFormat = UserDefaults.standard.value(forKey: KEY_TEMP_FORMAT) as? Int {
            currentIndexTempFormat = indexTempFormat
        }
        else {
            currentIndexTempFormat = 0
        }
    }
}

extension ViewControllerSettingTemp : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TempFormat.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSettingTemp", for: indexPath)
        let cellText = TempFormat.allCases[indexPath.row].rawValue.components(separatedBy: " ")
        cell.textLabel?.text = cellText[0]
        cell.detailTextLabel?.text = cellText[1]
        if indexPath.row == currentIndexTempFormat {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.visibleCells.forEach { (cell) in
            cell.accessoryType = .none
        }
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        if indexPath.row != currentIndexTempFormat {
            updateTempFormatInUserDefaults(newValue: indexPath.row)
            delegateSettingTemp?.sendIndexTemp(index: indexPath.row)
            self.dismiss(animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

