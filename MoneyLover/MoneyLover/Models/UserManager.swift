//
//  UserManager.swift
//  MoneyLover
//
//  Created by Ngo Sy Truong on 11/24/16.
//  Copyright © 2016 Phùng Tùng. All rights reserved.
//

import UIKit

class UserManager: NSObject {
    
    lazy var managedObjectContext = CoreDataManager().managedObjectContext
    var dataStored = DataStored()
    var walletManager = WalletManager()
    var listWalletAvailable = ListWalletAvalable()
    
    func checkUserExisted(email: String) -> Bool {
        let listUser = dataStored.fetchAttributePredicate("User", attribute: "email", stringPredicate: email, inManagedObjectContext: managedObjectContext)
        if listUser.count == 0 {
            return false
        }
        return true
    }
    
    func checkUserLogin(email: String, password: String) -> Bool {
        let listUser = dataStored.fetchRecordsForEntity("User", inManagedObjectContext: managedObjectContext)
        for users in listUser {
            if let user = users as? User {
                if user.email == email && user.password == password {
                    if let userID = NSUserDefaults.standardUserDefaults().stringForKey("userID") {
                        if userID == user.email {
                            return true
                        } else {
                            NSUserDefaults.standardUserDefaults().setValue(user.email, forKey: "userID")
                            return true
                        }
                    } else {
                        NSUserDefaults.standardUserDefaults().setValue(user.email, forKey: "userID")
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func addUser(email: String, password: String) -> Bool {
        if let user = dataStored.createRecordForEntity("User", inManagedObjectContext: managedObjectContext) as? User {
            user.email = email
            user.password = password
            do {
                try managedObjectContext.save()
                return true
            } catch {
                return false
            }
        }
        return false
    }
    
    func addUserFromSocial(email: String) -> Bool {
        if let user = dataStored.createRecordForEntity("User", inManagedObjectContext: managedObjectContext) as? User {
            user.email = email
            NSUserDefaults.standardUserDefaults().setValue(user.email, forKey: "userID")
            do {
                try managedObjectContext.save()
                return true
            } catch {
                return false
            }
        }
        return false
    }
    
    func createWalletDefaultForRegister() {
        for wallet in listWalletAvailable.listWallet {
            walletManager.addWalletAvailable(wallet)
        }
    }
    
    func checkUserLoginSocial(email: String) -> Bool {
        let listUser = dataStored.fetchRecordsForEntity("User", inManagedObjectContext: managedObjectContext)
        for users in listUser {
            if let user = users as? User {
                if user.email == email {
                    if let userID = NSUserDefaults.standardUserDefaults().stringForKey("userID") {
                        if userID == user.email {
                            return true
                        } else {
                            NSUserDefaults.standardUserDefaults().setValue(user.email, forKey: "userID")
                            return true
                        }
                    } else {
                        NSUserDefaults.standardUserDefaults().setValue(user.email, forKey: "userID")
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func logout() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("userID")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func changePassword(oldPassword: String, newPassword: String) -> Bool {
        guard let userID = NSUserDefaults.standardUserDefaults().stringForKey("userID") else {
            return false
        }
        self.logout()
        let listUser = dataStored.fetchRecordsForEntity("User", inManagedObjectContext: managedObjectContext)
        for users in listUser {
            if let user = users as? User {
                if userID == user.email {
                    if user.password == oldPassword {
                        user.password = newPassword
                        do {
                            try managedObjectContext.save()
                            NSUserDefaults.standardUserDefaults().setValue(userID, forKey: "userID")
                            return true
                        } catch {
                            return false
                        }
                    } else {
                        return false
                    }
                }
            }
        }
        return false
    }
}
