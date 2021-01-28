//
//  HomeTableViewController.swift
//  VanitySizing
//
//  Created by Diego Loop on 05.09.17.
//  Copyright © 2017 Herzly. All rights reserved.
//

import UIKit
import CoreData

class ContactsTableViewController: FetchedResultsTableViewController
{
    
    public static let UNWIND_TO_CONTACTS_TABLE_VIEW_CONTROLLER = "unwindToContactsTableViewController"
    
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer { didSet { updateUI() }}
    
    var fetchedResultsController: NSFetchedResultsController<Cloth>?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        updateUI()
    }
    
    private func updateUI(){
        if let context = container?.viewContext{
            
            let request: NSFetchRequest<Cloth> = Cloth.fetchRequest()
            //(key:)(key:"dressedUser.name", ascending:true)]
            request.sortDescriptors = [NSSortDescriptor(key: "dressedUser.name", ascending: true, selector:#selector(NSString.localizedCaseInsensitiveCompare))]
            
//            request.sortDescriptors = [NSSortDescriptor(key: "dressedUser.name", ascending: true)]
            
            fetchedResultsController = NSFetchedResultsController<Cloth>(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            try? fetchedResultsController?.performFetch()
            tableView.reloadData()
            fetchedResultsController?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI() // wrong, this method should be on the container initialization (didGet?)
    }

    // MARK: - TableView
    
    func findDetails(_ cloth:Cloth, sex:SizeModel.Sex) -> String{
        
        var subtitle:[String?] = []
        
        let blouseshirt = cloth.blouseshirt != SizeModel.defaultEmptyValue ? "\( SizeModel.Item.blouseshirt.emoji(sex) ) \(cloth.blouseshirt ?? "") " : ""
        let pants = cloth.pants != SizeModel.defaultEmptyValue ? "\( SizeModel.Item.pants.emoji(sex) ) \(cloth.pants ?? "") " : ""
        let shoes = cloth.shoes != SizeModel.defaultEmptyValue ? "\( SizeModel.Item.shoes.emoji(sex) ) \(cloth.shoes ?? "") " : ""
        let dresssuit = cloth.suitdress != SizeModel.defaultEmptyValue ? "\( SizeModel.Item.dresssuit.emoji(sex) ) \(cloth.suitdress ?? "") " : ""
        let bhtshirt = cloth.bhtshirt != SizeModel.defaultEmptyValue ? "\( SizeModel.Item.bhtshirt.emoji(sex) ) \(cloth.bhtshirt ?? "") " : ""
        let hat = cloth.hat != SizeModel.defaultEmptyValue ? "\( SizeModel.Item.hat.emoji(sex) ) \(cloth.hat ?? "") " : ""
        let socks = cloth.socks != SizeModel.defaultEmptyValue ? "\( SizeModel.Item.socks.emoji(sex) ) \(cloth.socks ?? "") " : ""
        let ring = cloth.ring != SizeModel.defaultEmptyValue ? "\( SizeModel.Item.ring.emoji(sex) ) \(cloth.ring ?? "") " : ""
        
        if blouseshirt != "" { subtitle.append(blouseshirt) }
        if pants != "" { subtitle.append(pants) }
        if shoes != "" { subtitle.append(shoes) }
        if dresssuit != "" { subtitle.append(dresssuit) }
        if bhtshirt != "" { subtitle.append(bhtshirt) }
        if hat != "" { subtitle.append(hat) }
        if socks != "" { subtitle.append(socks) }
        if ring != "" { subtitle.append(ring) }
        
        let maxSubtitles = 3
        let separation = "  "
        var final = ""
        
        if subtitle.count > maxSubtitles {
            for i in 0..<maxSubtitles {
                final += subtitle[i]! + separation
            }
        }else{
            for i in 0..<subtitle.count {
                final += subtitle[i]! + separation
            }
        }
        return final
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Overview Cell", for: indexPath)
        
        if let cloth = fetchedResultsController?.object(at: indexPath){
            if let overviewCell = cell as? ContactsTableViewCell{
                let sex = SizeModel.Sex(rawValue: Int( (cloth.dressedUser?.gender)! ) )!
                
                overviewCell.contactNameLabel?.text = cloth.dressedUser?.name ?? ""
                overviewCell.contactDetailLabel?.text = findDetails(cloth, sex: sex) //details.joined(separator: " ")
                overviewCell.contactNotesLabel?.text = ((cloth.dressedUser?.notes)! != "") ? "\(SizeModel.Item.notes.emoji(sex)) \((cloth.dressedUser?.notes)!)" : ""
            }
        }
        return cell
    }
    
    // MARK: - Navigation
    @IBAction func addNewContactPress(_ sender: UIBarButtonItem){
        self.performSegue(withIdentifier: "CreateContactNewDesign", sender: nil)
    }

    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier{
//                
//                case "CreateContactNewDesign":
//                    print("CreateContactNewDesign -- \(segue.destination)")
//                case "AddContact":
//                    print("add contact has been pressed -- \(segue.destination)")

                case "SeeContactDetails":
                    if let cdtvc = segue.destination as? ContactDetailTableViewController {
                        let indexpath = tableView.indexPathForSelectedRow
                        
                        if let selObject = fetchedResultsController?.object(at: indexpath!){
                            cdtvc.title = selObject.dressedUser?.name
                            cdtvc.sizeItems = selObject.sizeItems(cloth: selObject)
                            cdtvc.selectedContact = selObject
                        }
                    }
                default: break
            }
        }
    }
}
