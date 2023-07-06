//
//  ChecklistItem.swift
//  myCheckList
//
//  Created by Kazimir on 25.04.23.
//




//MARK: make a new object
import Foundation
class ChecklistItem: NSObject, Codable {
  var text = ""
  var checked = false
  var dueDate = Date()
  var shouldRemind = false
  var itemID = -1
  
  override init() {
    super.init()
    itemID = DataModel.nextChecklistItemID()
  }
  
}
