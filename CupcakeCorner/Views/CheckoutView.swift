//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Chris Eadie on 13/07/2020.
//

import SwiftUI

struct CheckoutView: View {
  @ObservedObject var order: Order
  @State private var confirmationMessage = ""
  @State private var showingConfirmation = false
  
  
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
            print("Order placed.")
            placeOrder()
            
          }
          .padding()
        }
      }
    }
    .alert(isPresented: $showingConfirmation) {
      Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
    }
  }
  
  func placeOrder() {
    
    guard let encodedOrder = try? JSONEncoder().encode(order) else {
      print("Failed to encode order")
      return
    }
    
    let url = URL(string: "https://reqres.in/api/cupcakes")!
    var request = URLRequest(url: url)
    request.setValue("applicaation/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.httpBody = encodedOrder
    
    URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        print("No data in response \(error?.localizedDescription ?? "Unknown error")")
        return
      }
      
      if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
        self.confirmationMessage = "Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
        self.showingConfirmation = true
      } else {
        print("Invalid response from server")
      }
    }.resume()
  }
}

struct CheckoutView_Previews: PreviewProvider {
  static var previews: some View {
    CheckoutView(order: Order())
  }
}
