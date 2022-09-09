//
//  Memo.swift
//  ToDo
//
//  Created by 山尾かな on 2022/09/08.
//

import Foundation
import RealmSwift

class Memo: Object{
    @objc dynamic var title = ""
    @objc dynamic var content: String = ""
    @objc dynamic var date: String = ""
}
