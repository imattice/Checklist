//
//  Checklist.swift
//  Checklists
//
//  Created by Ike Mattice on 6/10/16.
//  Copyright © 2016 Ike Mattice. All rights reserved.
//

import UIKit

class Checklist: NSObject {
    var name = ""
    
    init(name: String) {
        self.name = name
        super.init()
    }
}
