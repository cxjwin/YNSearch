//
//  YNSearchListView.swift
//  YNSearch
//
//  Created by YiSeungyoun on 2017. 4. 16..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import UIKit

open class YNSearchListView: UITableView, UITableViewDelegate, UITableViewDataSource {
    private var database = [YNSearchModel]()
    private var searchResultDatabase = [YNSearchModel]()
    
    open var ynSearchListViewDelegate: YNSearchListViewDelegate?
    open var ynSearch = YNSearch()
    open var ynSearchTextFieldText: String? {
        didSet {
            guard let text = ynSearchTextFieldText else { return }

            let objectification = Objectification(objects: database, type: .all)
            guard let result = objectification.objects(contain: text) as? [YNSearchModel] else { return }

            self.searchResultDatabase = result
            if text.isEmpty {
                self.initData(database: database)
            }
            self.reloadData()
        }
    }

    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.initView()
    }
    
    open func initData(database: [YNSearchModel]) {
        self.database = database
        self.searchResultDatabase = database
        self.reloadData()

    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YNSearchListViewCell.ID) as! YNSearchListViewCell
        cell.searchLabel.text = searchResultDatabase[indexPath.row].key
        
        return cell
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultDatabase.count
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let key = searchResultDatabase[indexPath.row].key {
            self.ynSearchListViewDelegate?.ynSearchListViewClicked(key: key)
            self.ynSearchListViewDelegate?.ynSearchListViewClicked(object: database[indexPath.row])
            self.ynSearch.appendSearchHistories(value: key)
        }
    }
    
    
    open func initView() {
        self.delegate = self
        self.dataSource = self
        self.register(YNSearchListViewCell.self, forCellReuseIdentifier: YNSearchListViewCell.ID)
    }
}