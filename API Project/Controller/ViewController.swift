//
//  ViewController.swift
//  API Project
//
//  Created by Mag isb-10 on 14/03/2024.
// https://jsonplaceholder.typicode.com/posts

import UIKit

class ViewController: UIViewController {
  
  var postsData = [PostsModel]()
  var usersData = [UsersModel]()
  var commentsData = [CommentsModel]()
  
  @IBOutlet weak var postsTableView: UITableView!
  @IBOutlet weak var usersTableView: UITableView!
  @IBOutlet weak var commentsTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    postsTableView.delegate = self
    postsTableView.dataSource = self
    postsTableView.register(UINib(nibName: "PostCell", bundle: .main), forCellReuseIdentifier: "PostCell")
    
    usersTableView.delegate = self
    usersTableView.dataSource = self
    usersTableView.register(UINib(nibName: "UserCell", bundle: .main), forCellReuseIdentifier: "UserCell")
    
    commentsTableView.delegate = self
    commentsTableView.dataSource = self
    commentsTableView.register(UINib(nibName: "CommentCell", bundle: .main), forCellReuseIdentifier: "CommentCell")
    
    getPostsData()
    getUsersData()
    getCommentsData()
  }
  
  func getPostsData() {
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
      do{
        if error == nil {
          self.postsData = try JSONDecoder().decode([PostsModel].self, from: data!)
          
          for item in self.postsData {
            print(item.id, ":", item.title)
            DispatchQueue.main.async {
              self.postsTableView.reloadData()
            }
          }
        }
      } catch{
        print("Error in json data")
      }
    }.resume()
  }
  
  func getUsersData() {
    let url = URL(string: "https://jsonplaceholder.typicode.com/users")
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
      do{
        if error == nil {
          self.usersData = try JSONDecoder().decode([UsersModel].self, from: data!)
          
          for item in self.usersData {
            DispatchQueue.main.async {
              self.usersTableView.reloadData()
            }
          }
        }
      } catch{
        print("Error in json data")
      }
    }.resume()
  }
  
  func getCommentsData() {
    let url = URL(string: "https://jsonplaceholder.typicode.com/comments")
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
      do{
        if error == nil {
          self.commentsData = try JSONDecoder().decode([CommentsModel].self, from: data!)
          
          for item in self.usersData {
            DispatchQueue.main.async {
              self.commentsTableView.reloadData()
            }
          }
        }
      } catch{
        print("Error in json data")
      }
    }.resume()
  }
  
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if tableView == self.postsTableView {
      return postsData.count
    } else if tableView == self.usersTableView {
      return usersData.count
    } else if tableView == self.commentsTableView {
      return commentsData.count
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = UITableViewCell()
    
    if tableView == self.postsTableView{
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell else { return UITableViewCell()
      }
      cell.userIDlbl.text = "UserID: \(postsData[indexPath.row].userID)"
      cell.idLbl.text = "id: \(postsData[indexPath.row].id)"
      cell.titleLbl.text = "Title: \(postsData[indexPath.row].title)"
      cell.bodyLbl.text = "Body: \(postsData[indexPath.row].body)"
      return cell
    }
    else if tableView == self.usersTableView {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell else { return UITableViewCell()
      }
      cell.idLabel.text = "id: \(usersData[indexPath.row].id)"
      cell.nameLabel.text = "name: \(usersData[indexPath.row].name)"
      cell.usernameLabel.text = "username: \(usersData[indexPath.row].username)"
      cell.emailLabel.text = "email: \(usersData[indexPath.row].email)"
      cell.phoneLabel.text = "phone: \(usersData[indexPath.row].phone)"
      return cell
    }
    else if tableView == self.commentsTableView {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as? CommentCell else { return UITableViewCell()
      }
      cell.postIDLabel.text = "id: \(commentsData[indexPath.row].postID)"
      cell.idLabel.text = "name: \(commentsData[indexPath.row].id)"
      cell.nameLabel.text = "username: \(commentsData[indexPath.row].name)"
      cell.emailLabel.text = "email: \(commentsData[indexPath.row].email)"
      cell.bodyLabel.text = "phone: \(commentsData[indexPath.row].body)"
      return cell
    }
    return cell
  }
}
