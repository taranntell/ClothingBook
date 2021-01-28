//
//  VSClothTableViewController.swift
//  VanitySizing
//
//  Created by Diego Loop on 14.09.17.
//  Copyright © 2017 Herzly. All rights reserved.
//

import UIKit
import CoreData

class VSClothTableViewController: CreateEditContactTableViewController //CreateContactTableViewController
{
    var container:NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    // A 1 Blouse| Shirt
    // B 2 Pants
    // C 3 Shoes
    // D 4 Dress | Suit
    // E 5 BH    | TShirt
    // F 6 Hat
    // G 7 Socks
    // H 8 Ring
        
    override func insertNewContact(_ name:String,sex:Int16,notes:String,blouseshirt:String,pants:String,shoes:String,suitdress:String, bhtshirt:String,hat:String,socks:String,ring:String){
        super.insertNewContact(name, sex: sex, notes: notes, blouseshirt: blouseshirt, pants: pants, shoes: shoes, suitdress: suitdress, bhtshirt: bhtshirt, hat: hat, socks: socks, ring: ring)
        
        updateDB(with: name,sex: sex,notes: notes,tshirt: bhtshirt,pants: pants,shoes: shoes,hat: hat,shirt: blouseshirt,socks: socks,suitdress: suitdress,ring: ring)
    }
    
    override func updateContact(_ contact:Cloth,name:String,sex:Int16,notes:String,blouseshirt:String,pants:String,shoes:String,suitdress:String,bhtshirt:String,hat:String,socks:String,ring:String) {
        super.updateContact(contact, name: name, sex: sex, notes: notes, blouseshirt: blouseshirt, pants: pants, shoes: shoes, suitdress: suitdress, bhtshirt: bhtshirt, hat: hat, socks: socks, ring: ring)

        container?.performBackgroundTask{ [weak self] context in
            _ = Cloth.editContact(in: context, contact: contact, name: name,sex: sex,notes: notes,blouseshirt: blouseshirt,pants: pants,shoes: shoes,suitdress: suitdress,bhtshirt: bhtshirt,hat: hat,socks: socks,ring: ring)
            try? context.save()
            self?.printDatabaseStatistics()
            
        }
    }
    
    override func removeContact(_ contact: Cloth) {
        super.removeContact(contact)
        
        let context:NSManagedObjectContext = (container?.viewContext)!
        _ = Cloth.removeContact(in: context, contact: contactToEdit!)
        try? context.save()
        printDatabaseStatistics()
    }
    
    private func updateDB(with name:String,sex:Int16,notes:String,tshirt:String,pants:String,shoes:String,hat:String,shirt:String,socks:String,suitdress:String,ring:String){
        container?.performBackgroundTask{ [weak self] context in
            _ = Cloth.createContact(in: context,name: name,sex: sex,notes: notes,blouseshirt: shirt,pants: pants,shoes: shoes,suitdress: suitdress,bhtshirt: tshirt,hat: hat,socks: socks,ring: ring)
            try? context.save()
            self?.printDatabaseStatistics()
        }
    }

    
    private func printDatabaseStatistics(){
        if let context = container?.viewContext{
            context.perform {
                let request: NSFetchRequest<Cloth> = Cloth.fetchRequest()
                if let clothCount = (try? context.fetch(request))?.count{
                    //self.navigationController?.popViewController(animated: true)
                    print("clothCount \(clothCount)")
                    self.performSegue(withIdentifier: ContactsTableViewController.UNWIND_TO_CONTACTS_TABLE_VIEW_CONTROLLER, sender: self)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "" { //constant would be a good idea
            if let overviewTVC = segue.destination as? ContactsTableViewController {
                overviewTVC.container = container
            }
        }
    }
}
