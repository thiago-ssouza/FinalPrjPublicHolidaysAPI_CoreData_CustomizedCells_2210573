//
//  PublicHolidayTableViewCell.swift
//  FinalPrjPublicHolidaysAPI_CoreData_CustomizedCells_2210573
//
//  Created by macOSBigSur on 2023-04-09.
//

import UIKit

class PublicHolidayTableViewCell: UITableViewCell {

    static let identifier : String = "PublicHolidayTableViewCell"
    
    @IBOutlet weak var lblHolidayName: UILabel!
    
    @IBOutlet weak var lblHolidayDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setCellContent(holiday : Holiday) {
        lblHolidayName.text = holiday.name
        lblHolidayDate.text = holiday.date
    }
    
    
}
