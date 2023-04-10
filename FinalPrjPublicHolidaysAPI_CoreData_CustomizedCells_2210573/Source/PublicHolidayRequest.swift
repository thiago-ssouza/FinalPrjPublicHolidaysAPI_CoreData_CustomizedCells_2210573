//
//  PublicHoliday.swift
//  FinalPrjPublicHolidaysAPI_CoreData_CustomizedCells_2210573
//
//  Created by Thiago Soares de Souza on 2023-04-07.
//

import Foundation

class PublicHolidayRequest {
    
    private let headers = [
        "X-RapidAPI-Key": "da3c475555mshd9434b7c0ca03ddp15225bjsnc520d260d39f",
        "X-RapidAPI-Host": "public-holiday.p.rapidapi.com"
    ]
    
    private func getPublicHolidays(countryCode:String, year:String, completion: @escaping ([Holiday]) -> Void){
        

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
                    let holidays = try decoder.decode([Holiday] .self, from: jsonData)
                    completion(holidays)
                } catch {
                    print("Error: \(error)")
                    return
                }
            }
        })

        dataTask.resume()
    }
    
    func getPublicHolidaysList(countryCode:String, year:String) -> [Holiday] {
        
        var holidays = [Holiday]()
        let semaphore = DispatchSemaphore(value: 0)
        
        getPublicHolidays(countryCode: countryCode, year: year) { resultHolidays in
            holidays = resultHolidays
            semaphore.signal()
        }
        
        semaphore.wait()
        
        return removeDuplicateHoliday(holidays: holidays)
        
        //return holidays
        
    }
    
    private func removeDuplicateHoliday(holidays : [Holiday]!) -> [Holiday] {
        
        var holidaysRemovedDuplicates : [Holiday] = []
        holidaysRemovedDuplicates.append(holidays[0])
        
        for index in 1..<holidays.count {
            let previousIndex = index - 1;
            if  ( (holidays[previousIndex].date == holidays[index].date) && (holidays[previousIndex].name == holidays[index].name) && (holidays[previousIndex].localName == holidays[index].localName) ) {
                if holidaysRemovedDuplicates[previousIndex].counties == nil {
                    holidaysRemovedDuplicates[previousIndex].counties = []
                }
                
                for provinceState in holidays[index].counties! {
                    holidaysRemovedDuplicates[previousIndex].counties!.append("\(provinceState) (\(holidays[index].type))")
                }
                
                continue
                
            }
            
            holidaysRemovedDuplicates.append(holidays[index])
        }
        
        return holidaysRemovedDuplicates
    }
    
    func printHolidaysListCountry(holidays : [Holiday]!) {
        
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
