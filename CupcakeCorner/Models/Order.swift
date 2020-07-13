//
//  Order.swift
//  CupcakeCorner
//
//  Created by Chris Eadie on 13/07/2020.
//

import Foundation

class Order: ObservableObject {
  
  // MARK: Cupcake types
  static let types = [
    "Vanilla",
    "Strawberry",
    "Chocolate"
  ]
  
  // MARK: Order details
  @Published var type = 0
  @Published var quantity = 3
  
  // MARK: Special request details
  @Published var specialRequestEnabled = false {
    didSet {
      if specialRequestEnabled == false {
        extraFrosting = false
        addSprinkles = false
      }
    }
  }
  @Published var extraFrosting = false
  @Published var addSprinkles = false
  
  // MARK: Address details
  @Published var name = ""
  @Published var streetAddress = ""
  @Published var city = ""
  @Published var postcode = ""
  
}
