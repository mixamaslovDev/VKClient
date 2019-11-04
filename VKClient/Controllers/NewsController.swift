//
//  newsController.swift
//  VKClient
//
//  Created by Михаил Маслов on 10.10.2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import UIKit

class NewsContoller: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "NewsFeedPost", bundle: nil), forCellReuseIdentifier: "postCell")
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCell
           
           return cell
    }
    
}
