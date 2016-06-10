//
//  AllListsViewController.swift
//  Checklists
//
//  Created by Ike Mattice on 6/10/16.
//  Copyright © 2016 Ike Mattice. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController {

    func cellForTableView(tableView: UITableView) -> UITableViewCell {
        let cellItentifier = "Cell"
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellItentifier) {
            return cell
        } else {
            return UITableViewCell(style: .Default, reuseIdentifier: cellItentifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = cellForTableView(tableView)
        cell.textLabel!.text = "List \(indexPath.row)"
        
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        performSegueWithIdentifier("ShowChecklist", sender: nil)
    }
}
