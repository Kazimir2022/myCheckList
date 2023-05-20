//
//  AllListsViewController.swift
//  myCheckList
//
//  Created by Kazimir on 20.05.23.
//

import UIKit

class AllListsViewController: UITableViewController {
  let cellIdentifier = "ChecklistCell"
  var lists = [Checklist]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.prefersLargeTitles = true
    //we set up the cell identifier to be at the class level
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    // Add placeholder data
      var list = Checklist(name: "Birthdays")
      lists.append(list)

      list = Checklist(name: "Groceries")
      lists.append(list)

      list = Checklist(name: "Cool Apps")
      lists.append(list)

      list = Checklist(name: "To Do")
      lists.append(list)
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return 3
  }
  
  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: cellIdentifier, for: indexPath)
    cell.textLabel!.text = "List \(indexPath.row)"
    return cell
  }
  // MARK: - Table View Delegate
  override func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    performSegue(withIdentifier: "ShowChecklist", sender: nil)
  }
}
