//
//  ViewController.swift
//  formula one weather
//
//  Created by Brian Patterson on 15/02/2019.
//  Copyright © 2019 Brian Patterson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var raceTextField: UITextField!
    
    
    let races = ["Melbourne", "Manama", "Shanghai", "Baku",
                 "Barcelona", "Monaco", "Montreal","Le Castellet","Spielberg",
                 "Silverstone","Hockenheim","Budapest","Francorchamps","Monza","Singapore","Sochi","Suzuka","Austin","Interlagos","Abu Dhabi"]
    var selectedRace: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createRacesPicker()
        createToolbar()
    }
    
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "getWeather", sender: self)
    }
    
    func createRacesPicker() {
        let racePicker = UIPickerView()
        racePicker.delegate = self
        raceTextField.inputView = racePicker
    }
    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ViewController.dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        raceTextField.inputAccessoryView = toolBar
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
//MARK: - UIPickerView Delegate extension
/***************************************************************/
//UIPickerView here
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return races.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return races[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRace = races[row]
        raceTextField.text = selectedRace
    }
    //Write the PrepareForSegue Method here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "getWeather" {
            let weatherVC = segue.destination as! WeatherViewController
            
            weatherVC.city = raceTextField.text!
        }
    }
}
