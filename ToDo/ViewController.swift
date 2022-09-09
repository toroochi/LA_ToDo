//
//  ViewController.swift
//  ToDo
//
//  Created by 山尾かな on 2022/09/06.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource{

    var toDoItems: Results<Memo>!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        let realm = try! Realm()
        toDoItems = realm.objects(Memo.self)
        table.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    func tableView(_ tableView:UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        let object = toDoItems[indexPath.row]
        cell.textLabel?.text = object.title
        return cell
    }
    func tableView(_ tableView:UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            deleteTodo(at:indexPath.row)
            table.reloadData()
        }
    }
    func deleteTodo(at index :Int){
        let realm = try! Realm()
        try! realm.write{
            realm.delete(toDoItems[index])
        }
    }
}

