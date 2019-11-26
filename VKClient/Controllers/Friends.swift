//
//  FriendsView.swift
//  VKClient
//
//  Created by Михаил Маслов on 14/09/2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class FriendsTableView: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tableFriends: UITableView!
    
    var users : Results<UserItem>!
    var usersRequest = List<UserItem>()
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
        vk.getFriends { [weak self] users in
            self?.usersRequest = users.response!.items
            self?.tableView.reloadData()
        }
        self.users = RealmDataBase.shared.getUsers()
        setKeysForSections()
        setSearchBar()
    }
    
    
    // Set Search Bar on FriendsView
    
    fileprivate func setSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
    
    
    // Set Sections on FriendsView
    
    fileprivate func setKeysForSections() {
        for name in self.users {
            let usrKey = String(name.lastName.prefix(1))
            if var usrValues = self.usersDictionary[usrKey] {
                usrValues.append(name)
                self.usersDictionary[usrKey] = usrValues
            } else {
                self.usersDictionary[usrKey] = [name]
            }
        }
        self.userSectionTitles = [String](self.usersDictionary.keys)
        self.userSectionTitles = self.userSectionTitles.sorted(by: { $0 < $1})
        self.tableFriends.reloadData()
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
            cell.nameLabel.text = filteredUsers[indexPath.row].firstName + " " + filteredUsers[indexPath.row].lastName
            cell.avatar.image.kf.setImage(with: url, options: [.cacheOriginalImage])
            
        } else {
            let userKey = userSectionTitles[indexPath.section]
            if let userValues = usersDictionary[userKey] {
                let url = URL(string: userValues[indexPath.row].photo_50)
                cell.nameLabel.text = userValues[indexPath.row].firstName + " " + userValues[indexPath.row].lastName
                cell.avatar.image.kf.setImage(with: url, options: [.cacheOriginalImage])
                
                
                
                
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
                //                let url = URL(string: filteredUsers[index].photo_50)
                destinationController.navigationItem.title = filteredUsers[index].firstName + " " + filteredUsers[index].lastName
                //                destinationController.photosUser.kf.setImage(with: url)
                
            } else {
                //                let url = URL(string: usersInSection[index].photo_50)
                if usersInSection.count > index {
                    destinationController.navigationItem.title = usersInSection[index].firstName + " " + usersInSection[index].lastName
                    //                    destinationController.photosUser.kf.setImage(with: url)
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

