//
//  LookupsVC.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import YFinance
import Foundation

class LookupsVC: UISearchBarViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var quotes: [Quote] = [] {
        didSet { /* */ }
    }

    fileprivate lazy var noDataView: LookupsNoDataView = {
        return .loadNib()
    }()
    
    override func viewDidLoad(_ scrollView: UIScrollView?) {
        super.viewDidLoad(tableView)
        self.noDataView.bind(to: view)
        self.tableView.delegate   = self
        self.tableView.dataSource = self
    }

    internal func lookup(for query: String) {
        guard !query.isEmpty else {
            return clear()
        }
        self.stop()
        self.noDataView.hide()
        self.request(with: query)
        self.tableView?.scrollToTop()
    }
    
    fileprivate func stop() {
        self.finance.quote.get(.quotes).stop()
        self.finance.lookup.get(.lookups).stop()
    }
    
    fileprivate func clear() {
        self.stop()
        self.quotes.removeAll()
        self.tableView?.reloadData()
    }
    
    fileprivate func noData(_ query: String) {
        self.clear()
        self.noDataView.show(query)
    }
    
    fileprivate func request(with query: String) {
        finance.lookup.lookups(for: query) { [weak self] symbols in
            self?.request(query, with: symbols)
        }
        .stop()
        .start(receive: .on(.task), after: .schedule(0.3))
    }
    
    fileprivate func request(_ query: String, with lookups: [Lookup]) {
        finance.quote.quotes(for: lookups.symbols) { [weak self] symbols in
            self?.update(query, symbols)
        }
        .stop()
        .start(receive: .on(.main), loop: .every(20))
    }
    
    fileprivate func update(_ query: String, _ quotes: [Quote]) {
        guard !quotes.isEmpty else {
            return noData(query)
        }
        self.quotes = quotes
        self.noDataView.hide()
        self.tableView.reloadData()
    }
    
    internal static func instance() -> LookupsVC {
        let storyboard = UIStoryboard(name: "Lookups", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LookupsVC") as! LookupsVC
        return controller
    }
}

extension LookupsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LookupCell", for: indexPath) as! LookupCell
        cell.quote = quotes[indexPath.row]
        return cell
    }
}

