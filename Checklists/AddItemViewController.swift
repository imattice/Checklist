//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Ike Mattice on 6/6/16.
//  Copyright © 2016 Ike Mattice. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    @IBAction func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func done() {
        print("Contents of the text field: \(textField.text!)")
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}
