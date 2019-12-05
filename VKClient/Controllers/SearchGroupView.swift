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
    
    var groups = [ItemSearchGroup]()
    private var offset = 0
    private var offsetSearchBar = 0
    private var isSendingRequest = false
    private var searchText1 = String()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        (tableView as UIScrollView).delegate = self
        tableView.delegate = self
        GroupSearchBar.delegate = self
        getGroups()

    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let heightScroll = scrollView.contentSize.height
        let offsetScroll = scrollView.contentOffset.y
        let scroll = heightScroll - offsetScroll
        if (scroll / heightScroll * 100) < 40 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute:  {
                self.getGroups()
            })
            
        }
        
    }
    
    
    func getGroups() {
        if (isSendingRequest) {
            return
        }
        isSendingRequest = true
        vk.getGroupsSearch(offset: offset, text: "Apple") { [weak self] groups in
            self?.isSendingRequest = false
            self?.offset += groups.response.items.count
            self?.groups = groups.response.items
            self?.tableView.reloadData()
        }
        
        
        
    }
    
    func searchBar(_ search:UISearchBar, textDidChange searchText: String) {
        if (isSendingRequest) {
            return
        }
        vk.getGroupsSearch(offset: offsetSearchBar, text: searchText) { [weak self] groups in
//            self?.searchText1 = searchText
            self?.isSendingRequest = false
//            self?.offset += groups.response.items.count
            self?.groups = groups.response.items
            self?.tableView.reloadData()
        }
        
        if searchText.isEmpty {
            if (isSendingRequest) {
                return
            }
            vk.getGroupsSearch(offset: offsetSearchBar, text: "Apple") { [weak self] groups in
                self?.isSendingRequest = false
//                self?.offset += groups.response.items.count
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
        cell.imageFindGroup.image.kf.setImage(with: url, options: [.cacheOriginalImage])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

