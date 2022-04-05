//
//  Adapter.swift
//  Fit2
//
//  Created by ISLAZAREV on 05.04.2022.
//

import UIKit

final class Adapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    private var users: [UserDto] = [UserDto]()
    private var todos: [TodoDto] = [TodoDto]()
    private let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func updateData(users: [UserDto], todos: [TodoDto]) {
        self.users = users
        self.todos = todos
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersCell", for: indexPath)
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        var text = users[indexPath.row].name
        let id = users[indexPath.row].id
        if let todo = todos.first(where: { todo in
            todo.userId == id
        })?.title {
            text.append(" - \(todo)")
        }
        cell.textLabel?.text = text
        return cell
    }
}

