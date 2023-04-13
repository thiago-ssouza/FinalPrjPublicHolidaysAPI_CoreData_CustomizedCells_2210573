//
//  YearProvider.swift
//  FinalPrjPublicHolidaysAPI_CoreData_CustomizedCells_2210573
//
//  Created by Thiago Soares de Souza on 2023-04-08.
//

import Foundation

class YearProvider {
    
    /**
     * Generate and return the list of available years
     */
    public static func getYearsList() -> [String] {
        let startYear : String = "1923"
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        let rangeAvailableYears = Int(startYear)!...Int(currentYear)!
        
        var allYears : [String] = []
        
        for year in rangeAvailableYears.reversed() {
            allYears.append("\(year)")
        }
        
        return allYears
    }
    
}
