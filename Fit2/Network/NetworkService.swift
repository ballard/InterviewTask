//
//  NetworkService.swift
//  FitolioApp
//
//  Created by ISLAZAREV on 05.04.2022.
//

import Foundation


final class NetworkService {
    
    private let baseURL = "https://jsonplaceholder.typicode.com"
    private let session = URLSession(configuration: .default)
    private let queue = DispatchQueue(label: "NetworkService.queue", attributes: .concurrent)
    
    func getData(
        _ completion: @escaping (
            [UserDto]?,
            [TodoDto]?
        ) -> Void) {
        
        var users: [UserDto]? = nil
        var todos: [TodoDto]? = nil
        
        let group = DispatchGroup()
        
        group.enter()
        queue.async { [weak self] in
            self?.getUsers { usersData in
                users = usersData
                group.leave()
            }
        }
        group.enter()
        queue.async { [weak self] in
            self?.getTodos { todosData in
                todos = todosData
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion(users, todos)
        }
    }
    
    
    private func getUsers(_ completion: @escaping (([UserDto]?) -> Void)) {
        
        let requestPath = "\(baseURL)/users"
        
        guard let url = URL(string: requestPath) else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let users = try JSONDecoder().decode([UserDto].self, from: data)
                completion(users)
            } catch {
                completion(nil)
                print(error)
            }
        }
        
        task.resume()
    }
    
    private func getTodos(_ completion: @escaping (([TodoDto]?) -> Void)) {
        
        let requestPath = "\(baseURL)/todos"
        
        guard let url = URL(string: requestPath) else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let todos = try JSONDecoder().decode([TodoDto].self, from: data)
                completion(todos)
            } catch {
                completion(nil)
                print(error)
            }
        }
        
        task.resume()
    }
    
}
