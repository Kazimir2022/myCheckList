//
//  CheckList.swift
//  myCheckList
//
//  Created by Kazimir on 20.05.23.
//

import UIKit

class Checklist: NSObject {
  var name = ""
  var items = [ChecklistItem]()     // add this line»
  
  init(name: String) {
    self.name = name
    super.init()
  }
}
