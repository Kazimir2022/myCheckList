//
//  CheckList.swift
//  myCheckList
//
//  Created by Kazimir on 20.05.23.
//

import UIKit

class Checklist: NSObject, Codable {
  var name = ""
  var items = [ChecklistItem]()
  
  init(name: String) {
    self.name = name
    super.init()
  }
  
  func countUncheckedItems() -> Int {
    return items.reduce(0) {
      cnt,item in cnt + (item.checked ? 0 : 1)
    }
  }
}
