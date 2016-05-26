//
//  ViewController.swift
//  Checklists
//
//  Created by Ike Mattice on 5/25/16.
//  Copyright © 2016 Ike Mattice. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem", forIndexPath: indexPath)
        
        let label = cell.viewWithTag(1000) as! UILabel
        
        if indexPath.row == 0 {
            label.text = "Walk the doge"
        } else if indexPath.row == 1 {
            label.text = "Brush Teef"
        } else if indexPath.row == 2 {
            label.text = "Learn iOS development"
        } else if indexPath.row == 3 {
            label.text = "DOTA practice"
        } else if indexPath.row == 4 {
            label.text = "Remind self that you should be learning iOS"
        }
        
    return cell
    }

}

