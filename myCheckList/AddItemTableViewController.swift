//
//  AddItemTableViewController.swift
//  myCheckList
//
//  Created by Kazimir on 25.04.23.
//

import UIKit
//чтобы проверить изменения, которые могут возникнуть в рузультате действия, нужно сделать вью контроллер делегатом для текстового поля
    // т.к. это UITableViewController(в отличии от Table View), он может быть Data Sorce и  Delegate, а также он станет Delegate для TextField(UIUITextViewDelegate)
  class AddItemTableViewController: UITableViewController, UITextViewDelegate {
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
        navigationController?.popViewController(animated: true)
    }
    @IBAction func done(){
       print("Contents of the text field: \(textField.text!)")
        navigationController?.popViewController(animated: true)
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
}
