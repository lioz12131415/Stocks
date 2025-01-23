//
//  NSOrderedMap.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Structures
import Foundation

class Ordered<Key: Hashable, Value>: NSObject, Codable, ExpressibleByDictionaryLiteral where Key: Codable, Value: Codable {
     
    fileprivate var _oldValue:   Int           = .zero
    fileprivate var _newValue:   Int           = .zero
    fileprivate var _observers:  Observers     = Observers()
    fileprivate var _dispatcher: DispatchQueue = DispatchQueue(label: "\(UUID().uuidString)")
    
    fileprivate var __elements = OrderedMap<Key, Value>() {
        didSet { set(new: __elements.count) }
    }
    
    fileprivate var _elements: OrderedMap<Key, Value> {
        get { __elements }
        set { _dispatcher.sync { __elements = newValue } }
    }

    internal var count: Int {
        return _elements.count
    }

    internal var last: Value? {
        return _elements.last
    }

    internal var first: Value? {
        return _elements.first
    }

    internal var keys: [Key] {
        return _elements.keys
    }

    internal var values: [Value] {
        return _elements.values
    }

    internal var items: [(key: Key, value: Value)] {
        return _elements.items
    }
    
    internal override var description: String {
        return _elements.description
    }

    internal override var debugDescription: String {
        return _elements.debugDescription
    }

    internal override init() {
        super.init()
    }

    internal required init(dictionaryLiteral elements: (Key, Value)...) {
        super.init()
        elements.forEach { self[$0.0] = $0.1 }
        self._oldValue = count
        self._newValue = count
    }

    internal required init(from decoder: Decoder) throws {
        super.init()
        let container  = try decoder.container(keyedBy: CodingKeys.self)
        self._elements = try container.decode(OrderedMap<Key, Value>.self, forKey: ._elements)
        self._oldValue = count
        self._newValue = count
    }

    internal func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_elements, forKey: ._elements)
    }

    internal subscript(key: Key) -> Value? {
        get { _elements[key] }
        set { _elements[key] = newValue }
    }

    internal subscript(index: Int) -> Value? {
        get { _elements[index] }
        set { _elements[index] = newValue }
    }

    internal subscript(key: Key, default d: Value) -> Value {
        get { _elements[key, default: d] }
    }
        
    internal func removeAll() {
        self._elements.removeAll()
    }

    internal func contains(_ key: Key) -> Bool {
        return _elements.contains(key)
    }

    internal func push(_ value: Value, for key: Key) {
        self._elements.push(value, for: key)
    }

    internal func update(_ value: Value, for key: Key) {
        self._elements.update(value, for: key)
    }

    internal func append(_ value: Value, for key: Key) {
        self._elements.update(value, for: key)
    }
    
    internal func observe(_ observer: NSObject) -> any OrderedObserve {
       return _observers.update(observe(for: observer))
    }

    @discardableResult
    internal func remove(for key: Key) -> Value? {
        self._elements.remove(for: key)
    }

    @discardableResult
    internal func remove(at index: Int) -> Value? {
        self._elements.remove(at: index)
    }

    @discardableResult
    internal func insert(_ value: Value, for key: Key, at index: Int) -> Value? {
        self._elements.insert(value, for: key, at: index)
    }

    public enum Event {
        case saved
        case changed
        case removed
        case updated
    }
    
    enum CodingKeys: CodingKey {
        case _elements
    }
}

extension Ordered: Sequence {
    internal func makeIterator() -> OrderedMap<Key, Value>.Iterator {
        return _elements.makeIterator()
    }
}

extension Ordered {
    fileprivate func set(new count: Int) {
        self._oldValue = _newValue
        self._newValue = count
        self.notify()
    }
}

extension Ordered {
    internal func notify(_ event: Event) {
        switch event {
            case .saved:   _observers.saved()
            case .changed: _observers.changed()
            case .removed: _observers.removed()
            case .updated: _observers.updated()
        }
    }
    
    internal func notify() {
        if _newValue == .zero && _oldValue == .zero {
            return
        }
        switch (_newValue, _oldValue) {
            case let c where c.0 > c.1: notify(.changed)
            case let c where c.0 < c.1: notify(.removed)
        default:
            notify(.updated)
        }
    }
}
