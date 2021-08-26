//
//  ViewControllerListCountry.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/19/21.
//

import UIKit

protocol ChooseCountry{
    func sendCountry(country : Country)
}

class ViewControllerListCountry: UIViewController {

    @IBOutlet weak var listCountryTableView:
        UITableView!
    private var listCountry = [Country]()
    let repositoryAPI = RepositoryAPI()
    var delegateChooseCountry : ChooseCountry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listCountryTableView.delegate = self
        listCountryTableView.dataSource = self
        // Do any additional setup after loading the view.
        loadAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadAPI()
    }
    
    private func loadAPI() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        repositoryAPI.getListCountry { result in
            switch result {
            case .success(let listCountry):
                self.listCountry = listCountry
                dispatchGroup.leave()
            case .failure(.badURL):
                print("error!")
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
//            self.loadData()
            self.listCountryTableView.reloadData()
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let controller = segue.destination as? ViewControllerSearchListCountry {
//            controller.listCountry = listCountry    // gan gia tri cho bien item ben class DetailViewController
//        }
//    }
    
    @IBAction func clickSeachListCountry(_ sender: Any) {
//        self.performSegue(withIdentifier: "showSearchListCountry", sender: nil)
        let MHSEARCHLISTCOUNTRY = storyboard?.instantiateViewController(identifier: "MHSEARCHLISTCOUNTRY") as! ViewControllerSearchListCountry
        MHSEARCHLISTCOUNTRY.listCountry = listCountry
        self.navigationController?.pushViewController(MHSEARCHLISTCOUNTRY, animated: true)
    }
}


extension ViewControllerListCountry : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCountry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellListCountry")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellListCountry")
        }
        let item = listCountry[indexPath.row]
        cell?.textLabel?.text = item.name
        cell?.detailTextLabel?.text = item.slug
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let index = listCountry[indexPath.row]
        self.delegateChooseCountry?.sendCountry(country: index)
        self.navigationController?.popViewController(animated: true)
    }
}
