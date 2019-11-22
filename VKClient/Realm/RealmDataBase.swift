//
//  RealmAdding.swift
//  VKClient
//
//  Created by Михаил Маслов on 16.11.2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import RealmSwift

class RealmDataBase {
    

    let realm = try! Realm()
    static let shared = RealmDataBase()
    
    func saveUsersData(_ data: UserItem) {
        do {
            print(Realm.Configuration.defaultConfiguration.fileURL as Any)
            try realm.write {
                realm.add(data, update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    func saveGroupsData(_ data: GroupsItem) {
        do {
            print(Realm.Configuration.defaultConfiguration.fileURL as Any)
            try realm.write {
                realm.add(data, update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    
//    func getUsers() -> [FriendsResponse] {
//
//        return Array(realm.objects(FriendsResponse.self))
//    }
    
    func getGroups() -> Results <GroupsItem> {
        
        return realm.objects(GroupsItem.self)
    }
    
    func deleteData() {
        try! realm.write {
            realm.deleteAll()
            
        }
    }
}
