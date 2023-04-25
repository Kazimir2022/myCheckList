//
//  ViewController.swift
//  myCheckList
//
//  Created by Kazimir on 18.04.23.
//

import UIKit

class CheckListViewController: UITableViewController {
    let row0text = "Walk the dog"
      let row1text = "Brush teeth"
      let row2text = "Learn iOS development"
      let row3text = "Soccer practice"
      let row4text = "Eat ice cream"

    var row0checked = false
    var row1checked = true
    var row2checked = true
    var row3checked = false
    var row4checked = true
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
            label.text = row0text
          } else if indexPath.row == 1 {
            label.text = row1text
          } else if indexPath.row == 2 {
            label.text = row2text
          } else if indexPath.row == 3 {
            label.text = row3text
          } else if indexPath.row == 4 {
            label.text = row4text
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
              row0checked.toggle()
            } else if indexPath.row == 1 {
              row1checked.toggle()
            } else if indexPath.row == 2 {
              row2checked.toggle()
            } else if indexPath.row == 3 {
              row3checked.toggle()
            } else if indexPath.row == 4 {
              row4checked.toggle()
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
        isChecked = row0checked
      } else if indexPath.row == 1 {
        isChecked = row1checked
      } else if indexPath.row == 2 {
        isChecked = row2checked
      } else if indexPath.row == 3 {
        isChecked = row3checked
      } else if indexPath.row == 4 {
        isChecked = row4checked
      }

      if isChecked {
        cell.accessoryType = .checkmark
      } else {
        cell.accessoryType = .none
      }
    }
    
    
    
    
    
    
}


