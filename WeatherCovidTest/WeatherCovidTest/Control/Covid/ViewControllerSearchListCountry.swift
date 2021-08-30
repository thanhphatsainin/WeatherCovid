//
//  ViewControllerSearchListCountry.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/20/21.
//

import UIKit

class ViewControllerSearchListCountry: UIViewController {

    @IBOutlet weak var searchListCountry: UISearchBar!
    @IBOutlet weak var listCountryTableView: UITableView!
    private let refreshControl = UIRefreshControl()
    
    var listCountry = [Country]()
    var listCountrySearch = [Country]()
    private var isLoading = false
    var delegateChooseCountry : ChooseCountry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboard() // k co cung dc
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchListCountry.becomeFirstResponder()
    }
    
    private func setUp() {
        searchListCountry.delegate = self
        listCountryTableView.dataSource = self
        listCountryTableView.delegate = self
        
        refreshControl.attributedTitle = NSAttributedString()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        listCountryTableView.addSubview(refreshControl)
        listCountrySearch = listCountry
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        guard let name = searchListCountry.searchTextField.text else {
            return
        }
        if !isLoading {
            isLoading = true
            searchName(nameCountry: name)
            refreshControl.endRefreshing()
        }
    }
    
    func searchName(nameCountry : String) {
        listCountrySearch.removeAll()
        if nameCountry.isEmpty {
            listCountrySearch = listCountry
        } else {
            for country in listCountry {
                if country.name.contains(nameCountry) {
                    listCountrySearch.append(country)
                }
            }
        }
        listCountryTableView.reloadData()
    }
    
    @IBAction func clickCancel(_ sender: UIButton) {
//        self.dismiss(animated: true, completion: nil)
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension ViewControllerSearchListCountry : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCountrySearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "myCell")
        }
        let item = listCountrySearch[indexPath.row]
        cell?.textLabel?.text = item.name
        cell?.detailTextLabel?.text = item.slug
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let index = listCountry[indexPath.row]
//        self.delegateChooseCountry?.sendCountry(country: index)
//        self.navigationController?.popViewController(animated: true)
        if let MHCOVID = (self.navigationController?.viewControllers[0])! as? ViewController {
            MHCOVID.sendCountry(country: listCountrySearch[indexPath.row])
            self.navigationController?.popToViewController(MHCOVID, animated: true)
        } else {
            print("Error go MHCOVID")
        }
    }
}

extension ViewControllerSearchListCountry : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let name = searchBar.searchTextField.text else {
            return
        }
        searchName(nameCountry: name)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        guard let name = searchBar.searchTextField.text else {
            return
        }
        
        if !isLoading {
            isLoading = true
            searchName(nameCountry: name)
        }
    }
}
