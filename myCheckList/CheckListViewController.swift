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
        print(indexPath.section)
        
          if indexPath.row == 0 {
            label.text = "Walk the dog"
          } else if indexPath.row == 1 {
            label.text = "Brush my teeth"
          } else if indexPath.row == 2 {
            label.text = "Learn iOS development"
          } else if indexPath.row == 3 {
            label.text = "Soccer practice"
          } else if indexPath.row == 4 {
            label.text = "Eat ice cream"
          }
          // End of new code block

          return cell
    }
}


