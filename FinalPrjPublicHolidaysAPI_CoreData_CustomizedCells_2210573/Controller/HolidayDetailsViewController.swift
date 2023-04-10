//
//  HolidayDetailsViewController.swift
//  FinalPrjPublicHolidaysAPI_CoreData_CustomizedCells_2210573
//
//  Created by Thiago Soares de Souza on 2023-04-07.
//

import UIKit

class HolidayDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var txtCountry: UITextField!
    
    @IBOutlet weak var txtLocalName: UITextField!
    
    @IBOutlet weak var txtInternationalName: UITextField!
    
    @IBOutlet weak var txtDate: UITextField!
    
    @IBOutlet weak var txtIsNationalHoliday: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imgCountryFlag: UIImageView!
    
    //var publicHolidays : PublicHolidayRequest?
    //var selectedHolidayCountryList : [Holiday]? = []
    
    //var selectedCountryCode : String?
    var selectedCountryName : String?
    //var selectedYear : String?
    
    var selectedHoliday : Holiday?
    private var selectedProvincesStates : [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        if ( self.selectedHoliday != nil && self.selectedCountryName != nil ) {
            
            txtCountry.text = "\(self.selectedHoliday!.countryCode) - \(self.selectedCountryName!)"
            txtLocalName.text = self.selectedHoliday!.localName
            txtInternationalName.text = self.selectedHoliday!.name
            txtDate.text = self.selectedHoliday!.date
            
            self.selectedProvincesStates = []
            if let counties = self.selectedHoliday!.counties {
                txtIsNationalHoliday.text = "No"
                //tableView.separatorColor = UIColor.systemIndigo
                //tableView.separatorStyle = .singleLine
                //tableView.isOpaque = true
                //print("\nIt is a Province/State holiday for \(holiday.countryCode):")
                for provinceState in counties {
                    //print("\n\t- \(provinceState)")
                    self.selectedProvincesStates!.append(provinceState)
                }
            }else{
                txtIsNationalHoliday.text = "Yes"
                tableView.isUserInteractionEnabled = false
                //print("\nIt is a National holiday for: \(holiday.countryCode)")
            }
        } else {
            Toast.ok(view: self, title: "Something is wrong!", message: "Sorry something is wrong. Try again later!", handler: nil)
            navigationController?.popViewController(animated: true)
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedProvincesStates!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = self.selectedProvincesStates![indexPath.row]
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections : Int = 0
        
        if self.selectedProvincesStates!.count > 0 {
            tableView.separatorStyle = .singleLine
            numOfSections = 1
            tableView.backgroundView = nil
        } else {
            
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "\(self.selectedHoliday!.name) is a National Holiday"
            noDataLabel.textColor = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView = noDataLabel
            tableView.separatorStyle = .none
        }
        
        return numOfSections
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
