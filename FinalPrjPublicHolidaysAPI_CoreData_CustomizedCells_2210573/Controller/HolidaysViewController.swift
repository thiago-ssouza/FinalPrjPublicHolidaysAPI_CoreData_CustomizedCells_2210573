//
//  HolidaysViewController.swift
//  FinalPrjPublicHolidaysAPI_CoreData_CustomizedCells_2210573
//
//  Created by Thiago Soares de Souza on 2023-04-07.
//

import UIKit

class HolidaysViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    public var selectedHolidayCountryList : [Holiday]?
    public var selectedCountryCode : String?
    public var selectedCountryName : String?
    public var selectedYear : String?
    public var publicHolidays : PublicHolidayRequest?
    private var selectedHoliday : Holiday?
    internal var selectedCountryImg : String?

    @IBOutlet weak var txtCountryYearTitleHolidays: UILabel!
    @IBOutlet weak var imgCountryFlag: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initialize()
        
    }
    
    /**
     * Initialize the table variables and the tableViewCustomizedCell
     */
    private func initialize() {
        
        if ( self.selectedCountryCode != nil && self.selectedCountryName != nil && self.selectedYear != nil && self.selectedCountryImg != nil ) {
            
            txtCountryYearTitleHolidays.text = "\(self.selectedCountryCode!) - \(self.selectedCountryName!) (\(self.selectedYear!))"
            
            imgCountryFlag.image = UIImage.init(named: self.selectedCountryImg!)
        }
        
        tableView.register(UINib.init(nibName: PublicHolidayTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PublicHolidayTableViewCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
 
    }
    
    /**
     * Return the total of holiday
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedHolidayCountryList!.count
    }
    
    /**
     * User reuseble cell to display all the holidays
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PublicHolidayTableViewCell.identifier, for: indexPath) as! PublicHolidayTableViewCell
        
        cell.setCellContent(holiday: self.selectedHolidayCountryList![indexPath.row])
        
        return cell
    }
    
    /**
     * If the user click on the holiday. Save in the variable the row and perform the segue it to the next View controler HolidayDetailsViewController
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedHoliday = self.selectedHolidayCountryList![indexPath.row]
        performSegue(withIdentifier: Segue.toHolidayDetailsViewController, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    /**
     * Set the variable in the view controller HolidayDetailsViewController
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue.toHolidayDetailsViewController {
            
            let holidayDetailsViewController = segue.destination as! HolidayDetailsViewController
            
            holidayDetailsViewController.selectedCountryName = self.selectedCountryName
            holidayDetailsViewController.selectedHoliday = self.selectedHoliday
            holidayDetailsViewController.selectedCountryImg = self.selectedCountryImg
            
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
