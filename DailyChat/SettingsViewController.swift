//
//  SettingsViewController.swift
//  DailyChat
//
//  Created by Mikhail Lyapich on 12/6/17.
//  Copyright © 2017 Gleb Kulik. All rights reserved.
//

import UIKit
import Firebase

/*
    Settings data from Profile
 */

struct Person {
    var lastName: String
    var name: String
    var group: String
}

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    private var person: Person?
    private var profileRef: DatabaseReference = Database.database().reference().child("settings").child("profile")
    private var profileHandle: DatabaseHandle?
    
    override func viewDidLoad() {
        
        observeData()
        
        super.viewDidLoad()
    }
    
    func observeData() {
        let userID = AuthProvider.Instance.userID()
        profileHandle = profileRef.child(userID).observe(DataEventType.value, with: { (snapshot) in
            let data = snapshot.value as? [String : AnyObject] ?? [:]
            let group = (data["groupID"] as? String) ?? ""
            let name = (data["name"] as? String) ?? ""
            let lastName = (data["lastName"] as? String) ?? ""
            self.nameLabel.text = "\(name) \(lastName)"
            self.groupLabel.text = "Group \(group)"
            self.profileImage.image = UIImage(named: "DL_Background")
            self.person = Person(lastName: lastName, name: name, group: group)
        })
    }
}
