//
//  toDOViewController.swift
//  ToDo
//
//  Created by 山尾かな on 2022/09/07.
//

import UIKit
import RealmSwift
import SwiftUI

class toDOViewController: UIViewController, UITextFieldDelegate,UITextViewDelegate{

    let realm = try! Realm()
    @IBOutlet weak var textField: UITextField!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextView: UITextView!
        var datePicker = UIDatePicker()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            titleTextField.delegate = self
            contentTextView.delegate = self
            textField.delegate = self
            let memo: Memo? = read()
            titleTextField.text = memo?.title
            contentTextView.text = memo?.content
            textField.text = memo?.date
            let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
            let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
            toolbar.setItems([spacelItem, doneItem], animated: true)
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy年 M月d日"
            datePicker.date = formatter.date(from: "2000年 1月1日")!
            datePicker.datePickerMode = .date
            datePicker.preferredDatePickerStyle = .wheels
            textField.inputView = datePicker
            textField.inputAccessoryView = toolbar
        }
        
        @objc func done() {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy年 M月d日"
            textField.text = formatter.string(from: datePicker.date)
            self.view.endEditing(true)
        }
    func read() -> Memo? {
        return realm.objects(Memo.self).first
    }
    @IBAction func save(){
        let realm = try! Realm()
        let todo = Memo()
        todo.title = titleTextField.text!
        try! realm.write{
            realm.add(todo)
        }
        self.navigationController?.popViewController(animated: true)
        let title: String = titleTextField.text!
        let content: String = contentTextView.text!
        let date: String = textField.text!
        let memo: Memo? = read()
        
        if memo != nil{
            try! realm.write{
                memo!.title = title
                memo!.content = content
                memo!.date = date
            }
        }else {
            let newMemo = Memo()
            newMemo.title = title
            newMemo.content = content
            newMemo.date = date
            try! realm.write{
                realm.add(newMemo)
            }
        }
        let alert: UIAlertController = UIAlertController(title: "成功", message: "保存しました", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true,completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
    }
}
