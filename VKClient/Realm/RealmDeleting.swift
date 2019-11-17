//
//  RealmDeleting.swift
//  VKClient
//
//  Created by Михаил Маслов on 17.11.2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import RealmSwift

class RealmDel {
   
    func deleteData() {
          do {
              let realm = try Realm()
              try realm.write {
                realm.deleteAll()
              }
          } catch {
              print(error)
          }
      }
}
