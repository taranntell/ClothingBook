//
//  CreateNewDesignTableViewController.swift
//  VanitySizing
//
//  Created by Diego Loop on 16.11.17.
//  Copyright © 2017 Herzly. All rights reserved.
//

import UIKit

class CreateEditContactTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var sexSC: UISegmentedControl!
    @IBOutlet var notesTextView: UITextView!
    
    @IBOutlet var itemACell: UITableViewCell!
    @IBOutlet var itemAPicker: UIPickerView!
    
    @IBOutlet var itemBCell: UITableViewCell!
    @IBOutlet var itemBPicker: UIPickerView!
    
    @IBOutlet var itemCCell: UITableViewCell!
    @IBOutlet var itemCPicker: UIPickerView!
    
    @IBOutlet var itemDCell: UITableViewCell!
    @IBOutlet var itemDPicker: UIPickerView!
    
    @IBOutlet var itemECell: UITableViewCell!
    @IBOutlet var itemEPicker: UIPickerView!
    
    @IBOutlet var itemFCell: UITableViewCell!
    @IBOutlet var itemFPicker: UIPickerView!
    
    @IBOutlet var itemGCell: UITableViewCell!
    @IBOutlet var itemGPicker: UIPickerView!
    
    @IBOutlet var itemHCell: UITableViewCell!
    @IBOutlet var itemHPicker: UIPickerView!
    
    @IBOutlet var itemICell: UITableViewCell!
    @IBOutlet var itemIPicker: UIPickerView!
    
    @IBOutlet var trashButton: UIBarButtonItem!
    
    public var isEditingContact:Bool = false
    public var contactToEdit:Cloth?
    
    public static var GIRL_INDEX = 0
    public static var GUY_INDEX = 1
    
    var picker:UIPickerView?
    
    //var pressedRow = 0
    
    private var NOTES_PLACEHOLDER_TEXT = "📝 Notes"
    
    var sex:SizeModel.Sex!
    var gender:Int! = 0

    var selectedIndex:IndexPath?
    var selectedCountry:String?
    // all sections (top, shoes, pants, hat,...) are invisible at the first time
    var rowsVisibilityState:Array = [true, false, false, false, false, false, false, false, false]
    
    // Storing pant size
    var pantsWidth:String?, pantsLength:String?
    
    // Article Section List
    // 0: Name, Sex, Notes
    //    Women    | Men
    //    Women    | Men
    // A 1 Blouse| Shirt
    // B 2 Pants
    // C 3 Shoes
    // D 4 Dress | Suit
    // E 5 BH    | TShirt
    // F 6 Hat
    // G 7 Socks
    // H 8 Ring
    
    var selectedCountryBlouseShirt:String?
    var selectedCountryPants:String?
    var selectedCountryShoes:String?
    var selectedCountryDressSuit:String?
    var selectedCountryBHTshirt:String?
    var selectedCountryHat:String?
    var selectedCountrySocks:String?
    var selectedCountryRing:String?
    
    func updateEditedContactInformation(_ contact:Cloth?)  {
        nameTextField.text = contactToEdit?.dressedUser?.name
        sexSC.selectedSegmentIndex = Int((contactToEdit?.dressedUser?.gender)!)
        notesTextView.text = contactToEdit?.dressedUser?.notes
        
        itemACell.textLabel?.text = contactToEdit?.blouseshirt
        itemBCell.textLabel?.text = contactToEdit?.pants
        itemCCell.textLabel?.text = contactToEdit?.shoes
        itemDCell.textLabel?.text = contactToEdit?.suitdress
        itemECell.textLabel?.text = contactToEdit?.bhtshirt
        itemFCell.textLabel?.text = contactToEdit?.hat
        itemGCell.textLabel?.text = contactToEdit?.socks
        itemHCell.textLabel?.text = contactToEdit?.ring
        itemICell.textLabel?.text = contactToEdit?.bh
    }
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        notesTextView.delegate = self
        notesTextView.text = NOTES_PLACEHOLDER_TEXT
        notesTextView.textColor = !isEditingContact ? .lightGray : .black
        
        if isEditingContact{
            updateEditedContactInformation(contactToEdit)
            // trashButton for Create contact has been set directly on the storyboard
            trashButton.isEnabled = true
            trashButton.tintColor = nil
        }
        sex = SizeModel.findSex(sexSC.selectedSegmentIndex)
        gender = sexSC.selectedSegmentIndex
    }
    
    // MARK: - DB
    
    internal func insertNewContact(_ name:String,
                                   sex:Int16,
                                   notes:String,
                                   blouseshirt:String,
                                   pants:String,
                                   shoes:String,
                                   suitdress:String,
                                   bhtshirt:String,
                                   hat:String,
                                   socks:String,
                                   ring:String){}
    
    internal func updateContact(_ contact:Cloth, name:String,
                                sex:Int16,
                                notes:String,
                                blouseshirt:String,
                                pants:String,
                                shoes:String,
                                suitdress:String,
                                bhtshirt:String,
                                hat:String,
                                socks:String,
                                ring:String){}
    
    internal func removeContact(_ contact:Cloth){}
    
    // MARK: - Actions
    @IBAction func sexChanged(_ sender: UISegmentedControl) {
        // reload tableview with girl sizes
        sex = SizeModel.findSex(sexSC.selectedSegmentIndex)
        gender = sexSC.selectedSegmentIndex
        resetValues()
        
        tableView.reloadData()
    }
    
    func resetValues() {
        selectedCountry = nil
        
        selectedCountryBlouseShirt = nil
        selectedCountryPants = nil
        selectedCountryShoes = nil
        selectedCountryDressSuit = nil
        selectedCountryBHTshirt = nil
        selectedCountryHat = nil
        selectedCountrySocks = nil
        selectedCountryRing = nil
        
        
        selectedIndex = nil
        for i in 1..<rowsVisibilityState.count {
            rowsVisibilityState[i] = false
        }
        
        itemAPicker.selectRow(0, inComponent: 0, animated: false);itemAPicker.selectRow(0, inComponent: 1, animated: false)
        itemBPicker.selectRow(0, inComponent: 0, animated: false);itemBPicker.selectRow(0, inComponent: 1, animated: false);itemBPicker.selectRow(0, inComponent: 2, animated: false)
        itemCPicker.selectRow(0, inComponent: 0, animated: false);itemCPicker.selectRow(0, inComponent: 1, animated: false)
        itemDPicker.selectRow(0, inComponent: 0, animated: false);itemDPicker.selectRow(0, inComponent: 1, animated: false)
        itemEPicker.selectRow(0, inComponent: 0, animated: false);itemEPicker.selectRow(0, inComponent: 1, animated: false)
        itemFPicker.selectRow(0, inComponent: 0, animated: false);itemFPicker.selectRow(0, inComponent: 1, animated: false)
        itemGPicker.selectRow(0, inComponent: 0, animated: false);itemGPicker.selectRow(0, inComponent: 1, animated: false)
        itemHPicker.selectRow(0, inComponent: 0, animated: false);itemHPicker.selectRow(0, inComponent: 1, animated: false)
        itemIPicker.selectRow(0, inComponent: 0, animated: false);itemIPicker.selectRow(0, inComponent: 1, animated: false)
        
        
        itemAPicker.reloadAllComponents()
        itemBPicker.reloadAllComponents()
        itemCPicker.reloadAllComponents()
        itemDPicker.reloadAllComponents()
        itemEPicker.reloadAllComponents()
        itemFPicker.reloadAllComponents()
        itemGPicker.reloadAllComponents()
        itemHPicker.reloadAllComponents()
        itemIPicker.reloadAllComponents()
        
        itemACell.textLabel?.text = SizeModel.defaultEmptyValue
        itemBCell.textLabel?.text = SizeModel.defaultEmptyValue
        itemCCell.textLabel?.text = SizeModel.defaultEmptyValue
        itemDCell.textLabel?.text = SizeModel.defaultEmptyValue
        itemECell.textLabel?.text = SizeModel.defaultEmptyValue
        itemFCell.textLabel?.text = SizeModel.defaultEmptyValue
        itemGCell.textLabel?.text = SizeModel.defaultEmptyValue
        itemHCell.textLabel?.text = SizeModel.defaultEmptyValue
        itemICell.textLabel?.text = SizeModel.defaultEmptyValue
        
        
    }
    
    @IBAction func cancelView(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveContactView(_ sender: UIBarButtonItem) {
        
        if !isEditingContact{
            
            self.insertNewContact(nameTextField.text ?? "",
                                  sex: Int16(sexSC.selectedSegmentIndex),
                                  notes: notesTextView.text != NOTES_PLACEHOLDER_TEXT ? notesTextView.text : "" ,
                                  blouseshirt: itemACell.textLabel?.text ?? SizeModel.defaultEmptyValue,
                                  pants: itemBCell.textLabel?.text ?? SizeModel.defaultEmptyValue,
                                  shoes: itemCCell.textLabel?.text ?? SizeModel.defaultEmptyValue,
                                  suitdress: itemDCell.textLabel?.text ?? SizeModel.defaultEmptyValue,
                                  bhtshirt: itemECell.textLabel?.text ?? SizeModel.defaultEmptyValue,
                                  hat: itemFCell.textLabel?.text ?? SizeModel.defaultEmptyValue,
                                  socks: itemGCell.textLabel?.text ?? SizeModel.defaultEmptyValue,
                                  ring: itemHCell.textLabel?.text ?? SizeModel.defaultEmptyValue)
            
        }else{
            self.updateContact(contactToEdit!,
                               name: nameTextField.text!,
                               sex: Int16(sexSC.selectedSegmentIndex),
                               notes: notesTextView.text != NOTES_PLACEHOLDER_TEXT ? notesTextView.text : "" ,
                               blouseshirt: (itemACell.textLabel?.text)!,
                               pants: (itemBCell.textLabel?.text)!,
                               shoes: (itemCCell.textLabel?.text)!,
                               suitdress: (itemDCell.textLabel?.text)!,
                               bhtshirt: (itemECell.textLabel?.text)!,
                               hat: (itemFCell.textLabel?.text)!,
                               socks: (itemGCell.textLabel?.text)!,
                               ring: (itemHCell.textLabel?.text)!)
        }
        
    }

    @IBAction func removeContact(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction( UIAlertAction(title: "Delete Contact", style:.destructive, handler: { [weak self] _ in
            // Removing contact
            self?.performSegue(withIdentifier: ContactsTableViewController.UNWIND_TO_CONTACTS_TABLE_VIEW_CONTROLLER, sender: self)
            self?.removeContact((self?.contactToEdit)!)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    
    }
    
    // MARK: - Pickers
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == itemBPicker{
            // country, width & length
            return 3
        }
        // country & size
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == itemAPicker{
            if component == 0{
                return SizeModel.blouseshirt[gender].keys.count
                
            }else if component == 1{
                return SizeModel.blouseshirt[gender][ selectedCountryBlouseShirt ?? Array(SizeModel.blouseshirt[gender].keys)[0] ]?.removeDuplicates().count ?? SizeModel.blouseshirt[gender][Array(SizeModel.blouseshirt[gender].keys)[0]]!.removeDuplicates().count
            }
        
        }else if pickerView == itemBPicker{
            if component == 0{ return SizeModel.pants[gender].keys.count
            }else if component == 1 {
                return SizeModel.pants[gender][selectedCountryPants ?? Array(SizeModel.pants[gender].keys)[0]]?[0].removeDuplicates().count ?? SizeModel.pants[gender][Array(SizeModel.pants[gender].keys)[0]]![0].removeDuplicates().count
            
            }else if component == 2 {
                return SizeModel.pants[gender][selectedCountryPants ?? Array(SizeModel.pants[gender].keys)[0]]?[1].removeDuplicates().count ?? SizeModel.pants[gender][Array(SizeModel.pants[gender].keys)[0]]![1].removeDuplicates().count
            }
        }else if pickerView == itemCPicker{
            if component == 0{
                return SizeModel.shoes[gender].keys.count
                
            } else if component == 1{
                return SizeModel.shoes[gender][ selectedCountryShoes ?? Array(SizeModel.shoes[gender].keys)[0] ]?.removeDuplicates().count ?? SizeModel.shoes[gender][Array(SizeModel.shoes[gender].keys)[0] ]!.removeDuplicates().count
            }
        }else if pickerView == itemDPicker{
            
            if component == 0{ return SizeModel.dresssuit[gender].keys.count }
            
            else if component == 1{
                return SizeModel.dresssuit[gender][ selectedCountryDressSuit ?? Array(SizeModel.dresssuit[gender].keys)[0] ]?.removeDuplicates().count ?? SizeModel.dresssuit[gender][Array(SizeModel.dresssuit[gender].keys)[0] ]!.removeDuplicates().count
            }
        }else if pickerView == itemEPicker{
            if component == 0{
                return SizeModel.bhtshirt[gender].keys.count
                
            }else if component == 1{
                return SizeModel.bhtshirt[gender][ selectedCountryBHTshirt ?? Array(SizeModel.bhtshirt[gender].keys)[0] ]?.removeDuplicates().count ?? SizeModel.bhtshirt[gender][Array(SizeModel.bhtshirt[gender].keys)[0] ]!.removeDuplicates().count
            }
        }else if pickerView == itemFPicker{
            if component == 0{
                return SizeModel.hat[gender].keys.count
            }
            else if component == 1{
                return SizeModel.hat[gender][ selectedCountryHat ?? Array(SizeModel.hat[gender].keys)[0] ]?.removeDuplicates().count ?? SizeModel.hat[gender][Array(SizeModel.hat[gender].keys)[0] ]!.removeDuplicates().count
                
            }
        }else if pickerView == itemGPicker{
            if component == 0{ return SizeModel.socks[gender].keys.count }
            
            else if component == 1{
                return SizeModel.socks[gender][ selectedCountrySocks ?? Array(SizeModel.socks[gender].keys)[0] ]?.removeDuplicates().count ?? SizeModel.socks[gender][Array(SizeModel.socks[gender].keys)[0] ]!.removeDuplicates().count
                
            }
        }else if pickerView == itemHPicker{
            if component == 0{
                return SizeModel.ring[0].keys.count
                
            }else if component == 1{
                return SizeModel.ring[0][ selectedCountryRing ?? Array(SizeModel.ring[0].keys)[0] ]?.removeDuplicates().count ?? SizeModel.ring[0][Array(SizeModel.ring[0].keys)[0] ]!.removeDuplicates().count
                
            }
        }
        return 0
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var title = ""
        if pickerView == itemAPicker{
            if component == 0{ title = Array(SizeModel.blouseshirt[gender].keys)[row] }
            else if component == 1{
                title = SizeModel.blouseshirt[gender][selectedCountryBlouseShirt ?? Array(SizeModel.blouseshirt[gender].keys)[0]]?.removeDuplicates()[row] ?? SizeModel.blouseshirt[gender][Array(SizeModel.blouseshirt[gender].keys)[0]]!.removeDuplicates()[row]
            }
        }else if pickerView == itemBPicker{
            if component == 0{ title = Array(SizeModel.pants[gender].keys)[row]
                
            }else if component == 1 {
                title = SizeModel.pants[gender][ selectedCountryPants ?? Array(SizeModel.pants[gender].keys)[0] ]?[0].removeDuplicates()[row] ??  SizeModel.pants[gender][Array(SizeModel.pants[gender].keys)[0] ]![0].removeDuplicates()[row]
            }else if component == 2 {
                title = SizeModel.pants[gender][ selectedCountryPants ?? Array(SizeModel.pants[gender].keys)[0] ]?[1].removeDuplicates()[row] ??  SizeModel.pants[gender][Array(SizeModel.pants[gender].keys)[0] ]![1].removeDuplicates()[row]
            }
        }else if pickerView == itemCPicker{
            if component == 0{ title = Array(SizeModel.shoes[gender].keys)[row] }
                
            else if component == 1{
                title = SizeModel.shoes[gender][selectedCountryShoes ?? Array(SizeModel.shoes[gender].keys)[0]]?.removeDuplicates()[row] ?? SizeModel.shoes[gender][Array(SizeModel.shoes[gender].keys)[0]]!.removeDuplicates()[row]
            }
        }else if pickerView == itemDPicker{
            if component == 0{ title = Array(SizeModel.dresssuit[gender].keys)[row] }
                
            else if component == 1{
                title = SizeModel.dresssuit[gender][selectedCountryDressSuit ?? Array(SizeModel.dresssuit[gender].keys)[0]]?.removeDuplicates()[row] ?? SizeModel.dresssuit[gender][Array(SizeModel.dresssuit[gender].keys)[0]]!.removeDuplicates()[row]
            }
        }else if pickerView == itemEPicker{
            if component == 0{ title = Array(SizeModel.bhtshirt[gender].keys)[row] }
                
            else if component == 1{
                title = SizeModel.bhtshirt[gender][selectedCountryBHTshirt ?? Array(SizeModel.bhtshirt[gender].keys)[0]]?.removeDuplicates()[row] ?? SizeModel.bhtshirt[gender][Array(SizeModel.bhtshirt[gender].keys)[0]]!.removeDuplicates()[row]
                
            }
        }else if pickerView == itemFPicker{
            if component == 0{ title = Array(SizeModel.hat[gender].keys)[row] }
            
            else if component == 1{
                title = SizeModel.hat[gender][selectedCountryHat ?? Array(SizeModel.hat[gender].keys)[0]]?.removeDuplicates()[row] ?? SizeModel.hat[gender][Array(SizeModel.hat[gender].keys)[0]]!.removeDuplicates()[row]
            }
        }else if pickerView == itemGPicker{
            if component == 0{ title = Array(SizeModel.socks[gender].keys)[row] }
            
            else if component == 1{
                title = SizeModel.socks[gender][selectedCountrySocks ?? Array(SizeModel.socks[gender].keys)[0]]?.removeDuplicates()[row] ?? SizeModel.socks[gender][Array(SizeModel.socks[gender].keys)[0]]!.removeDuplicates()[row]
            }
        }else if pickerView == itemHPicker{
            if component == 0{
                title = Array(SizeModel.ring[0].keys)[row]
            
            }else if component == 1{
                title = SizeModel.ring[0][selectedCountryRing ?? Array(SizeModel.ring[0].keys)[0]]?.removeDuplicates()[row] ?? SizeModel.ring[0][Array(SizeModel.ring[0].keys)[0]]!.removeDuplicates()[row]
            }
        }
        return title
    }
    

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        nameTextField.resignFirstResponder()
        notesTextView.resignFirstResponder()
        // TODO - when the user press the picker show the default value OR is not selectable
        var size = SizeModel.defaultEmptyValue // TODO add default value
        if pickerView == itemAPicker{
            if component == 0{
                selectedCountryBlouseShirt = Array(SizeModel.blouseshirt[gender].keys)[row]
                size = SizeModel.blouseshirt[gender][selectedCountryBlouseShirt ?? Array(SizeModel.blouseshirt[gender].keys)[0]]![0]
                itemAPicker.selectRow(0, inComponent: 1, animated: false)
                pickerView.reloadComponent(1)
            }else if component == 1{ size = SizeModel.blouseshirt[gender][selectedCountryBlouseShirt ?? Array(SizeModel.blouseshirt[gender].keys)[0]]!.removeDuplicates()[row] }
            itemACell.textLabel?.text = SizeModel.country[selectedCountryBlouseShirt ?? Array(SizeModel.blouseshirt[gender].keys)[0]]! + " " + size
        }else if pickerView == itemBPicker{
//            let wDefault = SizeModel.pants[gender][Array(SizeModel.pants[gender].keys)[0]]![0].removeDuplicates()[row]
//            let lDefault = SizeModel.pants[gender][Array(SizeModel.pants[gender].keys)[0]]![1].removeDuplicates()[row]
            if component == 0{
                selectedCountryPants = Array(SizeModel.pants[gender].keys)[row]
                pantsWidth = nil; pantsLength = nil
                pickerView.reloadComponent(1); pickerView.reloadComponent(2)
                itemBPicker.selectRow(0, inComponent: 1, animated: false)
                itemBPicker.selectRow(0, inComponent: 2, animated: false)
            }else if component == 1 {
                pantsWidth = SizeModel.pants[gender][selectedCountryPants ?? Array(SizeModel.pants[gender].keys)[0]]![0].removeDuplicates()[row]// ?? wDefault
            
            }else if component == 2 {
                pantsLength = SizeModel.pants[gender][selectedCountryPants ?? Array(SizeModel.pants[gender].keys)[0]]![1].removeDuplicates()[row] //?? lDefault
                
            }
            let defaultCountry = Array(SizeModel.pants[gender].keys)[0]
            
            let w =  "\(pantsWidth ?? SizeModel.pants[gender][selectedCountryPants ?? defaultCountry]![0][0] )" //?? wDefault
            let l = " \(pantsLength ?? SizeModel.pants[gender][selectedCountryPants ?? defaultCountry]![1][0] )" // ?? lDefault
            
            itemBCell.textLabel?.text = SizeModel.country[selectedCountryPants ?? defaultCountry]! + " " + w + SizeModel.WAIST + l + SizeModel.LENGTH
        }else if pickerView == itemCPicker{
            if component == 0{
                selectedCountryShoes = Array(SizeModel.shoes[gender].keys)[row]
                size = SizeModel.shoes[gender][selectedCountryShoes ?? Array(SizeModel.shoes[gender].keys)[0]]![0]
                pickerView.reloadComponent(1)
                itemCPicker.selectRow(0, inComponent: 1, animated: false)
            }else if component == 1{ size = SizeModel.shoes[gender][selectedCountryShoes ?? Array(SizeModel.shoes[gender].keys)[0]]!.removeDuplicates()[row] }
            itemCCell.textLabel?.text = SizeModel.country[selectedCountryShoes ?? Array(SizeModel.shoes[gender].keys)[0]]! + " " + size
        }else if pickerView == itemDPicker {
            if component == 0{
                selectedCountryDressSuit = Array(SizeModel.dresssuit[gender].keys)[row]
                size = SizeModel.dresssuit[gender][selectedCountryDressSuit ?? Array(SizeModel.dresssuit[gender].keys)[0]]![0]
                pickerView.reloadComponent(1)
                itemDPicker.selectRow(0, inComponent: 1, animated: false)
            }else if component == 1{ size = SizeModel.dresssuit[gender][selectedCountryDressSuit ?? Array(SizeModel.dresssuit[gender].keys)[0]]!.removeDuplicates()[row] }
            itemDCell.textLabel?.text = SizeModel.country[selectedCountryDressSuit ?? Array(SizeModel.dresssuit[gender].keys)[0]]! + " " + size
            
        }else if pickerView == itemEPicker{
            if component == 0{
                selectedCountryBHTshirt = Array(SizeModel.bhtshirt[gender].keys)[row]
                size = SizeModel.bhtshirt[gender][selectedCountryBHTshirt ?? Array(SizeModel.bhtshirt[gender].keys)[0]]![0]
                pickerView.reloadComponent(1)
                itemEPicker.selectRow(0, inComponent: 1, animated: false)
            }else if component == 1{ size = SizeModel.bhtshirt[gender][selectedCountryBHTshirt ?? Array(SizeModel.bhtshirt[gender].keys)[0]]!.removeDuplicates()[row] }
            itemECell.textLabel?.text = SizeModel.country[selectedCountryBHTshirt ?? Array(SizeModel.bhtshirt[gender].keys)[0]]! + " " + size
        }else if pickerView == itemFPicker{
            if component == 0{
                selectedCountryHat = Array(SizeModel.hat[gender].keys)[row]
                size = SizeModel.hat[gender][selectedCountryHat ?? Array(SizeModel.hat[gender].keys)[0]]![0]
                pickerView.reloadComponent(1)
                itemFPicker.selectRow(0, inComponent: 1, animated: false)
            }else if component == 1{ size = SizeModel.hat[gender][selectedCountryHat ?? Array(SizeModel.hat[gender].keys)[0]]!.removeDuplicates()[row] }
            itemFCell.textLabel?.text = SizeModel.country[selectedCountryHat ?? Array(SizeModel.hat[gender].keys)[0]]! + " " + size
        }else if pickerView == itemGPicker{
            if component == 0{
                selectedCountrySocks = Array(SizeModel.socks[gender].keys)[row]
                size = SizeModel.socks[gender][selectedCountrySocks ?? Array(SizeModel.socks[gender].keys)[0]]![0]
                pickerView.reloadComponent(1)
                itemGPicker.selectRow(0, inComponent: 1, animated: false)
                
            }else if component == 1{ size = SizeModel.socks[gender][selectedCountrySocks ?? Array(SizeModel.socks[gender].keys)[0]]!.removeDuplicates()[row] }
            itemGCell.textLabel?.text = SizeModel.country[selectedCountrySocks ?? Array(SizeModel.socks[gender].keys)[0]]! + " " + size
        }else if pickerView == itemHPicker{
            if component == 0{
                selectedCountryRing = Array(SizeModel.ring[0].keys)[row]
                size = SizeModel.ring[0][selectedCountryRing ?? Array(SizeModel.ring[0].keys)[0]]![0]
                pickerView.reloadComponent(1)
                itemHPicker.selectRow(0, inComponent: 1, animated: false)
            }else if component == 1{
                size = SizeModel.ring[0][selectedCountryRing ?? Array(SizeModel.ring[0].keys)[0]]!.removeDuplicates()[row]
            }
            itemHCell.textLabel?.text = SizeModel.country[selectedCountryRing ?? Array(SizeModel.ring[0].keys)[0]]! + " " + size
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return rowsVisibilityState.count
    }
    

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            break
        case 1:
            return "\(SizeModel.Item.blouseshirt.emoji(sex)) \(SizeModel.Item.blouseshirt.name(sex))"
        case 2:
            return "\(SizeModel.Item.pants.emoji(sex)) \(SizeModel.Item.pants.name(sex))"
        case 3:
            return "\(SizeModel.Item.shoes.emoji(sex)) \(SizeModel.Item.shoes.name(sex))"
        case 4:
            return "\(SizeModel.Item.dresssuit.emoji(sex)) \(SizeModel.Item.dresssuit.name(sex))"
        case 5:
            return "\(SizeModel.Item.bhtshirt.emoji(sex)) \(SizeModel.Item.bhtshirt.name(sex))"
        case 6:
            return "\(SizeModel.Item.hat.emoji(sex)) \(SizeModel.Item.hat.name(sex))"
        case 7:
            return "\(SizeModel.Item.socks.emoji(sex)) \(SizeModel.Item.socks.name(sex))"
        case 8:
            return "\(SizeModel.Item.ring.emoji(sex)) \(SizeModel.Item.ring.name(sex))"
        case 9:
            return "\(SizeModel.Item.bh.emoji(sex)) \(SizeModel.Item.bh.name(sex))"
        default:
            return ""
        }
        
        return ""
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 3
        }else if section == 10{
            return 1
        }
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = 44.0
        let heightLarge:CGFloat = 216.0
        
        if indexPath.row == 1{
            for (i, isVisible) in rowsVisibilityState.enumerated(){
                // The first section is not related to any article
                if indexPath.section != 0 && indexPath.section == i{
                    height = (selectedIndex == [i, 0]) && isVisible ? heightLarge : 0
                }
            }
        }
        
        // Refers to Notes
        if indexPath.row == 2 {
            return height * 1.5
        }
        
//        selectedCountry = nil
        return height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //selectedCountry = nil
        
        if indexPath != [0,1] {
            selectedIndex = indexPath
        }
        nameTextField.resignFirstResponder()
        notesTextView.resignFirstResponder()
        // Ignoring selections on rows 1
        if indexPath.row == 0  {
            for i in 0..<rowsVisibilityState.count {
                if indexPath.section == 0{
                    rowsVisibilityState[0] = true
                }else if indexPath.section == i{

                    rowsVisibilityState[i] = rowsVisibilityState[i] ? false : true
                }else{
                    
                    rowsVisibilityState[i] = false
                }
            }
        }
        tableView.beginUpdates()
        tableView.endUpdates()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - TextField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == NOTES_PLACEHOLDER_TEXT {
            textView.text = ""
            textView.textColor = .black
            textView.becomeFirstResponder()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == ""{
            textView.text = NOTES_PLACEHOLDER_TEXT
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
}

extension Array where Element:Equatable{
    func removeDuplicates() -> [Element]{
        var result = [Element]()
        
        for value in self{
            if result.contains(value) == false{
                result.append(value)
            }
        }
        return result
    }
}
