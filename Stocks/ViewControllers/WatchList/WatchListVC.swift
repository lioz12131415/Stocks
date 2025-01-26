//
//  WatchListVC.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import YFinance
import Foundation

class WatchListVC: UISearchBarViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var charts: [Chart] = [] {
        didSet { }
    }
    
    fileprivate lazy var cache: OrderedCharts = {
        return finance.cache.charts[range: .d1, granularity: .m2]
    }()
    
    fileprivate lazy var noDataView: WatchListNoDataView = {
        return .loadNib()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad(tableView)
        self.tableView.delegate            = self
        self.tableView.dataSource          = self
        self.tableView.contentInset.bottom = 52+90
        self.noDataView.bind(to: view, show: false)
                
        self.finance.cache.load(.charts) { [weak self] in
            self?.observe()
            self?.update()
        }
    }
    
    fileprivate func observe() {
        cache.observe(self)
            .onChange { [weak self] in self?.update() }
            .onRemove { [weak self] in self?.update() }
    }
    
    fileprivate func update() {
        self.charts = cache.values
        self.tableView.reloadData()
        self.charts.isEmpty ? noDataView.show() : noDataView.hide()
        self.finance.spark(charts).onReceive { [weak self] newValues in
            self?.charts = newValues
            self?.tableView.reloadData()
        }
        .stop()
        .run(receive: .on(.main), loop: .every(20), cache: [.save, .update])
    }
    
    internal static func instance() -> WatchListVC {
        let storyboard = UIStoryboard(name: "WatchList", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "WatchListVC") as! WatchListVC
        return controller
    }
}

extension WatchListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchCell", for: indexPath) as! WatchCell
        cell.chart = charts[indexPath.row]
        return cell
    }
}
