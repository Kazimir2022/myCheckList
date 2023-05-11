//
//  ViewController.swift
//  myCheckList
//
//  Created by Kazimir on 18.04.23.
//

import UIKit

class CheckListViewController: UITableViewController, AddItemViewControllerDelegate {

    
 func documentsDirectory() -> URL {
      let paths = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask)
      return paths[0]
    }

    func dataFilePath() -> URL {
      return documentsDirectory().appendingPathComponent("Checklists.plist")
    }
    
    
    
    
    func itemDetailViewControllerDidCancel(_ controller: AddItemViewController) {
        
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem) {
        //вставляем строку по указанному индексу
        
        let newRowIndex = items.count
          items.append(item)

          let indexPath = IndexPath(row: newRowIndex, section: 0)
          let indexPaths = [indexPath]
          tableView.insertRows(at: indexPaths, with: .automatic)
        saveChecklistItems()
        navigationController?.popViewController(animated: true)
    }
    func itemDetailViewController(
      _ controller: AddItemViewController,
      didFinishEditing item: ChecklistItem
    ) {
      if let index = items.firstIndex(of: item) { //узнаем под каким индексом находится редактируемый элемент в массиве
          print(index)                            // без соответсвия протоколу NSObject не будет доступен данный метод
          let indexPath = IndexPath(row: index, section: 0)// узнаем под каким индексом находится строка в таблице
          if let cell = tableView.cellForRow(at: indexPath) {// получаем ячейку из таблицы по индексу
              configureText(for: cell, with: item)//поиск лейбла по тагу, изм лейбл
        }
      }
        saveChecklistItems()
      navigationController?.popViewController(animated: true)
    }
    
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
    
        print("Documents folder is \(documentsDirectory())")
          print("Data file path is \(dataFilePath())")
        
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
    
    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        // 1 удаляем элемент из модели данных
        items.remove(at: indexPath.row)

        // 2 удаляем соответствующую строку из table view
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        saveChecklistItems()
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
        saveChecklistItems()
    }
    
    func configureCheckmark(
      for cell: UITableViewCell,
      with item: ChecklistItem
    ) { // переключение аксесуара
        /*
          if item.checked {
            cell.accessoryType = .checkmark
          } else {
            cell.accessoryType = .none
          }
         */
        let label = cell.viewWithTag(1001) as! UILabel// поиск элемента в ячейке

          if item.checked {
            label.text = "√"
          } else {
            label.text = ""
          }
      }
    
    func configureText(
      for cell: UITableViewCell,
      with item: ChecklistItem
    ) {
      let label = cell.viewWithTag(1000) as! UILabel
      label.text = item.text
    }
    func saveChecklistItems() {
      // 1
      let encoder = PropertyListEncoder()
      // 2
      do {
        // 3
        let data = try encoder.encode(items)
        // 4
        try data.write(
          to: dataFilePath(),
          options: Data.WritingOptions.atomic)
        // 5
      } catch {
        // 6
        print("Error encoding item array: \(error.localizedDescription)")
      }
    }
    
    // MARK: - Navigation
    override func prepare(
      for segue: UIStoryboardSegue,
      sender: Any?
    ) {
      // 1
      if segue.identifier == "AddItem" {
        // 2
        let controller = segue.destination as! AddItemViewController
        // 3
        controller.delegate = self
      } else if segue.identifier == "EditItem" {
          
          let controller = segue.destination as! AddItemViewController
              controller.delegate = self
          
          //if let indexP = tableView.indexPath(for: <#T##UITableViewCell#>)
          
          
          //индекс строки по указанной ячейке(тип <#T##UITableViewCell#>).sender - отправитель(тип Any?)
          if let indexPath = tableView.indexPath(
                for: sender as! UITableViewCell) {
                controller.itemToEdit = items[indexPath.row]
      }
    }
  }
    
            
}


