//
//  ChecklistItem.swift
//  Checklists
//
//  Created by M.I. Hollemans on 27/07/15.
//  Copyright © 2015 Razeware. All rights reserved.
//

import Foundation
import UIKit

class ChecklistItem: NSObject, NSCoding {
    var itemID: Int
    var text = ""
    var checked = false
    var shouldRemind = false
    var dueDate = NSDate()

    init(text: String, checked: Bool, itemID: Int) {
        self.text = text
        self.checked = false
        self.itemID = itemID
    }
    override init() {
        itemID = DataModel.nextChecklistItemID()
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObjectForKey("Text") as! String
        checked = aDecoder.decodeBoolForKey("Checked")
        dueDate = aDecoder.decodeObjectForKey("DueDate") as! NSDate
        shouldRemind = aDecoder.decodeBoolForKey("ShouldRemind")
        itemID = aDecoder.decodeIntegerForKey("ItemID")
        super.init()
    }

    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: "Text")
        aCoder.encodeBool(checked, forKey: "Checked")
    }
    func toggleChecked() {
        checked = !checked
    }
    func scheduleNotification() {
        let existingNotification = notificationForThisItem()
        if let notification = existingNotification {
            print("Found an exisiting notification \(notification)")
            UIApplication.sharedApplication().cancelLocalNotification(notification)
        }
        
        if shouldRemind && dueDate.compare(NSDate()) != .OrderedAscending {
            let localNotification = UILocalNotification()
            localNotification.fireDate = dueDate
            localNotification.timeZone = NSTimeZone.defaultTimeZone()
            localNotification.alertBody = text
            localNotification.soundName = UILocalNotificationDefaultSoundName
            localNotification.userInfo = ["ItemID": itemID]
            
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            
            print("Scheduled notification \(localNotification) for itemID \(itemID)")
        }
    }
    func notificationForThisItem() -> UILocalNotification? {
        let allNotifications = UIApplication.sharedApplication().scheduledLocalNotifications!
        
        for notification in allNotifications {
            if let number = notification.userInfo?["ItemID"] as? Int where number == itemID {
                return notification
            }
        }
        return nil
    }
    
    deinit {
        if let notification = notificationForThisItem() {
            print("Removing existing notification \(notification)")
            UIApplication.sharedApplication().cancelLocalNotification(notification)
        }
    }
}
