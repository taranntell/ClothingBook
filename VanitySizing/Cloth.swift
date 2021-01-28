//
//  Cloth.swift
//  VanitySizing
//
//  Created by Diego Loop on 13.09.17.
//  Copyright © 2017 Herzly. All rights reserved.
//

import UIKit
import CoreData

class Cloth: NSManagedObject
{
    
    // A 1 Blouse| Shirt
    // B 2 Pants
    // C 3 Shoes
    // D 4 Dress | Suit
    // E 5 BH    | TShirt
    // F 6 Hat
    // G 7 Socks
    // H 8 Ring
    class func createContact(in context:NSManagedObjectContext,
                             name:String,
                             sex:Int16,
                             notes:String,
                             blouseshirt:String,
                             pants:String,
                             shoes:String,
                             suitdress:String,
                             bhtshirt:String,
                             hat:String,
                             socks:String,
                             ring:String) -> Cloth{
        let user = Cloth(context: context)
        
        user.blouseshirt = blouseshirt
        user.pants = pants
        user.shoes = shoes
        user.suitdress = suitdress
        user.bhtshirt = bhtshirt
        user.hat = hat
        user.socks = socks
        user.ring = ring
        //user.bh = bh
        
        let userContext = User(context: user.managedObjectContext!)
        user.dressedUser = userContext
        user.dressedUser?.name = name
        user.dressedUser?.gender = sex
        user.dressedUser?.notes = notes
        
        return user
    }
    
    class func editContact(in context:NSManagedObjectContext, contact:Cloth,
                           name:String,
                           sex:Int16,
                           notes:String,
                           blouseshirt:String,
                           pants:String,
                           shoes:String,
                           suitdress:String,
                           bhtshirt:String,
                           hat:String,
                           socks:String,
                           ring:String) -> Cloth{
        let editedUser = contact
        contact.dressedUser?.name = name
        contact.dressedUser?.gender = sex
        contact.dressedUser?.notes = notes
        
        contact.blouseshirt = blouseshirt
        contact.pants = pants
        contact.shoes = shoes
        contact.suitdress = suitdress
        contact.bhtshirt = bhtshirt
        contact.hat = hat
        contact.socks = socks
        contact.ring = ring
        
        return editedUser
    }
    
    class func removeContact(in context:NSManagedObjectContext, contact:Cloth) -> Cloth{
        let removedContact = contact
        context.delete(removedContact)
        return removedContact
    }

    override func prepareForDeletion() {
        print("removing contact from Cloth...")
    }
    
    public func items(selCloth:Cloth) -> Dictionary<String, Any>{
        let dic = ["Name":selCloth.dressedUser?.name,
                   "Top Size":selCloth.bhtshirt,
                   "Shoes Size":selCloth.shoes]
        
        return dic as Any as! Dictionary<String, Any>
    }
    
    public func sizeItems(cloth:Cloth) -> Array<(String, String, String)>{
        let sex = SizeModel.findSex( Int((cloth.dressedUser?.gender)!) )
        
        // Article Section List
        //    Women    | Men
        // A 1 Blouse| Shirt
        // B 2 Pants
        // C 3 Shoes
        // D 4 Dress | Suit
        // E 5 BH    | TShirt
        // F 6 Hat
        // G 7 Socks
        // F 8 Ring
        var sizeInfo = [(SizeModel.Item.blouseshirt.name(sex), cloth.blouseshirt ?? "", SizeModel.Item.blouseshirt.emoji(sex)),
                        (SizeModel.Item.pants.name(sex), cloth.pants ?? "", SizeModel.Item.pants.emoji(sex)),
                        (SizeModel.Item.shoes.name(sex), cloth.shoes ?? "", SizeModel.Item.shoes.emoji(sex)),
                        
                        (SizeModel.Item.dresssuit.name(sex), cloth.suitdress ?? "", SizeModel.Item.dresssuit.emoji(sex)),
                        (SizeModel.Item.bhtshirt.name(sex), cloth.bhtshirt ?? "", SizeModel.Item.bhtshirt.emoji(sex)),
                        
                        (SizeModel.Item.hat.name(sex), cloth.hat ?? "", SizeModel.Item.hat.emoji(sex)),
                        (SizeModel.Item.socks.name(sex), cloth.socks ?? "", SizeModel.Item.socks.emoji(sex))]
        
        sizeInfo.append((SizeModel.Item.ring.name(sex), cloth.ring ?? "", SizeModel.Item.ring.emoji(sex)))
        
        sizeInfo.append((cloth.dressedUser?.notes ?? "", "", SizeModel.Item.notes.emoji(sex)))
    
        return sizeInfo
    }
}

