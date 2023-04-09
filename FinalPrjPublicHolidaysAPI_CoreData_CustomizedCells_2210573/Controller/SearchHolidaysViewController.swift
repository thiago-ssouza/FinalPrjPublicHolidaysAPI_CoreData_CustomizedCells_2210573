//
//  SearchHolidaysViewController.swift
//  FinalPrjPublicHolidaysAPI_CoreData_CustomizedCells_2210573
//
//  Created by Thiago Soares de Souza on 2023-04-07.
//

import UIKit

class SearchHolidaysViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    private var publicHolidays : PublicHolidayRequest?
    private var selectedHolidayCountryList : [Holiday]? = []
    
    private var selectedCountryCode : String?
    private var selectedCountryName : String?
    private var selectedYear : String?
    
    private var countryCodesList = CountryProvider.allCountries.keys
    private var countryNamesList = CountryProvider.allCountries.values
    
    @IBOutlet weak var pickerViewYear: UIPickerView!
    
    @IBOutlet weak var txtCountryCode: UITextField!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        pickerViewYear.dataSource = self
        pickerViewYear.delegate = self
        txtCountryCode.delegate = self
        
        publicHolidays = PublicHolidayRequest()
        pickerViewYear.selectRow(0, inComponent: 0, animated: false)
        
        selectedYear = YearProvider.getYearsList()[pickerViewYear.selectedRow(inComponent: 0)]
        
        //year = YearProvider.getYearsList()[0]
        
//        if(self.selectedCountryCode != nil && self.selectedYear != nil) {
//            self.selectedHolidayCountryList = publicHolidays!.getPublicHolidaysList(countryCode: self.selectedCountryCode!, year: self.selectedYear!)
//        }
//
//        if(self.selectedHolidayCountryList != nil) {
//            publicHolidays!.printHolidaysListCountry(holidays: self.selectedHolidayCountryList!)
//        }
//
//
//
//        print(self.countryCodesList)
//
//        if(self.selectedCountryCode != nil) {
//            guard let countryCodeNameTuple = CountryProvider.find(contryCode: self.selectedCountryCode!) else {
//                print("Country Code \(self.selectedCountryCode!) does not exist. Select other.")
//                return
//            }
//
//            print(type(of: countryCodeNameTuple))
//            print("Country Code: \(countryCodeNameTuple.countryCode) Country Name: \(countryCodeNameTuple.countryName)")
//        }
//
//        print(YearProvider.getYearsList())
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return YearProvider.getYearsList().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return YearProvider.getYearsList()[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedYear = YearProvider.getYearsList()[row]
        //print("Year \(self.selectedYear!) selected")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Only letters and control keys
        let allowedCharacters = CharacterSet.letters.union(.controlCharacters)
        let characterSet = CharacterSet(charactersIn: string)
        guard allowedCharacters.isSuperset(of: characterSet) else {
            return false
        }
        
        // Limit to 2 characters if there is already a text
        if let currentText = txtCountryCode.text, !currentText.isEmpty {
            let newLength = currentText.count + string.count - range.length
            guard newLength <= 2 else {
                return false
            }
        }
        
        // Convert to uppercase
        let uppercaseString = string.uppercased()
        txtCountryCode.text = (txtCountryCode.text as NSString?)?.replacingCharacters(in: range, with: uppercaseString)
        
        return false
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
   
        if (identifier == Segue.toHolidaysViewController) {
        
            guard let countryCode : String = txtCountryCode.text?.trimmingCharacters(in: .whitespacesAndNewlines).uppercased(), countryCode.count == 2 else {
                Toast.ok(view: self, title: "Something is wrong!", message: "Please enter a contry code with to letters only! (Ex: US, CA, etc...)", handler: nil)
                return false
            }
            
            if let countryCodeNameTuple = CountryProvider.find(contryCode: countryCode) {
                
                self.selectedCountryCode = countryCodeNameTuple.countryCode
                self.selectedCountryName = countryCodeNameTuple.countryName
                
//                guard let countryCodeNameTuple = CountryProvider.find(contryCode: self.selectedCountryCode!) else {
//                    print("Country Code \(self.selectedCountryCode!) does not exist. Select other.")
//                    return
//                }
//                print(countryCode)
//                print(year!)
                return true
            }else{
                Toast.ok(view: self, title: "Something is wrong!", message: "Country not available, Please try another contry code! (Ex: US, CA, etc...)", handler: nil)
                return false
            }
        }
        return true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Segue.toHolidaysViewController){
            
            let holidaysViewController = segue.destination as! HolidaysViewController
            
            holidaysViewController.selectedCountryCode = self.selectedCountryCode
            holidaysViewController.selectedCountryName = self.selectedCountryName
            holidaysViewController.selectedYear = self.selectedYear
            
            self.selectedHolidayCountryList = publicHolidays!.getPublicHolidaysList(countryCode: self.selectedCountryCode!, year: self.selectedYear!)
            
            holidaysViewController.selectedHolidayCountryList = self.selectedHolidayCountryList
            holidaysViewController.publicHolidays = self.publicHolidays
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
