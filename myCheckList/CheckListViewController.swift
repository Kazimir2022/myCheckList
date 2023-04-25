//
//  ViewController.swift
//  myCheckList
//
//  Created by Kazimir on 18.04.23.
//

import UIKit

class CheckListViewController: UITableViewController {
    //MARK: - Initializer methods
   var row0item = ChecklistItem()
   var row1item = ChecklistItem()
   var row2item = ChecklistItem()
   var row3item = ChecklistItem()
   var row4item = ChecklistItem()
    
  //MARK:  type annotation
  // var row100:ChecklistItem
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    //MARK: - Table View Data Sourse
    override func tableView(
      _ tableView: UITableView,
      numberOfRowsInSection section: Int
    ) -> Int {
      return 5
    }

    override func tableView(
      _ tableView: UITableView,
      cellForRowAt indexPath: IndexPath // метод вызывается для каждой строки
    ) -> UITableViewCell {              //  в каждой строке есть лейбл с тегом
      let cell = tableView.dequeueReusableCell(
        withIdentifier: "ChecklistItem",
        for: indexPath)
        
        // Add the following code
          let label = cell.viewWithTag(1000) as! UILabel//поиск конкретного вью с тегом и возвр ссылку на элемент
        
        if indexPath.row == 0 {
            label.text = row0item.text
          } else if indexPath.row == 1 {
            label.text = row1item.text
          } else if indexPath.row == 2 {
            label.text = row2item.text
          } else if indexPath.row == 3 {
            label.text = row3item.text
          } else if indexPath.row == 4 {
            label.text = row4item.text
          }
          // End of new code block
       configureCheckmark(for: cell, at: indexPath)
          return cell
    }
    
    
    // MARK: - Table View Delegate
    override func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if indexPath.row == 0 {
                row0item.checked.toggle()
            } else if indexPath.row == 1 {
                row1item.checked.toggle()
            } else if indexPath.row == 2 {
                row2item.checked.toggle()
            } else if indexPath.row == 3 {
                row3item.checked.toggle()
            } else if indexPath.row == 4 {
                row4item.checked.toggle()
            }
            configureCheckmark(for: cell, at: indexPath)
          }
          tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func configureCheckmark(
      for cell: UITableViewCell,
      at indexPath: IndexPath
    ) {
      var isChecked = false

      if indexPath.row == 0 {
          isChecked = row0item.checked
      } else if indexPath.row == 1 {
        isChecked = row1item.checked
      } else if indexPath.row == 2 {
        isChecked = row2item.checked
      } else if indexPath.row == 3 {
        isChecked = row3item.checked
      } else if indexPath.row == 4 {
        isChecked = row4item.checked
      }

      if isChecked {
        cell.accessoryType = .checkmark
      } else {
        cell.accessoryType = .none
      }
    }
    
    
    
    
    
    
}


