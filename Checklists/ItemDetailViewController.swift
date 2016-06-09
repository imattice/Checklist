//
//  ItemDetailViewController.swift
//  Checklists
//
//  Created by Ike Mattice on 6/6/16.
//  Copyright © 2016 Ike Mattice. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController)
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem)
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    var itemToEdit: ChecklistItem?
    weak var delegate: ItemDetailViewControllerDelegate?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.enabled = true
        }
    }
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    @IBAction func cancel() {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    @IBAction func done() {
        if let item = itemToEdit {
            item.text = textField.text!
            delegate?.itemDetailViewController(self, didFinishEditingItem: item)
        } else {
            let item = ChecklistItem()
            item.text = textField.text!
            item.checked = false
            
            delegate?.itemDetailViewController(self, didFinishAddingItem: item)
        }
    }
}
