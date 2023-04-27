//
//  AddItemTableViewController.swift
//  myCheckList
//
//  Created by Kazimir on 25.04.23.
//

import UIKit

class AddItemTableViewController: UITableViewController {
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
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

}
