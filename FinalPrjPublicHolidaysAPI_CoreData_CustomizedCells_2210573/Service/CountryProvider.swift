//
//  CountryProvider.swift
//  FinalPrjPublicHolidaysAPI_CoreData_CustomizedCells_2210573
//
//  Created by Thiago Soares de Souza on 2023-04-08.
//

import Foundation

class CountryProvider {
    
    public static var allCountries : [String : String] = [
                            "AX": "Åland Islands",
                            "AL": "Albania",
                            "AD": "Andorra",
                            "AR": "Argentina",
                            "AU": "Australia",
                            "AT": "Austria",
                            "BS": "Bahamas",
                            "BB": "Barbados",
                            "BY": "Belarus",
                            "BE": "Belgium",
                            "BZ": "Belize",
                            "BJ": "Benin",
                            "BO": "Bolivia",
                            "BA": "Bosnia & Herzegovina",
                            "BW": "Botswana",
                            "BR": "Brazil",
                            "BG": "Bulgaria",
                            "CA": "Canada",
                            "CL": "Chile",
                            "CN": "China",
                            "CO": "Colombia",
                            "CR": "Costa Rica",
                            "HR": "Croatia",
                            "CU": "Cuba",
                            "CY": "Cyprus",
                            "CZ": "Czechia",
                            "DK": "Denmark",
                            "DO": "Dominican Republic",
                            "EC": "Ecuador",
                            "EG": "Egypt",
                            "SV": "El Salvador",
                            "EE": "Estonia",
                            "FO": "Faroe Islands",
                            "FI": "Finland",
                            "FR": "France",
                            "GA": "Gabon",
                            "GM": "Gambia",
                            "DE": "Germany",
                            "GI": "Gibraltar",
                            "GR": "Greece",
                            "GL": "Greenland",
                            "GD": "Grenada",
                            "GT": "Guatemala",
                            "GG": "Guernsey",
                            "GY": "Guyana",
                            "HT": "Haiti",
                            "HN": "Honduras",
                            "HU": "Hungary",
                            "IS": "Iceland",
                            "ID": "Indonesia",
                            "IE": "Ireland",
                            "IM": "Isle of Man",
                            "IT": "Italy",
                            "JM": "Jamaica",
                            "JP": "Japan",
                            "JE": "Jersey",
                            "LV": "Latvia",
                            "LS": "Lesotho",
                            "LI": "Liechtenstein",
                            "LT": "Lithuania",
                            "LU": "Luxembourg",
                            "MG": "Madagascar",
                            "MT": "Malta",
                            "MX": "Mexico",
                            "MD": "Moldova",
                            "MC": "Monaco",
                            "MN": "Mongolia",
                            "ME": "Montenegro",
                            "MS": "Montserrat",
                            "MA": "Morocco",
                            "MZ": "Mozambique",
                            "NA": "Namibia",
                            "NL": "Netherlands",
                            "NZ": "New Zealand",
                            "NI": "Nicaragua",
                            "NE": "Niger",
                            "NG": "Nigeria",
                            "MK": "North Macedonia",
                            "NO": "Norway",
                            "PA": "Panama",
                            "PG": "Papua New Guinea",
                            "PY": "Paraguay",
                            "PE": "Peru",
                            "PL": "Poland",
                            "PT": "Portugal",
                            "PR": "Puerto Rico",
                            "RO": "Romania",
                            "RU": "Russia",
                            "SM": "San Marino",
                            "RS": "Serbia",
                            "SG": "Singapore",
                            "SK": "Slovakia",
                            "SI": "Slovenia",
                            "ZA": "South Africa",
                            "KR": "South Korea",
                            "ES": "Spain",
                            "SR": "Suriname",
                            "SJ": "Svalbard & Jan Mayen",
                            "SE": "Sweden",
                            "CH": "Switzerland",
                            "TN": "Tunisia",
                            "TR": "Turkey",
                            "UA": "Ukraine",
                            "GB": "United Kingdom",
                            "US": "United States",
                            "UY": "Uruguay",
                            "VA": "Vatican City",
                            "VE": "Venezuela",
                            "VN": "Vietnam",
                            "ZW": "Zimbabwe",
        
    ]
    
//    /// Find country code and name in dictionary
//    public static func find(contryCode : String) -> [String : String]? {
//
//        for countryCodeElement in CountryCodeProvider.allCountryCodes {
//            let r = (countryCode: countryCodeElement.key , countryName: countryCodeElement.value)
//            print("Country Code: \(r.countryCode) Country Name \(r.countryName)")
//            if countryCodeElement.key.uppercased() == contryCode.uppercased() {
//                return [countryCodeElement.key : countryCodeElement.value]
//            }
//
//        }
//        return nil
//
//    }
    
    /// Find country code and name in dictionary
    public static func find(contryCode : String) -> ((countryCode:String , countryName:String))? {
        
        for countryCodeElement in CountryProvider.allCountries {
//            let r = (countryCode: countryCodeElement.key , countryName: countryCodeElement.value)
//            print("Country Code: \(r.countryCode) Country Name \(r.countryName)")
            if countryCodeElement.key.uppercased() == contryCode.uppercased() {
                //return (countryCode: countryCodeElement.key , countryName: countryCodeElement.value)
                return ((countryCodeElement.key , countryCodeElement.value))
            }
            
        }
        return nil
        
    }
    
}
