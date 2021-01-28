//
//  AboutTableViewController.swift
//  VanitySizing
//
//  Created by Diego Loop on 15.01.18.
//  Copyright © 2018 Herzly. All rights reserved.
//

import UIKit
import MessageUI


class AboutTableViewController: UITableViewController, MFMailComposeViewControllerDelegate{
    
    let infoItems = ["About us",
                     "Terms and conditions",
                     "Send me an E-Mail",
                     "Version 1.0"]
    
    let aboutUsDetail = """
    One time Albert Einstein said:\n"Never memorize something that you can look up.”
    \nWe are a small, but encouraged team from Bavaria, Germany with one target in mind: Make you and your friends & family happy! This is just the beginning of what we hope to be an eternal journey. Our research and development will continue, so stay tuned for new releases, new features and new ways to remember your friends and family cloth size.
    \nPlease let us know if this app is helping you somehow, share your ideas or just to say hi by sending us your feedback - Email: diegoloop@me.com
    """
    
    let termsandconditionsDetail = """
    THE USER UNDERSTANDS THAT THIS APP SHOULD NOT BE USED WHILE OPERATING DANGEROUS MACHINERY OR DRIVING.
    \nThe user understands that this app is not responsible for any harm that might be caused. The user of this app assumes all risks in the use of the product, waving any claims against this app for any and all mental or physical injuries.
    \nIn no case will this app and their creators be liable for chance, accidental, special, direct or indirect damages resulting from use, misuse or defects of the software, instructions or documentation.
    \n\nPlease also observe that these size charts are only to be seen as a guide to helping you to remember your family and friend's size. Sizes may differ notably between different clothing manufacturers and brands.
    """
    
    var selectedIndex = 0
    
    
    // MARK - Actions
    
    @IBAction func closeInfo(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCell", for: indexPath)

        cell.textLabel?.text = infoItems[indexPath.item	]

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        
        if selectedIndex == 0 || selectedIndex == 1{
            performSegue(withIdentifier: "ShowInfoDetails", sender: self)
        }else if selectedIndex == 2{
            sendEmail()
        }
        
    }
    
    // MARK: - Mail
    
    func sendEmail()  {
        
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Could Not Send Email", message: "Please check your E-Mail configuration and try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        
        mailComposeVC.setToRecipients(["diegoloop@me.com"])
        
        return mailComposeVC
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier{
            switch identifier{
            case "ShowInfoDetails":
                if let advc = segue.destination as? AboutDetailsViewController{
                    advc.title = infoItems[selectedIndex]
                    //if infoItems[selectedIndex]
                    if selectedIndex == 0{
                        advc.details = aboutUsDetail
                    }
                    if selectedIndex == 1{
                        advc.details = termsandconditionsDetail
                    }
                }
                
            default: break
            }
        }
    }
}
