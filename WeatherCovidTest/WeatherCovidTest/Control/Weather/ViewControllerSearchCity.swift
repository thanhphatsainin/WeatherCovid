//
//  ViewControllerSearchCity.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/22/21.
//

import UIKit

protocol SearchCity {
    func sendCity(city : CityWorld)
}

class ViewControllerSearchCity: UIViewController {

    @IBOutlet weak var searchCitySearchBar: UISearchBar!
    @IBOutlet weak var listCityTableView: UITableView!
    private let refreshControl = UIRefreshControl()
    
    var allLocation : [CityWorld] = []
    var listCitySearch = [CityWorld]()
    private var isLoading = false
    var delegateSearchCity : SearchCity?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchCitySearchBar.becomeFirstResponder()
    }
    
    func setup() {
        searchCitySearchBar.delegate = self
        listCityTableView.dataSource = self
        listCityTableView.delegate = self
        allLocation = ReadDateCity.shared.loadLocationFromCSV()
        listCitySearch = allLocation
        
        refreshControl.attributedTitle = NSAttributedString()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        listCityTableView.addSubview(refreshControl)
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        guard let name = searchCitySearchBar.searchTextField.text else {
            return
        }
        if !isLoading {
            isLoading = true
            searchName(nameCity: name)
            refreshControl.endRefreshing()
        }
    }
    
    func searchName(nameCity : String){
        listCitySearch.removeAll()
        if nameCity.isEmpty {
            listCitySearch = allLocation
        } else {
            for cityWorld in allLocation {
                if cityWorld.city.contains(nameCity) {
                    listCitySearch.append(cityWorld)
                }
            }
        }
        listCityTableView.reloadData()
    }
    
    @IBAction func clickCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ViewControllerSearchCity : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCitySearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellListCity")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellListCity")
        }
        let item = listCitySearch[indexPath.row]
        cell?.textLabel?.text = item.city
        cell?.detailTextLabel?.text = item.country
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegateSearchCity?.sendCity(city: listCitySearch[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ViewControllerSearchCity : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let name = searchBar.searchTextField.text else {
            return
        }
        searchName(nameCity: name)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        guard let name = searchBar.searchTextField.text else {
            return
        }
        
        if !isLoading {
            isLoading = true
            searchName(nameCity: name)
        }
    }
}
