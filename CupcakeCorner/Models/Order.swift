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
  
  var addressNotValid: Bool {
    name.isEmpty || streetAddress.isEmpty || city.isEmpty || postcode.isEmpty
  }
  
  // MARK: Price details
  var cost: Double {
    // £ per cupcake
    let cupcakeCost = Double(quantity * 2)
    
    // type increases price
    let typeCost = (Double(type) / 2)
    
    // £1/cupcake for extra frosting
    var extraFrostingCost: Double {
      if extraFrosting {
        return Double(quantity)
      } else {
        return 0.0
      }
    }
    
    // £0.50/cupcake for extra sprinkles
    var extraSprinklesCost: Double {
      if addSprinkles {
        return (Double(quantity) / 2)
      } else {
        return 0.0
      }
    }
    
    return cupcakeCost + typeCost + extraFrostingCost + extraSprinklesCost
  }
  
}
