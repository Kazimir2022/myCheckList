//
//  AddItemTableViewController.swift
//  myCheckList
//
//  Created by Kazimir on 25.04.23.
//

import UIKit
protocol AddItemViewControllerDelegate: AnyObject {
  func itemDetailViewControllerDidCancel(
    _ controller: ItemDetailViewController)
  func itemDetailViewController(
    _ controller: ItemDetailViewController,
    didFinishAdding item: ChecklistItem  //добавление
  )
  func itemDetailViewController(
    _ controller: ItemDetailViewController,
    didFinishEditing item: ChecklistItem // редактирование
  )
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
  //ссылка на делегат
  weak var delegate: AddItemViewControllerDelegate?
  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var shouldRemindSwitch: UISwitch!
  @IBOutlet weak var datePicker: UIDatePicker!
  
  var itemToEdit: ChecklistItem?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.largeTitleDisplayMode = .never
   
    if let item = itemToEdit {
      title = "Edit Item"
      textField.text = item.text
      doneBarButton.isEnabled = true
      shouldRemindSwitch.isOn = item.shouldRemind
      datePicker.date = item.dueDate
    }
    
  }
  //вьюконтроллер вызывает метод перед тем как сцена станет видимой
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
  }
  
  @IBAction func cancel(){
    delegate?.itemDetailViewControllerDidCancel(self)
    
  }
  @IBAction func done(){
    
    if let item = itemToEdit {
      item.text = textField.text!
      
      item.shouldRemind = shouldRemindSwitch.isOn
      item.dueDate = datePicker.date
      item.scheduleNotification()
      
      delegate?.itemDetailViewController(
        self,
        didFinishEditing: item)
    } else {
      let item = ChecklistItem()// создаем новый экземпляр
      item.text = textField.text!
      
      item.shouldRemind = shouldRemindSwitch.isOn
      item.dueDate = datePicker.date
      item.scheduleNotification()
      delegate?.itemDetailViewController(self, didFinishAdding: item)
    }
  }
  
  override func tableView(
    _ tableView: UITableView,
    willSelectRowAt indexPath: IndexPath
  ) -> IndexPath? {// так как это опционал поэтому можно вернуть nil
    return nil
  }
  
  // MARK: - Text Field Delegates
  func textField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool {
    let oldText = textField.text!       ///
    let stringRange = Range(range, in: oldText)!//конвертация NSRange в Range
    
    let newText = oldText.replacingCharacters(
      in: stringRange,
      with: string)
    doneBarButton.isEnabled = !newText.isEmpty
    return true
  }
  
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    doneBarButton.isEnabled = false
    return true
  }
}
