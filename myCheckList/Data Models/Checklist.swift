//
//  CheckList.swift
//  myCheckList
//
//  Created by Kazimir on 20.05.23.
//

import UIKit

class Checklist: NSObject, Codable {
  var name = ""
  var items = [ChecklistItem]()     // add this line»
  
  init(name: String) {
    self.name = name
    super.init()
  }
  
  func countUncheckedItems() -> Int {
    var count = 0
    for item in items where !item.checked {
      count += 1
    }
    return count
  }
}
