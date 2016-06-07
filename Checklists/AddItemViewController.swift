//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Ike Mattice on 6/6/16.
//  Copyright © 2016 Ike Mattice. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        
//        if newText.length > 0 {
//            doneBarButton.enabled = true
//        } else {
//            doneBarButton.enabled = false
//        }  
        
//        this can be simply written as: 
        
        doneBarButton.enabled = (newText.length > 0)
        
        return true
    }
    
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
