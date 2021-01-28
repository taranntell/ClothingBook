//
//  EditTableViewController.swift
//  VanitySizing
//
//  Created by Diego Loop on 12.11.17.
//  Copyright © 2017 Herzly. All rights reserved.
//

import UIKit

class EditTableViewController: UITableViewController {
    
    weak var contact:Cloth?
    
//    override func viewDidLoad() {
//        print("Yes baby")
//        print("contact: \(contact?.dressedUser?.name ?? "Not contact")")
//    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    @IBAction func dismissView(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func updateContact(_ sender: UIBarButtonItem) {
        
    }
}
