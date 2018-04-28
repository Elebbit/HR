//
//  DepartmentListVC.swift
//  HR
//
//  Created by 최연택 on 2018. 4. 27..
//  Copyright © 2018년 최연택. All rights reserved.
//

import UIKit
import RealmSwift

class DepartmentListVC: UITableViewController {
    
    let realm = try! Realm()
    
    var departments : Results<Department>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDepart()
        initUI()

    }
    
    //MARK - Data Delegate Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return departments?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DEPART_CELL", for: indexPath)
        if let departCell = departments?[indexPath.row] {
            cell.textLabel?.text = departCell.title
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            
            cell.detailTextLabel?.text = departCell.address
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        }
        return cell
    }
    
    func initUI() {
        // 내비게이션 타이틀용 레이블 속성 설정
        let navTitle = UILabel(frame: CGRect(x: 0, y:0 , width: 200, height: 60))
        navTitle.numberOfLines = 2
        navTitle.textAlignment = .center
        navTitle.font = UIFont.systemFont(ofSize: 14)
        navTitle.text = "부서 목록 \n" + "총 \(departments!.count)개"
        
        
        // 내비게이션 바 UI
        navigationItem.titleView = navTitle
        navigationItem.leftBarButtonItem = editButtonItem
        
        // 셀을 스와이프 했을 때 편집모드가 되도록
        
        tableView.allowsSelectionDuringEditing = true
        
        
    }
    
    func saveDepart(department: Department) {
        
        
        do {
            try realm.write {
                 realm.add(department)
            }
        } catch {
            print("Save Department Failed, \(error) ")
        }
    }
    
    func updateDepart() {
        departments = realm.objects(Department.self)
        
        tableView.reloadData()
        
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "부서추가", message: "추가 할 부서정보를 입력해주세요.", preferredStyle: .alert)
        alert.addTextField { (topTextField) in
            topTextField.placeholder = "부서명"
        }
        
        alert.addTextField { (bottomTextField) in
            bottomTextField.placeholder = "부서 위치"
        }
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "추가", style: .destructive)
        { (action) in
            let title = alert.textFields?[0].text
            let adress = alert.textFields?[1].text
            let newDepart = Department()
            newDepart.title = title ?? ""
            newDepart.address = adress ?? ""
            self.saveDepart(department: newDepart)
            self.tableView.reloadData()
            self.initUI()
        })
        
        present(alert, animated: true, completion: nil)
    }
    

}
