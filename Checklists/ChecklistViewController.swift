//
//  ViewController.swift
//  Checklists
//
//  Created by Ike Mattice on 5/25/16.
//  Copyright © 2016 Ike Mattice. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    // This declares that items will hold an array of ChecklistItem objects 
    // but it does not actually create that array.
    // At this point, items does not have a value yet.
    var items: [ChecklistItem]

    required init?(coder aDecoder: NSCoder) {
        
        // This instantiates the array. Now items contains a valid array object, 
        // but the array has no ChecklistItem objects inside it yet.
        items = [ChecklistItem]()
        
        // This instantiates a new ChecklistItem object. Notice the ().
        let row0item = ChecklistItem() 
        // Give values to the data items inside the new ChecklistItem object.
        row0item.text = "Walk the dog" 
        row0item.checked = false
        // This adds the ChecklistItem object into the items array.
        items.append(row0item)
        
        let row1item = ChecklistItem() 
        row1item.text = "Brush my teeth"
        row1item.checked = true 
        items.append(row1item)
        
        let row2item = ChecklistItem() 
        row2item.text = "Learn iOS development" 
        row2item.checked = true 
        items.append(row2item)
        
        let row3item = ChecklistItem() 
        row3item.text = "Soccer practice" 
        row3item.checked = false 
        items.append(row3item)
        
        let row4item = ChecklistItem() 
        row4item.text = "Eat ice cream" 
        row4item.checked = true 
        items.append(row4item)        
        
        super.init(coder: aDecoder)
    }

    func configureCheckmarkForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
        
        if item.checked {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }    
    }
    func configureTextForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem", forIndexPath: indexPath)
        let item = items[indexPath.row]
        
        configureTextForCell(cell, withChecklistItem: item)
        configureCheckmarkForCell(cell, withChecklistItem: item)
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) { 
            let item = items[indexPath.row]
            
            item.toggleChecked()
            configureCheckmarkForCell(cell, withChecklistItem: item) 
        }
            
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        items.removeAtIndex(indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    
    @IBAction func addItem() {
        let newRowIndex = items.count
        let item = ChecklistItem()
            item.text = "I am a new row"
            item.checked = false
        
        items.append(item)
        
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
}