//
//  StandingViewController.swift
//  Racing Weather
//
//  Created by Brian Patterson on 03/03/2019.
//  Copyright © 2019 Brian Patterson. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class StandingViewController: UIViewController {
    
    
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fouthLabel: UILabel!
    @IBOutlet weak var fifthLabel: UILabel!
    
    
    var standing = ""
    let standingDataModel = WeatherDataModel()
    var currentUrl = ""
    
    let SEASON_URL = "https://ergast.com/api/f1"
    //let format = ".json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yearLabel.text = standing
        userEnteredNewYear(standing: standing)
        
        
        // Do any additional setup after loading the view.
    }
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getStandingData method here:
    func getStandingData (url: String) {
//        Alamofire.request(url, method: .get).responseJSON {
//            response in
//            if response.result.isSuccess {
//                print("Success we got the data!")
//                let standingJSON : JSON = JSON(response.result.value!)
//                print(standingJSON)
//                self.updateStandingData(json: standingJSON)
//            } else {
//                print("Error \(String(describing: response.result.error))")
//                self.yearLabel.text = "Connection Issues"
//            }
//
//        }
        Alamofire.request(url, method: .get).responseData { (response) in
            if response.result.isSuccess {
                print("got JSON result")
                do{
                    if let jsonData = try JSON(data: response.data! )["MRData"]["StandingsTable"].dictionary{
                        let year = (jsonData)["season"]?.int // add to standingDataModel how to add to standingDatamodel.
                        print(year ?? "No year available")
                        self.yearLabel.text = "\(String(describing: year))"
                        if let drivers = jsonData["StandingsLists"]?[0]["DriverStandings"].array{
                            
                            for driver in drivers { // fill standingDataModel here for drivers
                                print(driver["Driver"]["givenName"],driver["Driver"]["familyName"])
                                
                            }
                        }
                    }
                }
                catch{
                    print("something failed parsing the JSON Data")
                }
            }else{
                print("No JSON result")
            }
        }
        
    }
    //Mark: JSON Parsing
    
    func updateStandingData(json: JSON) {
        if case standingDataModel.season = json["MRData"]["StandingsTable"]["season"].intValue {
            standingDataModel.firstDriver = json["MRData"]["StandingsLists"][0]["DriverStandings"][0]["Driver"]["driverId"].stringValue
            updateUIWithStandingData()
        } else {
            yearLabel.text = "No data available"
        }
    }
    
    //Mark user entered data.
    func userEnteredNewYear(standing: String) {
        currentUrl = SEASON_URL + "/" + String(standing) + "/driverstandings.json"
        getStandingData(url: currentUrl)

    }
    func updateUIWithStandingData() {
        yearLabel.text = "\(standingDataModel.season)"
        firstLabel.text = standingDataModel.firstDriver
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
     
    }
     @IBAction func getJson(_ sender: UIButton) {
     Alamofire.request("https://ergast.com/api/f1/1950/driverstandings.json").responseData { (response) in
     if response.result.isSuccess {
     print("got JSON result")
     do{
     if let jsonData = try JSON(data: response.data! )["MRData"]["StandingsTable"].dictionary{
     let year = (jsonData)["season"]?.int // add to standingDataModel
     print(year ?? "No year available")
     if let drivers = jsonData["StandingsLists"]?[0]["DriverStandings"].array{
     
     for driver in drivers { // fill standingDataModel here for drivers
     print(driver["Driver"]["givenName"],driver["Driver"]["familyName"])
     }
     }
     }
     }
     catch{
     print("something failed parsing the JSON Data")
     }
     }else{
     print("No JSON result")
     }
     }
     }
    */

}
