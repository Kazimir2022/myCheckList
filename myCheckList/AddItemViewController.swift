//
//  AddItemTableViewController.swift
//  myCheckList
//
//  Created by Kazimir on 25.04.23.
//

import UIKit
protocol AddItemViewControllerDelegate: AnyObject {
  func addItemViewControllerDidCancel(
    _ controller: AddItemViewController)
  func addItemViewController(
    _ controller: AddItemViewController,
    didFinishAdding item: ChecklistItem
  )
}

  class AddItemViewController: UITableViewController, UITextFieldDelegate {
     //ссылка на делегат
    weak var delegate: AddItemViewControllerDelegate?
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
    }
    //вьюконтроллер вызывает метод перед тем как сцена станет видимой
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      textField.becomeFirstResponder()
    }
    
    @IBAction func cancel(){
        delegate?.addItemViewControllerDidCancel(self)
        
    }
    @IBAction func done(){
        
        let item = ChecklistItem()
          item.text = textField.text!

          delegate?.addItemViewController(self, didFinishAdding: item)

        
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
