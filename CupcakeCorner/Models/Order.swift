//
//  Order.swift
//  CupcakeCorner
//
//  Created by Chris Eadie on 13/07/2020.
//

import Foundation

class Order: ObservableObject{
  static let types = [
    "Vanilla",
    "Strawberry",
    "Chocolate"
  ]
  
  @Published var type = 0
  @Published var quantity = 3
  
  @Published var specialRequestEnabled = false
  @Published var extraFrosting = false
  @Published var addSprinkles = false
}
