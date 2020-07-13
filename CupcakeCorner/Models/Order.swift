//
//  Order.swift
//  CupcakeCorner
//
//  Created by Chris Eadie on 13/07/2020.
//

import Foundation

class Order: ObservableObject, Codable {
  
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
  
  // MARK: Initializers
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    type = try container.decode(Int.self, forKey: .type)
    quantity = try container.decode(Int.self, forKey: .quantity)
    
    extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
    addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
    
    name = try container.decode(String.self, forKey: .name)
    streetAddress = try container.decode(String.self, forKey: .streetAddress)
    city = try container.decode(String.self, forKey: .city)
    postcode = try container.decode(String.self, forKey: .postcode)
  }
  
  init() {}
  
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
  
  enum CodingKeys: CodingKey {
    case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, postcode
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(type, forKey: .type)
    try container.encode(quantity, forKey: .quantity)
    
    try container.encode(extraFrosting, forKey: .extraFrosting)
    try container.encode(addSprinkles, forKey: .addSprinkles)
    
    try container.encode(name, forKey: .name)
    try container.encode(streetAddress, forKey: .streetAddress)
    try container.encode(city, forKey: .city)
    try container.encode(postcode, forKey: .postcode)
  }
  
}
