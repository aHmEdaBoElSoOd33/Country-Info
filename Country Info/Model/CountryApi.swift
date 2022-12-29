//
//  CountryApi.swift
//  Country Info
//
//  Created by Ahmed on 29/12/2022.
//

import Foundation

class CountryApi {
    
    let urlBaseString = "https://restcountries.com/v3.1/name/"
    
    func fetchData (country:String){
        let urlString = "\(urlBaseString)\(country)"
       
        let request = URL(string: urlString)!
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { data, request, error in
            
            let dataString = String(data: data!, encoding: .utf8)
            
            print(dataString)
            
        }
        task.resume()
        
    }
    
    
    
    
    
    
}
