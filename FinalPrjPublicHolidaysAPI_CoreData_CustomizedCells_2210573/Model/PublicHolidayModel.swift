//
//  PublicHolidayModel.swift
//  ReadApiPublicHolidays
//
//  Created by macOSBigSur on 2023-04-07.
//

import Foundation

struct Holidays:Decodable {
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


