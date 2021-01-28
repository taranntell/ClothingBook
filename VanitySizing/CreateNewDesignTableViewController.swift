//
//  CreateNewDesignTableViewController.swift
//  VanitySizing
//
//  Created by Diego Loop on 16.11.17.
//  Copyright © 2017 Herzly. All rights reserved.
//

import UIKit

class CreateContactTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var sexSC: UISegmentedControl!
    @IBOutlet var notesTextView: UITextView!
    
    @IBOutlet var itemOneCell: UITableViewCell!
    @IBOutlet var itemOnePicker: UIPickerView!
    
    @IBOutlet var itemTwoCell: UITableViewCell!
    @IBOutlet var itemTwoPicker: UIPickerView!
    
    @IBOutlet var itemThreeCell: UITableViewCell!
    @IBOutlet var itemThreePicker: UIPickerView!
    
    @IBOutlet var itemFourCell: UITableViewCell!
    @IBOutlet var itemFourPicker: UIPickerView!
    
    @IBOutlet var itemFiveCell: UITableViewCell!
    @IBOutlet var itemFivePicker: UIPickerView!
    
    @IBOutlet var itemSixCell: UITableViewCell!
    @IBOutlet var itemSixPicker: UIPickerView!
    
    @IBOutlet var itemSevenCell: UITableViewCell!
    @IBOutlet var itemSevenPicker: UIPickerView!
    
    @IBOutlet var itemEightCell: UITableViewCell!
    @IBOutlet var itemEightPicker: UIPickerView!
    
    @IBOutlet var itemNineCell: UITableViewCell!
    @IBOutlet var itemNinePicker: UIPickerView!
    
    public static var GIRL_INDEX = 0
    public static var GUY_INDEX = 1
    
    var sex:SizeModel.Sex!

    var selectedIndex:IndexPath?
    // total of 6 sections (top, shoes, pants, hat,...) all invisible at the first time
    var rowsVisibilityState:Array = [true, false, false, false, false, false, false, false, false, false]
    
    // Storing pant size
    var pantsWidth:String?, pantsLength:String?
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: remove! Only test purposes
        //sexSC.selectedSegmentIndex = 1 // start with a guy

        sex = SizeModel.findSex(sexSC.selectedSegmentIndex)
        
    }
    
    // MARK: - DB
    
    // Article Section List
    // 0: Name, Sex, Notes
    // 1: Top
    // 2: Pants
    // 3: Shoes
    // 4: Hat
    // 5: Gloves
    // 6: Socks
    // 7: Belt
    // 8: Ring
    // 9: BH
    internal func insertNewContact(_ name:String,
                                   sex:Int16,
                                   notes:String,
                                   top:String,
                                   pants:String,
                                   shoes:String,
                                   hat:String,
                                   gloves:String,
                                   socks:String,
                                   belt:String,
                                   ring:String,
                                   bh:String){}
    
    // MARK: - Actions
    @IBAction func sexChanged(_ sender: UISegmentedControl) {
        // reload tableview with girl sizes
        sex = SizeModel.findSex(sexSC.selectedSegmentIndex)
        
        tableView.reloadData()
    }
    
    @IBAction func cancelView(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveContactView(_ sender: UIBarButtonItem) {
        print("Saving...")
        
        // TODO: -- are needed?
        self.insertNewContact(nameLabel.text ?? "",
                              sex: Int16(sexSC.selectedSegmentIndex),
                              notes: notesTextView.text ?? "",
                              top: itemOneCell.textLabel?.text ?? "--",
                              pants: itemTwoCell.textLabel?.text ?? "--",
                              shoes: itemThreeCell.textLabel?.text ?? "--",
                              hat: itemFourCell.textLabel?.text ?? "--",
                              gloves: itemFiveCell.textLabel?.text ?? "--",
                              socks: itemSixCell.textLabel?.text ?? "--",
                              belt: itemSevenCell.textLabel?.text ?? "--",
                              ring: itemEightCell.textLabel?.text ?? "--",
                              bh: itemNineCell.textLabel?.text ?? "--")
        self.navigationController?.popViewController(animated: true)
    }
  
    // MARK: - Pickers
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == itemTwoPicker{
            // width and length
            return 2
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //if pickerView == shoesPicker { return SizeModel.shoesSizeListEU.count }
        if pickerView == itemOnePicker{
            return SizeModel.Item.top.sizes(sex).count
        
        }else if pickerView == itemTwoPicker{
            if component == 0 {
                return SizeModel.Item.pants.sizes(sex, width:true).count
            }
            else if component == 1 {
                return SizeModel.Item.pants.sizes(sex, width:false, length:true).count
            }
        }else if pickerView == itemThreePicker{
            return SizeModel.Item.shoes.sizes(sex).count
        
        }else if pickerView == itemFourPicker{
            return SizeModel.Item.hat.sizes(sex).count
        
        }else if pickerView == itemFivePicker{
            return SizeModel.Item.gloves.sizes(sex).count
        
        }else if pickerView == itemSixPicker{
            return SizeModel.Item.socks.sizes(sex).count
        
        }else if pickerView == itemSevenPicker{
            return SizeModel.Item.belt.sizes(sex).count
            
        }else if pickerView == itemEightPicker{
            return SizeModel.Item.ring.sizes(sex).count
            
        }else if pickerView == itemNinePicker{
            return SizeModel.Item.bh.sizes(sex).count
            
        }
        
        
        return SizeModel.Item.shoes.sizes(sex).count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        var title = ""
        
        if pickerView == itemOnePicker{ title = SizeModel.Item.top.sizes(sex)[row]
        
        }else if pickerView == itemTwoPicker{
            if component == 0 {
                title = SizeModel.Item.pants.sizes(sex, width:true)[row]
            }
            else if component == 1 {
                title = SizeModel.Item.pants.sizes(sex, width:false, length:true)[row]
            }
        }else if pickerView == itemThreePicker{ title = SizeModel.Item.shoes.sizes(sex)[row]
        }else if pickerView == itemFourPicker{ title = SizeModel.Item.hat.sizes(sex)[row]
        }else if pickerView == itemFivePicker{ title = SizeModel.Item.gloves.sizes(sex)[row]
        }else if pickerView == itemSixPicker{ title = SizeModel.Item.socks.sizes(sex)[row]
        }else if pickerView == itemSevenPicker{ title = SizeModel.Item.belt.sizes(sex)[row]
        }else if pickerView == itemEightPicker{ title = SizeModel.Item.ring.sizes(sex)[row]
        }else if pickerView == itemNinePicker{ title = SizeModel.Item.bh.sizes(sex)[row] }
        
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == itemOnePicker{
            itemOneCell.textLabel?.text = SizeModel.Item.top.sizes(sex)[row]
        
        }else if pickerView == itemTwoPicker{
            if component == 0 {
                pantsWidth = SizeModel.Item.pants.sizes(sex, width:true)[row]
            }
            else if component == 1 {
                pantsLength = SizeModel.Item.pants.sizes(sex, width:false, length:true)[row]
            }
            itemTwoCell.textLabel?.text = "W\(pantsWidth ?? "-") L\(pantsLength ?? "-" )"
        
        }else if pickerView == itemThreePicker{ itemThreeCell.textLabel?.text = SizeModel.Item.shoes.sizes(sex)[row]
        }else if pickerView == itemFourPicker { itemFourCell.textLabel?.text = SizeModel.Item.hat.sizes(sex)[row]
        }else if pickerView == itemFivePicker{ itemFiveCell.textLabel?.text = SizeModel.Item.gloves.sizes(sex)[row]
        }else if pickerView == itemSixPicker{ itemSixCell.textLabel?.text = SizeModel.Item.socks.sizes(sex)[row]
        }else if pickerView == itemSevenPicker{ itemSevenCell.textLabel?.text = SizeModel.Item.belt.sizes(sex)[row]
        }else if pickerView == itemEightPicker{ itemEightCell.textLabel?.text = SizeModel.Item.ring.sizes(sex)[row]
        }else if pickerView == itemNinePicker{ itemNineCell.textLabel?.text = SizeModel.Item.bh.sizes(sex)[row] }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if sex == SizeModel.Sex.Girl{
            return rowsVisibilityState.count
        }else{
            return rowsVisibilityState.count - 1
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            break
        case 1:
            return "\(SizeModel.Item.top.emoji(sex)) \(SizeModel.Item.top.name(sex))"
        case 2:
            return "\(SizeModel.Item.pants.emoji(sex)) \(SizeModel.Item.pants.name(sex))"
        case 3:
            return "\(SizeModel.Item.shoes.emoji(sex)) \(SizeModel.Item.shoes.name(sex))"
        case 4:
            return "\(SizeModel.Item.hat.emoji(sex)) \(SizeModel.Item.hat.name(sex))"
        case 5:
            return "\(SizeModel.Item.gloves.emoji(sex)) \(SizeModel.Item.gloves.name(sex))"
        case 6:
            return "\(SizeModel.Item.socks.emoji(sex)) \(SizeModel.Item.socks.name(sex))"
        case 7:
            return "\(SizeModel.Item.belt.emoji(sex)) \(SizeModel.Item.belt.name(sex))"
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
        
        return height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        
        // Ignoring selections on rows 1
        if indexPath.row == 0 {
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        return cell
    }
    
}
