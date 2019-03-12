//
//  seasonViewController.swift
//  Racing Weather
//
//  Created by Brian Patterson on 03/03/2019.
//  Copyright © 2019 Brian Patterson. All rights reserved.
//

import UIKit

class seasonViewController: UIViewController {
    
    
    @IBOutlet weak var seasonTextField: UITextField!
    
    let seasons = ["1950","1951","1952","1953","1954","1955","1956","1957"]
    var selectedSeason: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        createSeasonPicker()
        createToolBar()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendDataButton(_ sender: Any) {
        performSegue(withIdentifier: "getStanding", sender: self)
    }
    
    func createSeasonPicker() {
        let seasonPicker = UIPickerView()
        seasonPicker.delegate = self
        seasonTextField.inputView = seasonPicker
    }
    
    func createToolBar() {
    let toolBar = UIToolbar()
    toolBar.sizeToFit()
    let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ViewController.dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        seasonTextField.inputAccessoryView = toolBar
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}
extension seasonViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return seasons.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return seasons[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedSeason = seasons[row]
        seasonTextField.text = selectedSeason
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "getStanding" {
            let standingVC = segue.destination as! StandingViewController
            
            standingVC.standing = seasonTextField.text!
            
        }
    }
    
}
