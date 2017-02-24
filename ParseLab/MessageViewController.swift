//
//  ChatViewController.swift
//  ParseLab
//
//  Created by Gates Zeng on 2/23/17.
//  Copyright © 2017 Gates Zeng. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendClicked(_ sender: AnyObject) {
        var newMessage = PFObject(className:"Message")
        newMessage["text"] = messageField.text
        newMessage["user"] = PFUser.current()
        newMessage.saveInBackground(block: {
            (success: Bool, error: Error?) -> Void in
            if (success) {
                print(self.messageField.text)
                self.messageField.text = ""
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let messages = messages {
            return messages.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.gates.MessageCell", for: indexPath) as! MessageCell
        let currMessage = messages?[indexPath.row].object(forKey: "text") as! String
        let user = messages?[indexPath.row].object(forKey: "user") as? PFUser
        let userText = user?.username
        if let userText = userText {
            cell.userLabel.text = userText as! String
        } else {
            cell.userLabel.text = ""
        }
        cell.messageLabel.text = currMessage
        return cell
    }

    func onTimer() {
        var query = PFQuery(className:"Message")
        query.order(byDescending: "createdAt")
        query.includeKey("user")
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        print(object.objectId)
                    }
                    self.messages = objects
                    self.tableView.reloadData()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \((error as! NSError).userInfo)")
            }
        }    }
}
