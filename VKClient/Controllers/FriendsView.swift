//
//  FriendsView.swift
//  VKClient
//
//  Created by Михаил Маслов on 14/09/2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import UIKit
import Kingfisher

class FriendsTableView: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tableFriends: UITableView!
    
    var users = [UserItem]()
       var usersDictionary = [String: [UserItem]]()
       var filteredUsers = [UserItem]()
       var userSectionTitles = [String]()
    
    let searchController = UISearchController(searchResultsController: nil)
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = false
        
        
        for name in users {
            let usrKey = String(name.lastName.prefix(1))
            if var usrValues = usersDictionary[usrKey] {
                usrValues.append(name)
                usersDictionary[usrKey] = usrValues
            } else {
                usersDictionary[usrKey] = [name]
            }
        }
        
        userSectionTitles = [String](usersDictionary.keys)
        userSectionTitles = userSectionTitles.sorted(by: { $0 < $1})
        tableFriends.reloadData()
        
    
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredUsers.count
        }
        else {
            let usrKey = userSectionTitles[section]
            if let userValues = usersDictionary[usrKey] {
                return userValues.count
            }
            
            return 0
        }
    }
    
    
    func filterContentForSearchText(_ searchText: String) {
        filteredUsers = users.filter { (user: UserItem) -> Bool in
            return user.lastName.lowercased().contains(searchText.lowercased())
        }
        
        tableFriends.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as! FriendsCell
        
        if isFiltering {
            let url = URL(string: filteredUsers[indexPath.row].photo_50)
            cell.nameLabel.text = filteredUsers[indexPath.row].lastName
            cell.userPhoto.kf.setImage(with: url)
            
        } else {
            let userKey = userSectionTitles[indexPath.section]
            if let userValues = usersDictionary[userKey] {
                let url = URL(string: filteredUsers[indexPath.row].photo_50)
                cell.nameLabel.text = userValues[indexPath.row].lastName
                cell.userPhoto.kf.setImage(with: url)

            }
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
        
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let userKey = userSectionTitles[indexPath.section]
            if var userValues = usersDictionary[userKey] {
                userValues.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)

            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "friendsPhotoSegue" {
            guard let destinationController = segue.destination as? PhotosTablesView else { return }
            
            let index = tableView.indexPathForSelectedRow?.row ?? 0
            
            var sectionKeys: [String] = [String](usersDictionary.keys)
            sectionKeys.sort(by: { $0 < $1 })
            
            let currentSection = sectionKeys[tableView.indexPathForSelectedRow!.section]
            
            guard let usersInSection = usersDictionary[currentSection] else { return }
            
            
            if isFiltering {

                destinationController.navigationItem.title = filteredUsers[index].lastName
//                destinationController.photosUser = filteredUsers[index].photo_50
                
            } else {
                
                if usersInSection.count > index {
                    destinationController.navigationItem.title = usersInSection[index].lastName
//                    destinationController.photosUser = usersInSection[index].photo[0]
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering {
            return filteredUsers.count
        } else {
            return userSectionTitles.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isFiltering {
            return nil
        } else {
            return userSectionTitles[section]
            
        }
        
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        return userSectionTitles
    }
}

