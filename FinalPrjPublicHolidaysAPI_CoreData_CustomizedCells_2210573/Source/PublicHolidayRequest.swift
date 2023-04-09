//
//  PublicHoliday.swift
//  ReadApiPublicHolidays
//
//  Created by macOSBigSur on 2023-04-07.
//

import Foundation

class PublicHolidayRequest {
    
    let headers = [
        "X-RapidAPI-Key": "da3c475555mshd9434b7c0ca03ddp15225bjsnc520d260d39f",
        "X-RapidAPI-Host": "public-holiday.p.rapidapi.com"
    ]
    
    func getPublicHolidays(countryCode:String, year:String, completion: @escaping ([Holidays]) -> Void){
        

        let request = NSMutableURLRequest(url: NSURL(string: "https://public-holiday.p.rapidapi.com/\(year)/\(countryCode)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0);
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if (error != nil) {
                //print("ENTRou")
                print("Error: \(error!)")
                return
            } else {
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("Invalid response. Try again later")
                    return
                }
                
                guard let jsonData = data else {
                    print("Data not available. Try again later.")
                    return
                }
                
                do{
                    let decoder = JSONDecoder()
                    let holidays = try decoder.decode([Holidays] .self, from: jsonData)
                    completion(holidays)
                } catch {
                    print("Error: \(error)")
                    return
                }
            }
        })

        dataTask.resume()
    }
    
    func getPublicHolidaysList(countryCode:String, year:String) -> [Holidays] {
        
        var holidays = [Holidays]()
        let semaphore = DispatchSemaphore(value: 0)
        
        getPublicHolidays(countryCode: countryCode, year: year) { resultHolidays in
            holidays = resultHolidays
            semaphore.signal()
        }
        
        semaphore.wait()
        
        return holidays
        
    }
    
    func printHolidaysListCountry(holidays : [Holidays]!) {
        
        if(holidays != nil) {
            var count = 0
            
            
            for holiday in holidays! {
                print("\nHoliday \(count+1)")
                print("\nDate: \(holiday.date)")
                print("\nLocal Name: \(holiday.localName)")
                print("\nInternational Name: \(holiday.name)")
                print("\nCountry Code: \(holiday.countryCode)")
                print("\nFixed: \(holiday.fixed)")
                print("\nGlobal: \(holiday.global)")
                if let counties = holiday.counties {
                    print("\nIt is a Province/State holiday for \(holiday.countryCode):")
                    for provinceState in counties {
                        print("\n\t- \(provinceState)")
                    }
                } else {
                    print("\nIt is a National holiday for: \(holiday.countryCode)")
                }
                if holiday.launchYear != nil {
                    print("\nLaunch Year: \(holiday.launchYear!)")
                } else {
                    print("\nLaunch Year: Unknow")
                }
                print("\nHoliday Type: \(holiday.type)")
                print("\n*********************************")
                count += 1
            }
        } else {
            print("Data is emplty, try again later!")
        }
        
        
//        if(self.holidays != nil) {
//            var count = 0
//
//
//            for holiday in self.holidays! {
//                print("\nHoliday \(count+1)")
//                print("\nDate: \(holiday.date)")
//                print("\nLocal Name: \(holiday.localName)")
//                print("\nInternational Name: \(holiday.name)")
//                print("\nCountry Code: \(holiday.countryCode)")
//                print("\nFixed: \(holiday.fixed)")
//                print("\nGlobal: \(holiday.global)")
//                if let counties = holiday.counties {
//                    print("\nIt is a Province/State holiday for \(holiday.countryCode):")
//                    for provinceState in counties {
//                        print("\n\t- \(provinceState)")
//                    }
//                } else {
//                    print("\nIt is a National holiday for: \(holiday.countryCode)")
//                }
//                if holiday.launchYear != nil {
//                    print("\nLaunch Year: \(holiday.launchYear!)")
//                } else {
//                    print("\nLaunch Year: Unknow")
//                }
//                print("\nHoliday Type: \(holiday.type)")
//                print("\n*********************************")
//                count += 1
//            }
//        } else {
//            print("Data is emplty, try again later!")
//        }
        
    }
    
}
