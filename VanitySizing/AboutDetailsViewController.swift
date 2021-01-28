//
//  AboutDetailsViewController.swift
//  VanitySizing
//
//  Created by Diego Loop on 15.01.18.
//  Copyright © 2018 Herzly. All rights reserved.
//

import UIKit

class AboutDetailsViewController: UIViewController {
    
    @IBOutlet var infoDetailTextView: UITextView!
    
    var details:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        infoDetailTextView.text = details
    }
}
