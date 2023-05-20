//
//  AddItemTableViewController.swift
//  myCheckList
//
//  Created by Kazimir on 25.04.23.
//

import UIKit
protocol AddItemViewControllerDelegate: AnyObject {
  func itemDetailViewControllerDidCancel(
    _ controller: AddItemViewController)
  func itemDetailViewController(
    _ controller: AddItemViewController,
    didFinishAdding item: ChecklistItem  //добавление
  )
  func itemDetailViewController(
      _ controller: AddItemViewController,
      didFinishEditing item: ChecklistItem // редактирование
    )
}

  class AddItemViewController: UITableViewController, UITextFieldDelegate {
     //ссылка на делегат
    weak var delegate: AddItemViewControllerDelegate?
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
      var itemToEdit: ChecklistItem?
      
      
    override func viewDidLoad() {
        super.viewDidLoad()
      
        navigationItem.largeTitleDisplayMode = .never
        //variable shadowing — you create a "shadow" instance of the itemToEdit variable
        // создаем теневой экземпляр для блока if
        if let itemToEdit = itemToEdit {
          title = "Edit Item"
          textField.text = itemToEdit.text
          doneBarButton.isEnabled = true
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
        
         if let item = itemToEdit {//
            item.text = textField.text!
            delegate?.itemDetailViewController(
              self,
              didFinishEditing: item)
          } else {
            let item = ChecklistItem()// создаем новый экземпляр
            item.text = textField.text!
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
