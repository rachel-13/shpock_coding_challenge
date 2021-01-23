//
//  UIView+Extensions.swift
//  Shpock Pirate Ships
//
//  Created by pohyee on 23/01/2021.
//  Copyright © 2021 pohyee. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  func withAutoLayout() -> Self {
    translatesAutoresizingMaskIntoConstraints = false
    return self
  }
}
