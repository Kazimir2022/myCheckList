//
//  ViewController.swift
//  myCheckList
//
//  Created by Kazimir on 18.04.23.
//

import UIKit

class CheckListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Table View Data Sourse
    override func tableView(
      _ tableView: UITableView,
      numberOfRowsInSection section: Int
    ) -> Int {
      return 100
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
        
        if indexPath.row % 5 == 0 {
            label.text = "Walk the dog"
          } else if indexPath.row % 5 == 1 {
            label.text = "Brush my teeth"
          } else if indexPath.row % 5 == 2 {
            label.text = "Learn iOS development"
          } else if indexPath.row % 5 == 3 {
            label.text = "Soccer practice"
          } else if indexPath.row % 5 == 4 {
            label.text = "Eat ice cream"
          }
          // End of new code block

          return cell
    }
    
    
    // MARK: - Table View Delegate
    override func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .none {
              cell.accessoryType = .checkmark
            } else {
              cell.accessoryType = .none
            }
          }
      tableView.deselectRow(at: indexPath, animated: false)
    }
    
}


