//
//  RealmManager.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 3/20/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import RealmSwift

public func evRealm() -> Realm {
    return RealmManager.manager.realm
}

class RealmManager: NSObject {
    
    var realm: Realm!
    static var manager: RealmManager = RealmManager()
    
    private override init() {
        super.init()
        
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
//                    migration.enumerateObjects(ofType: UserInfo.className()) { oldObject, newObject in
//                        // combine name fields into a single field
//                        
//                        newObject!["tokenKey"] = nil
//                    }
                    
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        realm = try! Realm()
    }
}







