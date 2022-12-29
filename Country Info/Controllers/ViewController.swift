//
//  ViewController.swift
//  Country Info
//
//  Created by Muhamed Alkhatib on 26/08/2020.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var regionLbl: UILabel!
    @IBOutlet weak var countryCapital: UILabel!
    @IBOutlet weak var searchTxtFeild: UITextField!
    @IBOutlet weak var countryName: UILabel!
    
    //MARK: - Variables
    
    var countryApi = CountryApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTxtFeild.delegate = self
        
        
    }
//MARK: - Functions
    
    func updateUI (){
        
        countryApi.fetchData(country: searchTxtFeild.text!)
        
        
        
    }
    
    
    
    

//MARK: - IBAction
    @IBAction func locationBtn(_ sender: Any) {
        
        print("hi1")
        
    }
    @IBAction func searchBtn(_ sender: Any) {
        
        print("hi2")
        updateUI()
    }
    
}


extension ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("hi")
        updateUI()
        return true
    }
    
    
}
