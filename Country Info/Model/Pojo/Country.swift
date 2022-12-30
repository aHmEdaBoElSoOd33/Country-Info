//
//  Country.swift
//  Country Info
//
//  Created by Ahmed on 30/12/2022.
//

import Foundation
  
//struct Country  {
//
//    var name : [String:Any]?
//    var capital : [String]?
//    var region : String?
//    var population : Int?
//
//}



struct Country:Decodable{
    var name:Name
    var capital:[String]
    var region:String
    var population:Int
    var maps : Maps
}


struct Name :Decodable{
var common:String
var official:String
}


struct Maps: Decodable{
    var googleMaps : String
}

