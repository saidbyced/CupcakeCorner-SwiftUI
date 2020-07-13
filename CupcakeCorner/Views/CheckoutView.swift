//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Chris Eadie on 13/07/2020.
//

import SwiftUI

struct CheckoutView: View {
  @ObservedObject var order: Order
  
  var body: some View {
    GeometryReader { geometry in
      ScrollView {
        VStack {
          Image("cupcakes")
            .resizable()
            .scaledToFit()
            .frame(width: geometry.size.width)
          Text("Your total is £\(self.order.cost, specifier: "%.2f")")
            .font(.title)
          Button("Place order") {
            placeOrder()
            print("Order placed.")
          }
          .padding()
        }
      }
    }
  }
  
  func placeOrder() {
    
    guard let encodedOrder = try? JSONEncoder().encode(order) else {
      print("Failed to encode order")
      return
    }
    
    let url = URL(string: "https://reques.in/api/cupcakes")!
    var request = URLRequest(url: url)
    request.setValue("applicaation/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.httpBody = encodedOrder
    
    URLSession.shared.dataTask(with: request) { data, response, error in
      // handle the shizzle
    }.resume()
  }
}

struct CheckoutView_Previews: PreviewProvider {
  static var previews: some View {
    CheckoutView(order: Order())
  }
}
