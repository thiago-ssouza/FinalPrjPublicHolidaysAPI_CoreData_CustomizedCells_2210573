//
//  PublicHolidayTableViewCell.swift
//  FinalPrjPublicHolidaysAPI_CoreData_CustomizedCells_2210573
//
//  Created by Thiago Soares de Souza on 2023-04-09.
//

import UIKit

class PublicHolidayTableViewCell: UITableViewCell {

    static let identifier : String = "PublicHolidayTableViewCell"
    
    @IBOutlet weak var lblHolidayName: UILabel!
    @IBOutlet weak var lblHolidayDate: UILabel!
    
    @IBOutlet weak var imgNationalThumbsUpDown: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /**
     * Set the values in the customized cell
     */
    public func setCellContent(holiday : Holiday) {
        
        lblHolidayName.text = holiday.name
        lblHolidayDate.text = holiday.date
        
        if(holiday.counties == nil || holiday.counties!.count == 0) {
            
            imgNationalThumbsUpDown.image = UIImage.init(systemName: "hand.thumbsup.fill")
            imgNationalThumbsUpDown.tintColor = UIColor.systemGreen
            
        }else {
            
            imgNationalThumbsUpDown.image = UIImage.init(systemName: "hand.thumbsdown.fill")
            imgNationalThumbsUpDown.tintColor = UIColor.systemRed
            
        }
    }
    
    
}
