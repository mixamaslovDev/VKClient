//
//  SearchGroupTable.swift
//  VKClient
//
//  Created by Михаил Маслов on 14/09/2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import UIKit
import Kingfisher


class SearchGroupTableView: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var GroupSearchBar: UISearchBar!
    //    var groups1 = groupsF
    var groups = [ItemSearchGroup]()
    
    
    override func viewDidLoad() {
        GroupSearchBar.delegate = self
        let vkGroups = VkApi()
        vkGroups.getGroupsSearch(text: "Apple") { [weak self] groups in
            self?.groups = groups.response.items
            self?.tableView.reloadData()
        }
        
    }
    
    
    func searchBar(_ search:UISearchBar, textDidChange searchText: String) {
        let vkGroups = VkApi()
        
        vkGroups.getGroupsSearch(text: searchText) { [weak self] groups in
            self?.groups = groups.response.items
            self?.tableView.reloadData()
            }
        
        if searchText.isEmpty {
            vkGroups.getGroupsSearch(text: "Apple") { [weak self] groups in
            self?.groups = groups.response.items
            self?.tableView.reloadData()
            }
        }
        
        }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "findGroupCell", for: indexPath) as! FindGroupCell
        let url = URL(string: groups[indexPath.row].photo100)
        
        cell.nameFindGroup.text = groups[indexPath.row].name
        cell.imageFindGroup.kf.setImage(with: url)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
