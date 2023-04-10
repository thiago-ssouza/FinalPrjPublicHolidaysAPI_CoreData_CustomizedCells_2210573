//
//  PublicHolidayModel.swift
//  FinalPrjPublicHolidaysAPI_CoreData_CustomizedCells_2210573
//
//  Created by Thiago Soares de Souza on 2023-04-07.
//

import Foundation

struct Holiday:Decodable {
    var date:String
    var localName:String
    var name:String
    var countryCode:String
    var fixed:Bool
    var global:Bool
    var counties:[String]?
    var launchYear:Date?
    var type:String
}

//struct HolidayResponse:Decodable {
//    var holidays:[HolidayDetails]
//}
//
//struct HolidayDetails:Decodable {
//    var holidayDetails:[Detail]
//}
//
//struct Detail:Decodable {
//    var date:String
//    var localName:String
//    var name:String
//    var countryCode:String
//    var fixed:Bool
//    var global:Bool
//    var counties:[String]
//    var launchYear:Date
//    var type:String
//}


