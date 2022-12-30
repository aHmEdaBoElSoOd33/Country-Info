//
//  ViewController.swift
//  Country Info
//
//  Created by Muhamed Alkhatib on 26/08/2020.
//

import UIKit
import CoreLocation


class ViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var currntLocationHandel: UILabel!
    @IBOutlet weak var googleMapBtn: UIButton!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var regionLbl: UILabel!
    @IBOutlet weak var countryCapital: UILabel!
    @IBOutlet weak var searchTxtFeild: UITextField!
    @IBOutlet weak var countryName: UILabel!
    
    
    
    //MARK: - Variables
    var mapLink1 : String = ""
    var currentLocation = ""
    var locationManager = CLLocationManager()
    var countryApi = CountryApi()
    var geocoder = CLGeocoder()
    var countriesArray : [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryApi.delegate=self
        searchTxtFeild.delegate = self
        locationManager.delegate=self
        
        hideKeyboardWhenTappedAround()
        
        googleMapBtn.isHidden = true
        currntLocationHandel.isHidden = true
    }
    
//MARK: - Functions
    
    func updateUI (){
        let searchTxt = searchTxtFeild.text!
        var fetchedSearch = ""
        for i in searchTxt{
            if i == "." || i == " "{
                continue
            }else {
                fetchedSearch += String(i)
            }
            
        }
        countryApi.fetchData(country: fetchedSearch)
    }
    
    
    func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    
    
//MARK: - IBAction
    
    
    @IBAction func googleMapBtn(_ sender: Any) {
       let vc = self.storyboard?.instantiateViewController(withIdentifier: "GoogleMapsVC") as! GoogleMapsVC
        vc.mapLink = (countriesArray.last?.maps.googleMaps)!
        present(vc, animated: true)
    }
    
    
    
    @IBAction func locationBtn(_ sender: Any) {
       
        searchTxtFeild.text = "Your Location"
        currntLocationHandel.isHidden = false
        currntLocationHandel.text = "It may takes few seconds"
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        googleMapBtn.isHidden = false
    }
    
    @IBAction func searchBtn(_ sender: Any) {
        currntLocationHandel.isHidden = true
        updateUI()
        googleMapBtn.isHidden = false
    }
}

//MARK: - Extintions

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateUI()
        return true
    }
}
extension ViewController : CountryApiDelegate {
    func didFetchData(country: Country) {
        countriesArray.append(country)
        print(country)
         print(country.maps.googleMaps)
        DispatchQueue.main.async {
           
            if country.name.common.lowercased() == "israel" {
                self.currntLocationHandel.isHidden = false
                self.currntLocationHandel.text = "do you mean Palestine?"
                self.countryName.text = "Not found"
                self.countryCapital.text = "Not found"
                self.regionLbl.text = "Not found"
                self.population.text = "Not found"
                self.googleMapBtn.isHidden = true
                //self.mapLink1 = country.maps.googleMaps
                 
            }else if country.name.common.lowercased() == "palestine"{
                self.countryName.text = country.name.common
                self.countryCapital.text = "Jerusalem"
                self.regionLbl.text = country.region
                self.population.text = "\(country.population)"
                self.mapLink1 = country.maps.googleMaps
                 
            }else{
                
                self.countryName.text = country.name.common
                self.countryCapital.text = country.capital[0]
                self.regionLbl.text = country.region
                self.population.text = "\(country.population)"
                self.mapLink1 = country.maps.googleMaps
            }
        }
    }
}
extension ViewController: CLLocationManagerDelegate  {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
     
         geocoder.reverseGeocodeLocation(location) { place, error in
           
             DispatchQueue.main.async {
                 self.currentLocation = (place?.last?.country!)!
                self.countryApi.fetchData(country: self.currentLocation)
             }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
