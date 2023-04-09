//
//  HolidaysViewController.swift
//  FinalPrjPublicHolidaysAPI_CoreData_CustomizedCells_2210573
//
//  Created by Thiago Soares de Souza on 2023-04-07.
//

import UIKit

class HolidaysViewController: UIViewController {

    public var selectedHolidayCountryList : [Holidays]?
    public var selectedCountryCode : String?
    public var selectedYear : String?
    public var publicHolidays : PublicHolidayRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if(self.selectedHolidayCountryList != nil && self.selectedCountryCode != nil && self.selectedYear != nil){
            print(self.selectedHolidayCountryList!)
            print(self.selectedCountryCode!)
            print(self.selectedYear!)
            
            self.publicHolidays?.printHolidaysListCountry(holidays: self.selectedHolidayCountryList)
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
