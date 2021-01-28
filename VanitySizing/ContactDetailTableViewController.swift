//
//  EditContactTableViewController.swift
//  VanitySizing
//
//  Created by Diego Loop on 03.11.17.
//  Copyright © 2017 Herzly. All rights reserved.
//

import UIKit
import CoreData

class ContactDetailTableViewController: UITableViewController {

    weak var selectedContact: Cloth?
    var fetchedResultsController: NSFetchedResultsController<Cloth>?
    
    let NOT_AVAILABLE = "Not available"

    var sizeItems = [(String, String, String)]()
    
    @IBOutlet var conversionOptions: UISegmentedControl!
    
    // MARK - INITIALIZATION
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conversionOptions.removeAllSegments()
        addConversionOptions(true)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(editSizeContact) )
        
        self.tableView.reloadData()
        
    }
    
    // MARK - Segmented
    func addConversionOptions(_ isEmpty:Bool) {
        for (index,val) in SizeModel.countryLite.enumerated(){
            if isEmpty{
                conversionOptions.insertSegment(withTitle: val.value, at: index, animated: false)
            }else{
                conversionOptions.setTitle(val.value, forSegmentAt: index)
            }
        }
    }
    
    @IBAction func onPressConversionOptions(_ sender: UISegmentedControl) {
        addConversionOptions(false)
        let selectedIndex = sender.selectedSegmentIndex
        conversionOptions.setTitle(Array(SizeModel.countryLite.keys)[selectedIndex], forSegmentAt: selectedIndex)
        
        tableView.reloadData()
    }

    // MARK - ACTIONS
    @objc func editSizeContact(){
        tableView.reloadData()
        self.performSegue(withIdentifier: "EditTestContact", sender: self)
    }
    
    // MARK - TABLEVIEW
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sizeItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contact Detail Cell", for: indexPath)

        // making all cells multilines so notes can be displayed without a problem
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        
        let selectedCountry = conversionOptions.selectedSegmentIndex == -1 ? "" : SizeModel.countryLite[conversionOptions.titleForSegment(at: conversionOptions.selectedSegmentIndex)!]
        let conversionSize = " " +  selectedCountry!
        var initSize =  String.init(sizeItems[indexPath.item].2 + " " + sizeItems[indexPath.item].1)
        
        let sizeParse = sizeItems[indexPath.item].1.components(separatedBy: " ")

        if ((tableView.numberOfRows(inSection: 0) - 1) != indexPath.row) && (sizeParse[0] != "-" && selectedCountry != ""){
            // check conversion if the size differs from the already given
            if selectedCountry != sizeParse[0]{
                initSize.append(conversionSize)
                let conversionGender = Int( (selectedContact?.dressedUser?.gender)! )
                let fromCountry = SizeModel.countryIcon[sizeItems[indexPath.item].1.components(separatedBy: " ")[0]] ?? ""
                let toCountry = SizeModel.countryIcon[selectedCountry!]!
                initSize.append(" " + findConversionSize( conversionGender , item:sizeItems[indexPath.item].0, size:sizeItems[indexPath.item].1, fromCountry: fromCountry, toCountry: toCountry))
            }
        }
        
        cell.textLabel?.text = initSize
        cell.detailTextLabel?.text = sizeItems[indexPath.item].0
        return cell
    }
    
    func findConversionSize(_ genre:Int, item:String, size:String, fromCountry:String, toCountry:String) -> String{
        var conversion:String?
        //["🇺🇸", "W30", "L32"]
        var sizes = size.components(separatedBy: " ")
        if sizes.count > 2{
            
            var array = ""
            for (i,s) in sizes.enumerated(){
                if i > 0{
                    array.append(s)
                    if i == 1{
                    array.append(" ")
                    }
                    
                }
            }
            sizes[1] = array
        }
        let sex = SizeModel.Sex(rawValue: genre) ?? SizeModel.Sex.Girl

        if item == SizeModel.Item.pants.name(sex){
            conversion = NOT_AVAILABLE
            /* Conversion for jeans and pants are not available since the information is not matching correctly
//            let wSize = sizes[1].components(separatedBy: SizeModel.WAIST)[0]
//            let lSize = sizes[2].components(separatedBy: SizeModel.LENGTH)[0]
//
//            let selectedWIndex:Int?
//            if (wSize != SizeModel.defaultEmptyValue){
//                selectedWIndex = SizeModel.pants[genre][fromCountry]![0].index(of: wSize)!
//                conversion?.append(SizeModel.pants[genre][toCountry]![0][selectedWIndex!] + SizeModel.WAIST + " ")
//            }
//            let selectedLIndex:Int?
//            if (lSize != SizeModel.defaultEmptyValue){
//                selectedLIndex = SizeModel.pants[genre][fromCountry]![1].index(of: lSize)!
//                conversion?.append(SizeModel.pants[genre][toCountry]![1][selectedLIndex!] + SizeModel.LENGTH)
//            }
 */

        }else if item == SizeModel.Item.shoes.name(sex){
            let selectedIndex = SizeModel.shoes[genre][fromCountry]?.index(of: sizes[1]) ?? nil
            conversion = SizeModel.shoes[genre][toCountry]?[selectedIndex ?? 0] ?? nil
        }else if item == SizeModel.Item.hat.name(sex){
            let selectedIndex = SizeModel.hat[genre][fromCountry]?.index(of: sizes[1]) ?? nil
            conversion = SizeModel.hat[genre][toCountry]?[selectedIndex ?? 0] ?? nil
        }else if item == SizeModel.Item.blouseshirt.name(sex){
            let selectedIndex = SizeModel.blouseshirt[genre][fromCountry]?.index(of: sizes[1]) ?? nil
            conversion = SizeModel.blouseshirt[genre][toCountry]?[selectedIndex ?? 0] ?? nil
        }else if item == SizeModel.Item.socks.name(sex){
            let selectedIndex = SizeModel.socks[genre][fromCountry]?.index(of: sizes[1]) ?? nil
            conversion = SizeModel.socks[genre][toCountry]?[selectedIndex ?? 0] ?? nil
        }else if item == SizeModel.Item.dresssuit.name(sex){
            let selectedIndex = SizeModel.dresssuit[genre][fromCountry]?.index(of: sizes[1]) ?? nil
            conversion = SizeModel.dresssuit[genre][toCountry]?[selectedIndex ?? 0] ?? nil
        }else if item == SizeModel.Item.ring.name(sex) {
            // genre: Ring only has one index -> 0
            let selectedIndex = SizeModel.ring[0][fromCountry]?.index(of: sizes[1]) ?? nil
            conversion = SizeModel.ring[0][toCountry]?[selectedIndex ?? 0] ?? nil
        }else if item == SizeModel.Item.bhtshirt.name(sex) {
            let selectedIndex = SizeModel.bhtshirt[genre][fromCountry]?.index(of: sizes[1]) ?? nil
            conversion = SizeModel.bhtshirt[genre][toCountry]?[selectedIndex ?? 0] ?? nil
        }
        
        return conversion ?? NOT_AVAILABLE
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier{
            switch identifier{
                case "EditTestContact":
                    if let cetvc = segue.destination as? CreateEditContactTableViewController{
                        cetvc.isEditingContact = true
                        cetvc.contactToEdit = selectedContact
                    }
                default: break
            }
        }
    }
}
