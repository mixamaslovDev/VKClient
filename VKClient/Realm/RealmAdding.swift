//
//  RealmAdding.swift
//  VKClient
//
//  Created by Михаил Маслов on 16.11.2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import RealmSwift

class ReamlAdd {
    
    func saveUsersData(_ data: FriendsResponse) {
        do {
            let realm = try Realm()
            guard realm.objects(FriendsResponse.self).first == nil  else { return }
            print(Realm.Configuration.defaultConfiguration.fileURL as Any)
            try realm.write {
                realm.add(data)
            }
        } catch {
            print(error)
        }
    }
    
    func saveGroupsData(_ data: GroupsResponse) {
        do {
            let realm = try Realm()
            guard realm.objects(GroupsResponse.self).first == nil  else { return }
            print(Realm.Configuration.defaultConfiguration.fileURL as Any)
            try realm.write {
                realm.add(data)
            }
        } catch {
            print(error)
        }
    }
    
}
