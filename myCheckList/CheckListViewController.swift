//
//  ViewController.swift
//  myCheckList
//
//  Created by Kazimir on 18.04.23.
//

import UIKit

class CheckListViewController: UITableViewController {
    //MARK: - Initializer methods
  
    var items = [ChecklistItem]()//«This is your new data model.
    
    
  //MARK:  type annotation
  // var row100:ChecklistItem
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Replace previous code with the following
          let item1 = ChecklistItem()
          item1.text = "Walk the dog"
          items.append(item1)

          let item2 = ChecklistItem()
          item2.text = "Brush my teeth"
          item2.checked = true
          items.append(item2)

          let item3 = ChecklistItem()
          item3.text = "Learn iOS development"
          item3.checked = true
          items.append(item3)

          let item4 = ChecklistItem()
          item4.text = "Soccer practice"
          items.append(item4)

          let item5 = ChecklistItem()
          item5.text = "Eat ice cream"
          items.append(item5)
        /*
          let item6 = ChecklistItem()
          item6.text = "New text"
        items.append(item6)
        */
        
        
    }
    
    //MARK: - Table View Data Sourse
    override func tableView(
      _ tableView: UITableView,
      numberOfRowsInSection section: Int
    ) -> Int {
        return items.count // количество элементов массива вместо жестко закодированого кода
    }

    override func tableView(
      _ tableView: UITableView,
      cellForRowAt indexPath: IndexPath // метод вызывается для каждой строки
    ) -> UITableViewCell {              //  в каждой строке есть лейбл с тегом
      let cell = tableView.dequeueReusableCell(
        withIdentifier: "ChecklistItem",
        for: indexPath)
        
        // получаем один элемент массива обектов(одну строку)
            //запрашиваем объект в индексе который соответствует номеру строки
        let item = items[indexPath.row]
        
      configureText(for: cell, with: item)
      
     configureCheckmark(for: cell, with: item)
          return cell
    }
    
    
    // MARK: - Table View Delegate
    override func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ) {
        if let cell = tableView.cellForRow(at: indexPath) {
            // Replace everything inside this `if` condition
            // with the following
            let item = items[indexPath.row]
            item.checked.toggle()

            configureCheckmark(for: cell, with: item)
          }
          tableView.deselectRow(at: indexPath, animated: true)
    }
    @IBAction func addItem(_ sender: Any) {
       //узнаем каким будет индекс нашей новой строки
          let newRowIndex = items.count
        
            // добавляем новый элемент в data model
          let item = ChecklistItem()
          item.text = "I am a new row"
          items.append(item)

        // создаем объект указывающий на новую строку
          let indexPath = IndexPath(row: newRowIndex, section: 0)
        
        // создаем временный массив который содержит один элемент
          let indexPaths = [indexPath]
        
            // добавляем новую строку по индексу
        tableView.insertRows(at: indexPaths, with: .automatic)
      
        
    }
    
    
    func configureCheckmark(
      for cell: UITableViewCell,
      with item: ChecklistItem
    ) {
        
          if item.checked {
            cell.accessoryType = .checkmark
          } else {
            cell.accessoryType = .none
          }
      }
    
    
    
    func configureText(
      for cell: UITableViewCell,
      with item: ChecklistItem
    ) {
      let label = cell.viewWithTag(1000) as! UILabel
      label.text = item.text
    }
    
    
    
            
}


