//
//  AllListsViewController.swift
//  Checklists
//
//  Created by Ike Mattice on 6/10/16.
//  Copyright © 2016 Ike Mattice. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate {
    var dataModel: DataModel!
    
    func cellForTableView(tableView: UITableView) -> UITableViewCell {
        let cellItentifier = "Cell"
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellItentifier) {
            return cell
        } else {
            return UITableViewCell(style: .Default, reuseIdentifier: cellItentifier)
        }
    }
    func listDetailViewControllerDidCancel(controller: ListDetailViewController) {
        dismissViewControllerAnimated(true, completion: nil) }
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingChecklist checklist: Checklist) {
        let newRowIndex = dataModel.lists.count
        
        dataModel.lists.append(checklist)
        
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0) 
        let indexPaths = [indexPath] 
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic) 
        dismissViewControllerAnimated(true, completion: nil)
    }
    func listDetailViewController(controller: ListDetailViewController, didFinishEditingChecklist checklist: Checklist) {
        if let index = dataModel.lists.indexOf(checklist) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0) 
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                cell.textLabel!.text = checklist.name }
        }
        dismissViewControllerAnimated(true, completion: nil) 
    }
    func navigationController(navigationController: UINavigationController,
                              willShowViewController viewController: UIViewController, animated: Bool){
        if viewController === self {
            NSUserDefaults.standardUserDefaults().setInteger(-1, forKey: "ChecklistIndex")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.delegate = self
        
        let index = NSUserDefaults.standardUserDefaults().integerForKey("ChecklistIndex")
        
        if index != -1 {
            let checklist = dataModel.lists[index]
            performSegueWithIdentifier("ShowChecklist", sender: checklist)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        
        return dataModel.lists.count
    }
    override func tableView(tableView: UITableView,
                            cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = cellForTableView(tableView)
        let checklist = dataModel.lists[indexPath.row]
        cell.textLabel!.text = checklist.name
        cell.accessoryType = .DetailDisclosureButton
        
        return cell
    }
    override func tableView(tableView: UITableView,
                            didSelectRowAtIndexPath indexPath: NSIndexPath){
        NSUserDefaults.standardUserDefaults().setInteger(indexPath.row, forKey: "ChecklistIndex")
        
        let checklist = dataModel.lists[indexPath.row]
        
        performSegueWithIdentifier("ShowChecklist", sender: checklist)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowChecklist" {
            let controller = segue.destinationViewController as! ChecklistViewController
            
            controller.checklist = sender as! Checklist
        } else if segue.identifier == "AddChecklist" {
            let navigationController = segue.destinationViewController as! UINavigationController 
            let controller = navigationController.topViewController as! ListDetailViewController
            
            controller.delegate = self
            controller.checklistToEdit = nil
        }
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        dataModel.lists.removeAtIndex(indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
}
