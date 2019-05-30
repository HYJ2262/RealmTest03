//
//  ViewController.swift
//  RealmTest03
//
//  Created by D7703_24 on 2019. 5. 30..
//  Copyright © 2019년 D7703_24. All rights reserved.
//

import UIKit
import RealmSwift

//DB 모델링
class Person: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
}


class ViewController: UIViewController {
    @IBOutlet weak var lblName: UITextField!
    @IBOutlet weak var lblAge: UITextField!
    
    //객체 배열 Results <- realm에서 받아오는 DB객체
    var personArray : Results<Person>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try!Realm()
        personArray = realm.objects(Person.self)
        
        
    }
    
    //DB에 객체저장
    @IBAction func ObjAdd(_ sender: Any) {
        //새로운 객체를 만듦(저장위해)
        let newPerson = Person()
//        newPerson.name = "홍길동"
//        newPerson.age = 28
        newPerson.name = lblName.text!
        newPerson.age = Int(lblAge.text!)!
        
        //객체를 저장
        //realm 객체를 하나 만듦
        let realm = try!Realm()
        //DB에 저장, 삭제 일어나게 할 수 있음(DB트랜잭션같은거)
        try! realm.write {
            realm.add(newPerson)
        }
        
        lblName.text = ""
        lblAge.text = ""
        
        print("추가가 완료되었습니다.")
        personArray = realm.objects(Person.self)
        print(personArray!)
        
        
    }
    
    @IBAction func ObjGet(_ sender: Any) {
        
        let realm = try!Realm()
        
        //personArray와 동기화하기
        print("로딩 완료")
        personArray = realm.objects(Person.self)
        print(personArray!.count)
        print(personArray!)
        
        
    }
    
    @IBAction func ObjDel(_ sender: Any) {
        let realm = try!Realm()
        try! realm.write {
            realm.deleteAll()
        }
        
        print("삭제가 완료되었습니다.")
        personArray = realm.objects(Person.self)
        print(personArray!)
    }
}

