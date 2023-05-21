//  ViewController.swift
//  myCheckList
//
//  Created by Kazimir on 18.04.23.

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
  var items = [ChecklistItem]()
  var checklist: Checklist!// свойству позволено быть nil до момента загрузки viewDidLoad() поэтому оно "!"
  
    override func viewDidLoad() {
        super.viewDidLoad()
      // Disable large titles for this view controller
      navigationItem.largeTitleDisplayMode = .never
          loadChecklistItems()
      title = checklist.name
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
        
        if let indexPath = tableView.indexPath(
              for: sender as! UITableViewCell) {
              controller.itemToEdit = items[indexPath.row]
    }
  }
}
  // MARK: - Actions
  func configureCheckmark(
    for cell: UITableViewCell,
    with item: ChecklistItem
  ) {
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
  func loadChecklistItems() {
    // 1
    let path = dataFilePath()
    // 2
    if let data = try? Data(contentsOf: path) {
      // 3
      let decoder = PropertyListDecoder()
      do {
        // 4
        items = try decoder.decode(
          [ChecklistItem].self,
          from: data)
          
          
      } catch {
        print("Error decoding item array: \(error.localizedDescription)")
      }
    }
  }
  func documentsDirectory() -> URL {
       let paths = FileManager.default.urls(
         for: .documentDirectory,
         in: .userDomainMask)
       return paths[0]
     }

     func dataFilePath() -> URL {
       return documentsDirectory().appendingPathComponent("Checklists.plist")
     }
  //MARK: - Table View Data Sourse
  override func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
      return items.count
  }

  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "ChecklistItem",
      for: indexPath)

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
      saveChecklistItems()
  }
  
  override func tableView(
      _ tableView: UITableView,
      commit editingStyle: UITableViewCell.EditingStyle,
      forRowAt indexPath: IndexPath
  ) {
      
      items.remove(at: indexPath.row)

      let indexPaths = [indexPath]
      tableView.deleteRows(at: indexPaths, with: .automatic)
      saveChecklistItems()
  }
  // MARK: - Add Item ViewController Delegates
  
     
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
     
    
    
   
        
            
}


