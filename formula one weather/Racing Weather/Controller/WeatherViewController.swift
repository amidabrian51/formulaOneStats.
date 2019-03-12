//
//  WeatherViewController.swift
//  formula one weather
//
//  Created by Brian Patterson on 20/02/2019.
//  Copyright © 2019 Brian Patterson. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController {
    
    //constants
    let weatherDataModel = WeatherDataModel()
    
    var city = ""
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //var isCelsius : Bool = true
    

    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "8a99df7bf7ef4a4a202732c392b2d240"

    override func viewDidLoad() {
        super.viewDidLoad()
        cityLabel.text = city
        userEnteredNewCityName(city: city)
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    func getWeatherData(url: String, parameters: [String : String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success we got the weather data!")
                let weatherJSON : JSON = JSON(response.result.value!)
                 print(weatherJSON)
                self.updateWeatherData(json: weatherJSON)
                
            } else {
                print("Error \(String(describing: response.result.error))")
                //self because of the closure.  Therefore you have to specify the function.
                self.cityLabel.text = "Connection Issues"
            }
            
        }
    }
    
    //MARK: - JSON Parsing
    /***************************************************************/
    //updateweatherdata method here
    
    func updateWeatherData(json: JSON) {
        if let tempResult = json["main"]["temp"].double {
            weatherDataModel.temperature = Int(tempResult - 273)
            weatherDataModel.city = json["name"].stringValue
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            weatherDataModel.description = json["weather"][0]["description"].stringValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeathericon(condition: weatherDataModel.condition)
            
            updateUIWithWeatherData()
        } else {
            cityLabel.text = "No data available"
        }
        
    }
    
    func userEnteredNewCityName(city: String){
        let params : [String : String] = ["q" : city, "appid" : APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: params)
    }
     
     //Write the updateUIWithWeatherData method here:
 
    
    func updateUIWithWeatherData() {
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = "\(weatherDataModel.temperature)℃"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        descriptionLabel.text = weatherDataModel.description
    }
    
   
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
