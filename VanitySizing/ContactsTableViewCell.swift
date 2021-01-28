//
//  OverviewTableViewCell.swift
//  VanitySizing
//
//  Created by Diego Loop on 08.10.17.
//  Copyright © 2017 Herzly. All rights reserved.
//

import UIKit


class ContactsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactDetailLabel: UILabel!
    @IBOutlet weak var contactNotesLabel: UILabel!
    
    
    var clothDetails:String = ""
    
    //    var infoShownByThisCell:Cloth { didSet { updateUI() } }
    
    private func updateUI(){
        contactNameLabel?.text = clothDetails
        contactDetailLabel?.text = "Baam"
        contactNotesLabel?.text = "This are my notes notes notes"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

