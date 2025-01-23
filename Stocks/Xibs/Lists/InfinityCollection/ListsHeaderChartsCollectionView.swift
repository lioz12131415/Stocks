//
//  ListsHeaderChartsCollectionView.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import YFinance
import Foundation

class ListsHeaderChartsCollectionView: UIView {
        
    @IBOutlet weak var collectionView: UIInfinityCollectionView!
    
    fileprivate var charts: [Chart] = [] {
        didSet { }
    }
    
    fileprivate lazy var animationQueue = {
        return DualAnimationQueue()
    }()
    
    fileprivate lazy var cache: OrderedCharts = {
        return finance.cache.charts[range: .d1, granularity: .m2]
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.register(nibName: "ListsHeaderChartCell")
        self.collectionView.infinityDelegate   = self
        self.collectionView.infinityDataSource = self
        
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
        self.collectionView.reloadData()
        self.finance.spark(charts).onReceive { [weak self] newValues in
            self?.charts = newValues
            self?.collectionView.reloadData()
        }
        .stop()
        .run(receive: .on(.main), loop: .every(20), cache: [.save, .update])
    }
    
    internal static func loadFromNib() -> ListsHeaderChartsCollectionView {
        let view = UINib(nibName: "ListsHeaderChartsCollectionView", bundle: nil)
        return view.instantiate(withOwner: nil, options: nil)[0] as! ListsHeaderChartsCollectionView
    }
}

extension ListsHeaderChartsCollectionView {
    internal func hide(duration: CGFloat = 0.3) {
        let animation = FadeOutAnimation(view: self, duration: duration).didStop { [weak self] in
            self?.collectionView.movement.stop()
            self?.superview?.sendToBack(self)
        }
        animationQueue.add(animation)
    }
}

extension ListsHeaderChartsCollectionView {
    internal func show(duration: CGFloat = 0.3) {
        let animation = FadeInAnimation(view: self, duration: duration).willStart { [weak self] in
            self?.alpha = 0.0
            self?.superview?.bringToFront(self)
        }.didStop { [weak self] in
            self?.collectionView.movement.start()
        }
        animationQueue.add(animation)
    }
}

extension ListsHeaderChartsCollectionView: UIInfinityCollectionViewDelegate, UIInfinityCollectionViewDataSource {
    func collectionView(_ collectionView: UIInfinityCollectionView, numberOfItemsInSection section: Int) -> Int {
        return charts.count
    }
    
    func collectionView(_ collectionView: UIInfinityCollectionView, prepareCellAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListsHeaderChartCell", for: indexPath) as! ListsHeaderChartCell
        
        cell.chart = charts[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UIInfinityCollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let s = charts[indexPath.row].symbol
        let p = charts[indexPath.row].marketPrice.fmt
        let c = charts[indexPath.row].marketChange.sgn
        let m = max(s.width(.bold(14.0)), p.width(.semibold(14.0)), c.width(.semibold(14.0)))
        
        return .init(width: m+84.0/*99.0*/, height: collectionView.frame.height) /*184*/ // TODO
    }
}
