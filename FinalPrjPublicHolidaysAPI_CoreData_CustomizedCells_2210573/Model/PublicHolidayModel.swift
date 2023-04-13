//
//  PublicHolidayModel.swift
//  FinalPrjPublicHolidaysAPI_CoreData_CustomizedCells_2210573
//
//  Created by Thiago Soares de Souza on 2023-04-07.
//

import Foundation

/// Struct to decode the API Public Holidays the holiday
struct Holiday : Decodable {
    var date : String
    var name : String
    var localName : String
    var countryCode : String
    var type : String
    var fixed : Bool
    var global : Bool
    var counties : [String]?
    var launchYear : Date?
}


