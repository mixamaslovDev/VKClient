//
//  FriendsSearch.swift
//  VKClient
//
//  Created by Михаил Маслов on 17.10.2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import UIKit

extension FriendsTableView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
        
    }
}
