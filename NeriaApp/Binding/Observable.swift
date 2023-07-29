//
//  Observable.swift
//  NeriaApp
//
//  Created by Neria Jerafi on 27/07/2023.
//

import Foundation

class Observable<T> {
    typealias Listener = (T)->()
    
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    deinit {
        listener = nil
    }

    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        bind(listener)
        listener?(value)
    }
}
