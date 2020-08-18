//
//  todo.swift
//  todo
//
//  Created by Kaushik Talluri on 12/08/20.
//  Copyright © 2020 tckr. All rights reserved.
//

import Foundation


struct Todos: Codable {
    let items: Array<Todo>
}
struct Todo: Codable {
    let item: String
    let priority: Int
}
