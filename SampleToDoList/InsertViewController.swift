//
//  InsertViewController.swift
//  SampleToDoList
//
//  Created by 桑原望 on 2020/02/22.
//  Copyright © 2020 MySwift. All rights reserved.
//

import UIKit
import RealmSwift

class InsertViewController: UIViewController {
    
    var incomingTodo: ToDo? = nil
    let realm = try! Realm()
    
    @IBOutlet weak var toDoTextField: UITextField!
    @IBOutlet weak var toDoSwitch: UISwitch!
    
    @IBAction func saveBtn(_ sender: Any) {
        //登録されたToDoを変更した際に反映
        if let goodToDo = incomingTodo {
            try! realm.write {
                goodToDo.isDone = toDoSwitch.isOn
                goodToDo.toDoText = toDoTextField.text!
            }
        } else {
            //新規登録のToDoをTopMenuに反映
            let todo = ToDo()
            todo.toDoText = toDoTextField.text!
            todo.isDone = toDoSwitch.isOn

            try! realm.write {
                realm.add(todo)
            }
        }
        //1つ前の画面に戻る
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let goodToDo = incomingTodo {
            toDoTextField.text = goodToDo.toDoText
            toDoSwitch.isOn = goodToDo.isDone
        }
    }
    
}
