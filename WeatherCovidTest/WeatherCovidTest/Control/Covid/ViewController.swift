//
//  ViewController.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/19/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak private var infectedWorldLable: UILabel!
    @IBOutlet weak private var deathWorldLable: UILabel!
    @IBOutlet weak private var recoveredWorldLable: UILabel!
    @IBOutlet weak private var nameCountryTF: UITextField!
    @IBOutlet weak private var dateCountryLable: UILabel!
    @IBOutlet weak private var infectedCoutryLable: UILabel!
    @IBOutlet weak private var deathCoutryLable: UILabel!
    @IBOutlet weak private var recoveredCoutryLable: UILabel!
    
    let repositoryAPI = RepositoryAPI()
    private var listCountry = [Country]()
    private var globalstate = GlobalState()
    private var listCovidCountry = [CovidCountry]()
    private var country = Country(name: "Cuba", slug: "cuba", ios: "CU")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        loadAPI()
    }
    
    func setUp() {
        nameCountryTF.text = country.name
        nameCountryTF.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadAPI()
    }
    
    private func loadAPI() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        repositoryAPI.getCovidGlobal { result in
            switch result {
            case .success(let globalstate):
                self.globalstate = globalstate
//                dump(self.globalstate)
                dispatchGroup.leave()
            case .failure(.badURL):
                print("error!")
            }
        }
        
        dispatchGroup.enter()
        repositoryAPI.getCovidCountry(slug : country.slug) { result in
            switch result {
            case .success(let listCovidCountry):
                self.listCovidCountry = listCovidCountry
//                dump(self.listCovidCountry)
                dispatchGroup.leave()
            case .failure(.badURL):
                print("error!")
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.loadData()
        }
    }
    
    private func loadData() {
        infectedWorldLable.text  = self.globalstate.global.totalConfirmed.format()
        deathWorldLable.text     = self.globalstate.global.totalDeaths.format()
        recoveredWorldLable.text = self.globalstate.global.totalRecovered.format()
        
        if !listCovidCountry.isEmpty  {
            let covidCountry = self.listCovidCountry[listCovidCountry.count-1]
            dateCountryLable.text     = covidCountry.date.subStringTime()
            infectedCoutryLable.text  = covidCountry.confirmed.format()
            deathCoutryLable.text     = covidCountry.deaths.format()
            recoveredCoutryLable.text = covidCountry.recovered.format()
            nameCountryTF.text        = covidCountry.country
        } else {
            infectedCoutryLable.text  = "0"
            deathCoutryLable.text     = "0"
            recoveredCoutryLable.text = "0"
        }
    }
    
    func api1() {
        repositoryAPI.getListCountry { result in
            switch result {
            case .success(let listCountry):
                self.listCountry = listCountry
                dump(self.listCountry)
            case .failure(.badURL):
                print("error!")
            }
        }
    }
    
    func api2() {
        repositoryAPI.getCovidGlobal { result in
            switch result {
            case .success(let globalstate):
                self.globalstate = globalstate
                dump(self.globalstate)
            case .failure(.badURL):
                print("error!")
            }
        }
    }
    
    func api3() {
        repositoryAPI.getCovidCountry(slug : "cuba") { result in
            switch result {
            case .success(let listCovidCountry):
                self.listCovidCountry = listCovidCountry
                dump(self.listCovidCountry)
            case .failure(.badURL):
                print("error!")
            }
        }
    }

    @IBAction func clickShowListCountry(_ sender: Any) {
        if let MHLISTCOUNTRY = storyboard?.instantiateViewController(identifier: "MHLISTCOUNTRY") as? ViewControllerListCountry {
            MHLISTCOUNTRY.delegateChooseCountry = self
            self.navigationController?.pushViewController(MHLISTCOUNTRY, animated: true)
        } else {
            print("Error click ShowListCountry")
        }
    }
    
    @IBAction func clickSeeDetail(_ sender: Any) {
        if let MHLISTCOVIDCOUNTRY = storyboard?.instantiateViewController(identifier: "MHLISTCOVIDCOUNTRY") as? ViewControllerListCovidCountry {
            MHLISTCOVIDCOUNTRY.nameCountry = nameCountryTF.text ?? "Cuba"
            MHLISTCOVIDCOUNTRY.listCovidCountryNoChange = self.listCovidCountry
            self.navigationController?.pushViewController(MHLISTCOVIDCOUNTRY, animated: true)
        } else {
            print("Error click SeeDetail")
        }
    }
}

extension ViewController : ChooseCountry {
    func sendCountry(country: Country) {
        self.country = country
        self.nameCountryTF.text = country.name
        dump(country)
        loadAPI()
    }
}
