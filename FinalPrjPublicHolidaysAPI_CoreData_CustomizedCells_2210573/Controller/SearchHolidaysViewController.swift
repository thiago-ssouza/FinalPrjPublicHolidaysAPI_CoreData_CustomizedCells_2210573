//
//  SearchHolidaysViewController.swift
//  FinalPrjPublicHolidaysAPI_CoreData_CustomizedCells_2210573
//
//  Created by Thiago Soares de Souza on 2023-04-07.
//

import UIKit

class SearchHolidaysViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    internal var loggedUser : User?
    
    private var publicHolidays : PublicHolidayRequest?
    
    private var selectedHolidayCountryList : [Holiday]? = []
    
    private var countryCodeCountryNameList : [(countryCode:String, countryName:String)]?
    
    private var selectedCountryCode : String?
    private var selectedCountryName : String?
    private var selectedYear : String?
    private var selectedCountryImg : String?
    
    @IBOutlet weak var pickerViewYear: UIPickerView!
    
    @IBOutlet weak var txtCountryCode: UITextField!
    
    @IBOutlet weak var btnSwitch: UISwitch!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnSearch: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        btnSearch.layer.cornerRadius = 15
        
        pickerViewYear.dataSource = self
        pickerViewYear.delegate = self
        
        txtCountryCode.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        btnSwitch.isOn = false
        
        tableView.isHidden = true
        
        publicHolidays = PublicHolidayRequest()
        
        pickerViewYear.selectRow(0, inComponent: 0, animated: false)
        
        selectedYear = YearProvider.getYearsList()[pickerViewYear.selectedRow(inComponent: 0)]
        
        // Get the array of tuples of country code/name
        self.countryCodeCountryNameList = CountryProvider.getCountryCodeCountryNameList()
        
        /// order ascending the array of tuples, using the country code
        self.countryCodeCountryNameList = self.countryCodeCountryNameList!.sorted(by: { $0.0 < $1.0 })
        
    }
    
    /**
     * Define how many components the picker view will have
     */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /**
     * return the total quantity of number of components to show the rows
     */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return YearProvider.getYearsList().count
    }
    
    /**
     * Define wich element will be displayed
     */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return YearProvider.getYearsList()[row]
    }
    
    /**
     * Define how many components the picker view will have
     */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedYear = YearProvider.getYearsList()[row]
    }
    
    /**
     * Limit the text fiel to allow only: Letters and control keys, maximum length to type is 2 and convert it to uppercase char
     */
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
    
    /**
     * Display or hide list of country codes if the user want to consult and click on the switch element
     */
    @IBAction func btnSwitchValueChanged(_ sender: Any) {
        tableView.isHidden.toggle()
    }
    
    /**
     * Return the quantity of total elements to be displayed in the tableView of countryCode/Name for the user review it
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countryCodeCountryNameList!.count
    }
    
    /**
     * Display the elemente in the cell using reuseble cells
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "\(self.countryCodeCountryNameList![indexPath.row].countryCode) - \(self.countryCodeCountryNameList![indexPath.row].countryName)"
        
        return cell
    }
    
    /**
     * When the user click on the row, set the text of the countryCode field to the countryCode
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        txtCountryCode.text = self.countryCodeCountryNameList![indexPath.row].countryCode
    }
    
    /**
     * Rules to validate the user enter the contry code to be search and allow or not go to HolidaysViewController and ManageUserViewController
     */
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
   
        if (identifier == Segue.toHolidaysViewController) {
        
            guard let countryCode : String = txtCountryCode.text?.trimmingCharacters(in: .whitespacesAndNewlines).uppercased(), countryCode.count == 2 else {
                Toast.ok(view: self, title: "Something is wrong!", message: "Please enter a contry code with to letters only! (Ex: US, CA, etc...)", handler: nil)
                return false
            }
            
            if let countryCodeNameTuple = CountryProvider.find(contryCode: countryCode) {
                
                self.selectedCountryCode = countryCodeNameTuple.countryCode
                self.selectedCountryName = countryCodeNameTuple.countryName
                
                self.selectedCountryImg = "\(self.selectedCountryCode!)-\(self.selectedCountryName!).png";
                
                return true
            }else{
                Toast.ok(view: self, title: "Something is wrong!", message: "Country not available, Please try another contry code! (Ex: US, CA, etc...)", handler: nil)
                return false
            }
        }
        if identifier == Segue.toManageUserViewController {
            
            return true
            
        }
        return false
        
    }
    
    /**
     * Set the values in the next HolidaysViewController
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Segue.toHolidaysViewController){
            
            let holidaysViewController = segue.destination as! HolidaysViewController
            
            holidaysViewController.selectedCountryCode = self.selectedCountryCode
            holidaysViewController.selectedCountryName = self.selectedCountryName
            
            holidaysViewController.selectedYear = self.selectedYear
            
            self.selectedHolidayCountryList = publicHolidays!.getPublicHolidaysList(countryCode: self.selectedCountryCode!, year: self.selectedYear!)
            
            holidaysViewController.selectedHolidayCountryList = self.selectedHolidayCountryList
            holidaysViewController.publicHolidays = self.publicHolidays
            
            holidaysViewController.selectedCountryImg = self.selectedCountryImg
        }
        
        if segue.identifier == Segue.toManageUserViewController {
            
            let manageUserViewController = segue.destination as! ManageUserViewController
            
            manageUserViewController.loggedUser = self.loggedUser
            
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
