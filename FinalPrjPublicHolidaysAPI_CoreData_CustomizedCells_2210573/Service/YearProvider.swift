//
//  YearProvider.swift
//  FinalPrjPublicHolidaysAPI_CoreData_CustomizedCells_2210573
//
//  Created by Thiago Soares de Souza on 2023-04-08.
//

import Foundation

class YearProvider {
    
    //private var allYears : [String] = []

//    private func getAllYears() -> [String]{
//        return self.allYears
//    }
    
//    private func setAllYears(years : [String]){
//        self.allYears = years
//    }
    
    /// Find country code and name in dictionary
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
