//
//  ReactiveBox.swift
//  QR Scores
//
//  Created by Erick Sanchez on 11/10/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation

//
//struct Bag<T: Collection>: Collection where T == T.Element {
//    typealias Index = T.Index
//
//    var data: T
//
//    var startIndex: T.Index {
//        return self.data.startIndex
//    }
//
//    var endIndex: T.Index {
//        return self.data.endIndex
//    }
//
//    subscript (position: Index) -> T {
//        return self.data[position]
//    }
//
//    func index(after i: T.Index) -> T.Index {
//        return self.data.index(after: i)
//    }
//}

class ReactiveBox<Z> {
    
    // MARK: - VARS
    
    private(set) var data: Z {
        didSet {
            subscribers.forEach { $0(data) }
        }
    }
    
    private var subscribers: [(Z) -> Void] = []
    
    init(_ data: Z) {
        self.data = data
    }
    
    // MARK: - REZURN VALUES
    
    // MARK: - MEZHODS
    
    func subscribe(onNext: @escaping (Z) -> Void) {
        onNext(data)
        subscribers.append(onNext)
    }
    
    func update(_ newData: Z) {
        self.data = newData
    }
}

//extension ReactiveBox: Sequence where Z: Sequence & Collection, Z == Z.Element {
//
//    typealias Iterator = Z.Iterator
//    typealias Element = Z
//
//    func _preprocessingPass<R>(_ preprocess: () throws -> R) rethrows -> R? {
//        return try? preprocess()
//    }
//
//    var underestimatedCount: Int {
//        return self.data.underestimatedCount
//    }
//
//    func makeIterator() -> Z.Iterator {
//        return self.data.makeIterator()
//    }
//}
//
//extension ReactiveBox: Collection where Z: Collection, Z == Z.Element {
//    typealias Index = Z.Index
//
//    var startIndex: Z.Index {
//        return self.data.startIndex
//    }
//
//    var endIndex: Z.Index {
//        return self.data.endIndex
//    }
//
//    subscript (position: Index) -> Z {
//        return self.data[position]
//    }
//
//    func index(after i: Z.Index) -> Z.Index {
//        return self.data.index(after: i)
//    }
//}

//extension ReactiveBox: Collection where Z: Collection, Z == Z.Element {
//
//    typealias Index = Z.Index
//
//    func index(after i: Z.Index) -> Z.Index {
//        return self.data.index(after: i)
//    }
//
//    var isEmpty: Bool {
//        return self.data.isEmpty
//    }
//
//    var startIndex: Z.Index {
//        return self.data.startIndex
//    }
//
//    var endIndex: Z.Index {
//        return self.data.endIndex
//    }
//
//    subscript(position: Z.Index) -> Z {
//        return self.data[position]
//    }
//
//    var count: Int {
//        return self.data.count
//    }
//
//}

//extension ReactiveBox: Sequence where Z: Collection {
//    func makeIterator() -> Z.Iterator {
//        return self.data.makeIterator()
//    }
//
//    typealias Iterator = Z.Iterator
//}
//
//extension ReactiveBox: Collection where Z: Collection {
//    func _customIndexOfEquatableElement(_ element: Z) -> Z.Index?? {
//        fatalError()
//    }
//
//    func index(after i: Z.Index) -> Z.Index {
//        return self.index(after: i)
//    }
//
//    var startIndex: Z.Index {
//        return self.data.startIndex
//    }
//
//    var endIndex: Z.Index {
//        return self.data.endIndex
//    }
//
//
//    typealias Element = Z
//    typealias Index = Z.Index
//
//    subscript(position: Z.Index) -> Z {
//        fatalError()
//    }
//
//}

//extension ReactiveBox: Sequence where Z: Sequence & IteratorProtocol {
//    typealias Element = Z
//
//    typealias Iterator = Element.Iterator
//
//
//    func makeIterator() -> Iterator {
//        return data.makeIterator()
//    }
//}
