//
//  GroupsTable.swift
//  VKClient
//
//  Created by Михаил Маслов on 14/09/2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import UIKit
import RealmSwift
class GroupsTableView: UITableViewController {
    
    var groups = List<GroupsItem>()
    
//    @IBAction func returnToMyGroups(unwindSegue: UIStoryboardSegue) {
//        if unwindSegue.identifier == "addGroup" {
//            guard let allGroups = unwindSegue.source as? SearchGroupTableView else { return }
//            guard let indexPath = allGroups.tableView.indexPathForSelectedRow else { return }
//
//            let group = allGroups.groups[indexPath.row]
//            if !groups.contains(where: { $0.name == group.name }) {
//                groups.append(allGroups.groups[indexPath.row])
//                tableView.insertRows(at: [IndexPath(row: groups.count - 1, section: 0)], with: .fade)
//            }
//        }
//    }
    
    override func viewDidLoad() {
        vk.getGroups { [weak self] groups in
                    self?.groups = groups.response!.items
                    self?.tableView.reloadData()
                }
       }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCells", for: indexPath) as! GroupsCell
        let url = URL(string: groups[indexPath.row].photo100)
        
        cell.nameGroup.text = groups[indexPath.row].name
        cell.groupPhoto.kf.setImage(with: url)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
