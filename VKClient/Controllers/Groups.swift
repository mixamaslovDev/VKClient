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
    
    var groups: Results<GroupsItem>!
//    var groupsRequest = List<GroupsItem>()
    var token: NotificationToken?
    
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
        super .viewDidLoad()
        vk.getGroups { groups in }
        groups = RealmDataBase.shared.getGroups()
//        self.groups = RealmDataBase.shared.getGroups()
        self.notificatoinRealm()
        self.tableView.reloadData()
//        print(groups)
    }
    
    
    // Realm Notification
    
    fileprivate func notificatoinRealm() {
        self.token = groups?.observe {  (changes: RealmCollectionChange) in
            self.groups = RealmDataBase.shared.getGroups()
            switch changes {
            case .initial(let results):
                print(results)
            case let .update(results, deletions, insertions, modifications):
                self.tableView.reloadData()
//                self.insertInTable(indexPath: insertions.map{IndexPath(row: $0, section: 0)})
//                self.deleteInTable(indexPath: deletions.map{IndexPath(row: $0, section: 0)})
//                self.updateInTable(indexPath: modifications.map{IndexPath(row: $0, section: 0)})
//                print(results)
            case .error(let error):
                print(error)
            }
//            print("Data is changed")
        }
        
    }
    
    // Functions for update information on tableview
    
    func insertInTable(indexPath: [IndexPath]) {
        tableView.beginUpdates()
        tableView.insertRows(at: indexPath, with: .none)
        tableView.endUpdates()
    }
    
    func deleteInTable(indexPath: [IndexPath]) {
        tableView.beginUpdates()
        tableView.deleteRows(at: indexPath, with: .none)
        tableView.endUpdates()
    }
    
    
    func updateInTable(indexPath: [IndexPath]) {
        tableView.beginUpdates()
        tableView.reloadRows(at: indexPath, with: .none)
        tableView.endUpdates()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCells", for: indexPath) as! GroupsCell
        
         let url = URL(string: groups[indexPath.row].photo100)
        
        cell.nameGroup.text = groups?[indexPath.row].name
        cell.groupPhoto.image.kf.setImage(with: url, options: [.cacheOriginalImage])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete {
    //            groups.remove(at: indexPath.row)
    //            tableView.deleteRows(at: [indexPath], with: .fade)
    //        }
    //    }
    
}
