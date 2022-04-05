//
//  Presenter.swift
//  Fit2
//
//  Created by ISLAZAREV on 05.04.2022.
//

import Foundation

final class Presenter {
    
    private let service = NetworkService()
    private let adapter: Adapter
    
    init(adapter: Adapter) {
        self.adapter = adapter
    }
    
    func loadData() {
        service.getData { [weak self] users, todos  in
            guard let users = users, let todos = todos else { return }
            self?.adapter.updateData(users: users, todos: todos)
        }
    }
}
