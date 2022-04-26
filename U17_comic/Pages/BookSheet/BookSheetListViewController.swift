//
//  BookSheetListViewController.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/25.
//

import UIKit

class BookSheetListViewController: BaseViewController {

    var dataSource:[String] = []
    
    var type: Int = 0
    init(type: Int) {
        super.init(nibName: nil, bundle: nil)
        self.type = type
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .random()
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        if type == 2 {
            self.dataSource = [""]
        } else {
            self.dataSource = ["","","","",""]
        }
    }
}

extension BookSheetListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookSheetViewCell", for: indexPath) as! BookSheetViewCell
        return cell
    }
}
