//
//  ParseChatViewController.swift
//  ParseChat
//
//  Created by Elizabeth on 2/25/18.
//  Copyright © 2018 Elizabeth. All rights reserved.
//

import UIKit
import Parse

class ParseChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var chatMessageField: UITextField!
    @IBOutlet weak var chatTableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var messages : [PFObject] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ParseChatViewController.didPullToRefresh(_:)), for: .valueChanged)
        chatTableView.insertSubview(refreshControl, at: 0)
        
        chatTableView.dataSource = self
        chatTableView.delegate = self
        
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.retrieveData), userInfo: nil, repeats: true)
        chatTableView.rowHeight = UITableViewAutomaticDimension
        chatTableView.estimatedRowHeight = 50
        
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        retrieveData()
    }


    @IBAction func onSendBtn(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        
        chatMessage["text"] = chatMessageField.text ?? ""
        chatMessage["user"] = PFUser.current()
        chatMessage.saveInBackground { (succes, error) in
            if succes {
                self.chatMessageField.text = ""
                print("The message was saved!")
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    @objc func retrieveData() {
        let query = PFQuery(className: "Message")
        query.includeKey("user")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                if let objects = objects {
                    self.messages = objects
                }
            } else {
                print(error?.localizedDescription ?? "Error")
            }
        }
        //Reload your table view data
        self.chatTableView.reloadData()
        //Stop activityIndicator
        self.activityIndicator.stopAnimating()
        //Stop Refreshing
        self.refreshControl.endRefreshing()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let message = messages[indexPath.row] as PFObject
        cell.chatMessageField.text = message["text"] as? String
        if let user = message["user"] as? PFUser {
            cell.userNameLable.text = user.username
        } else {
            cell.userNameLable.text = "🤖"
        }
        return cell
    }
        
        
    @IBAction func onLogout(_ sender: Any) {
        print("Tapped logout button")
        //log the user out
        PFUser.logOutInBackground { (error: Error?) in
            if error == nil {
                print("Successful logout")
                self.performSegue(withIdentifier: "logoutSegue", sender: nil)
            } else {
                print("Error Logging Out!")
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
