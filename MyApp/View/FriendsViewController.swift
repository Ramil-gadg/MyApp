//
//  FriendsViewController.swift
//  MyApp
//
//  Created by Рамил Гаджиев on 17.09.2021.
//

import UIKit


class FriendsViewController: UITableViewController{
    
    
    var currentUser: MUser
    var friends: [Friend] = []
    let cellID = "cell"
    
    init(currentUser: MUser) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
        title = currentUser.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var button: UIBarButtonItem {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFriend))
        button.tintColor = .red
        return button
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FireStoreManager.shared.getFriends(user: currentUser) { friends, error in
            guard let friends = friends else { return }
            self.friends = friends
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: cellID)
        navigationItem.rightBarButtonItem = button
        
        view.backgroundColor = UIColor.mainBackground()
    }
    
    @objc func addFriend() {
        let alert = UIAlertController.showAlertWithTextField(title: "Добавить друга", message: "Оба поля обязательны для заполнения") { action, name, lastName in
            FireStoreManager.shared.saveFriend(user: self.currentUser, name: name, lastName: lastName) { friend, error in
                guard let friend = friend else {
                    let alert = UIAlertController.showAlert(title: "Error", message: error!.localizedDescription)
                    self.present(alert, animated: true)
                    return
                }
                self.friends.append(friend)
                let indexPath = IndexPath(row: self.friends.count - 1, section: 0)
                self.tableView.insertRows(at: [indexPath], with: .fade)
            }
        }
        present(alert, animated: true, completion: nil)
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! FriendsTableViewCell
        cell.fullName.text = friends[indexPath.row].fullName
        if UserDefaults.standard.bool(forKey: (friends[indexPath.row].fullName)) {
            cell.bestFriendLabel.image = UIImage(systemName: "hand.thumbsup.fill")
            cell.bestFriendLabel.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        } else {
            cell.bestFriendLabel.image = UIImage(systemName: "hand.thumbsup")
            cell.bestFriendLabel.tintColor = .text()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let friend = friends[indexPath.row]
            FireStoreManager.shared.deleteFriend(user: currentUser, friend: friend)
            friends.remove(at: indexPath.row)
            UserDefaults.standard.removeObject(forKey: friend.fullName)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = friends[indexPath.row]
        let vc = InfoAboutFriendViewController(currentFriend: friend)
        vc.title = friend.fullName
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


