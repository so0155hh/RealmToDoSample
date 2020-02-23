//
//  TopMenuTableViewController.swift
//  
//
//  Created by 桑原望 on 2020/02/22.
//

import UIKit
import RealmSwift

var toDos: Results<ToDo>?
var realm = try! Realm()

class TopMenuTableViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDos = realm.objects(ToDo.self)
        
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    //Cellをクリックした時にToDo登録画面へ遷移する処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let realm = try! Realm()
        let toDos = realm.objects(ToDo.self)
        if segue.identifier == "CellClick" {
            let destination = segue.destination as! InsertViewController
            //選択状態のcellを取得
            let todo = toDos[tableView.indexPathForSelectedRow!.row]
            //実行
            destination.incomingTodo = todo
            
            
        }
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let realm = try! Realm()
        let toDos = realm.objects(ToDo.self)
        return toDos.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as! toDoCell
        let realm = try! Realm()
        let toDos = realm.objects(ToDo.self)
        let todo = toDos[indexPath.row]
        //labelに登録したToDoを表示
        cell.toDoText.text = todo.toDoText
        cell.isDoneText.text = todo.isDone ? "It is done." : "Do it."
        
        return cell
    }
    //ToDoのdelete処理
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let realm = try! Realm()
            let toDos = realm.objects(ToDo.self)
            let todo = toDos[indexPath.row]
            try! realm.write {
                realm.delete(todo)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

class ToDo: Object {
    @objc dynamic var toDoText = ""
    @objc dynamic var isDone = false
}
class toDoCell: UITableViewCell {
    @IBOutlet weak var toDoText: UILabel!
    @IBOutlet weak var isDoneText: UILabel!
    
}

