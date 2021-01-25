//
//  Observable.swift
//  Shpock Pirate Ships
//
//  Created by pohyee on 25/01/2021.
//  Copyright © 2021 pohyee. All rights reserved.
//

import Foundation

class Observable<T> {
  typealias Listener = (T) -> Void
  var listener: Listener?
  
  func bind(_ listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
  
  var value: T {
    didSet {
      listener?(value)
    }
  }
  
  init(_ v: T) {
    value = v
  }
}
