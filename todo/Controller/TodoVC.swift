//
//  ViewController.swift
//  todo
//
//  Created by Kaushik Talluri on 12/08/20.
//  Copyright © 2020 tckr. All rights reserved.
//

import UIKit

class TodoVC: UIViewController {
    
    
    @IBOutlet weak var todoItemTxt: UITextField!
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    @IBOutlet weak var todoTable: UITableView!
    
    var todos = Array<Todo>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTable.delegate = self
        todoTable.dataSource = self
        
        getTodods()
        
        
    }
    
    func  getTodods() {
        
        NetworkService.shared.getTodo(onSuccess: { (todos) in
            self.todos = todos.items
            self.todoTable.reloadData()
        }) { (errorMessage) in
            //showalert to user
            debugPrint(errorMessage)
        }
    }
    
    @IBAction func addTodo(_ sender: Any) {
        guard let todoItem = todoItemTxt.text else{
            //show error
            return
        }
        let todo = Todo(item: todoItem, priority: prioritySegment.selectedSegmentIndex)
        NetworkService.shared.addTodo(todo: todo, onSuccess: { (todos) in
            self.todoItemTxt.text = ""
            self.prioritySegment.selectedSegmentIndex = 0
            self.todos = todos.items
            self.todoTable.reloadData()
        }) { (errorMessage) in
            debugPrint(errorMessage)
        }
        
    }
    
    
}

extension TodoVC: UITableViewDelegate, UITableViewDataSource{
   func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as? TodoCell {
            cell.updateCell(todo: todos[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
}
