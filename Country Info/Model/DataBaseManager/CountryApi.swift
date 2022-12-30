//
//  CountryApi.swift
//  Country Info
//
//  Created by Ahmed on 29/12/2022.
//

import Foundation

protocol CountryApiDelegate {
    func didFetchData(country:Country)
}

var countryArray : [Country] = []

class CountryApi {
    
    var delegate : CountryApiDelegate?
    let urlBaseString = "https://restcountries.com/v3.1/name/"
    
    func fetchData (country:String){
        countryArray = []
        let urlString = "\(urlBaseString)\(country)"
       
        let request = URL(string: urlString)!
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { data, request, error in
            do{
                let countries : [Country] = try JSONDecoder().decode([Country].self, from: data!)
               // print(countries[0].name.official)
                let fristCountry = countries[0]
                self.delegate?.didFetchData(country: fristCountry)
            }catch{
                print(error)
            }
        
        }
 
        task.resume()
        
    }
    
}
