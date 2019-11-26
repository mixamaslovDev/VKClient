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
    
    func saveUsersData(_ data: List<UserItem>) {
        do {
            try realm.write {
                realm.add(data, update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    func saveGroupsData(_ data: List<GroupsItem>) {
//        do {
            try! realm.write {
                realm.add(data, update: .modified)
            }
//        } catch {
//            print(error)
        }
//    }
    
    
    func getUsers() -> Results<UserItem> {
        return realm.objects(UserItem.self)
    }
    
    func getGroups() -> Results<GroupsItem> {
        return realm.objects(GroupsItem.self)
    }
    
    func deleteData() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
}
