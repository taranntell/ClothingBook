//
//  UITableViewController extension for use with NSFetchedResults Controller
//  VanitySizing
//
//  Created by Diego Loop on 16.09.17.
//  Copyright © 2017 Herzly. All rights reserved.
//

import UIKit
import CoreData

extension ContactsTableViewController
{
    func addNoContactsViews(){
        
        let view: UIView = UIView(frame: CGRect(x:0,
                                                y:0,
                                                width: tableView.bounds.size.width,
                                                height: tableView.bounds.size.height))
        
        //view.backgroundColor = UIColor.init(cgColor: CGColor)
        let red = UIColor(red: 238.0/255.0, green: 238.0/255.0, blue: 238.0/255.0, alpha: 1.0)
        view.backgroundColor = UIColor.init(cgColor: red.cgColor)
        
        
        let titleRect = CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height)
        let titleLabel: UILabel = UILabel(frame:titleRect)
        titleLabel.text          = "Your Contat List 📏 Is Empty\nAdd a contact by pressing the + button"
        titleLabel.textColor     = UIColor.darkGray
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        
        
    
        view.addSubview(titleLabel)
        tableView.backgroundView  = view
        tableView.separatorStyle  = .none
    }
    
    // MARK: UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        if ((fetchedResultsController?.fetchedObjects?.count)! <= 0){
            addNoContactsViews()
        }else{
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
        }
        return fetchedResultsController?.sections?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController?.sections, sections.count > 0{
            return sections[section].numberOfObjects
        }else{
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sections = fetchedResultsController?.sections, sections.count > 0 {
            return sections[section].name
        } else {
            return nil
        }
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return fetchedResultsController?.sectionIndexTitles
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return fetchedResultsController?.section(forSectionIndexTitle: title, at: index) ?? 0
    }
}
