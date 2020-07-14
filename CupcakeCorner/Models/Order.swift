//
//  Order.swift
//  CupcakeCorner
//
//  Created by Chris Eadie on 13/07/2020.
//

import Foundation

class Order: ObservableObject {
  @Published var details = OrderDetails()
}

struct OrderDetails: Codable {
  
  // MARK: Cupcake types
  
  static let types = [
    "Vanilla",
    "Strawberry",
    "Chocolate"
  ]
  
  
  // MARK: Order details
  
   var type = 0
   var quantity = 3
  
  
  // MARK: Special request details
  
   var specialRequestEnabled = false {
    didSet {
      if specialRequestEnabled == false {
        extraFrosting = false
        addSprinkles = false
      }
    }
  }
   var extraFrosting = false
   var addSprinkles = false
  
  
  // MARK: Address details
  
   var name = ""
   var streetAddress = ""
   var city = ""
   var postcode = ""
  
  
  // MARK: Computed Variables
  
  var addressNotValid: Bool {
    name.isEmpty
      || streetAddress.isEmpty || streetAddress.replacingOccurrences(of: " ", with: "").isEmpty
      || city.isEmpty || city.replacingOccurrences(of: " ", with: "").isEmpty
      || postcode.isEmpty || postcode.replacingOccurrences(of: " ", with: "").isEmpty
  }
  
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
