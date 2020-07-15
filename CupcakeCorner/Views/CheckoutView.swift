//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Chris Eadie on 13/07/2020.
//

import SwiftUI

struct CheckoutView: View {
  @ObservedObject var order: Order
  @State private var confirmationTitle = ""
  @State private var confirmationMessage = ""
  @State private var confirmationButton = ""
  @State private var showingConfirmation = false
  
  
  var body: some View {
    GeometryReader { geometry in
      ScrollView {
        VStack {
          Image("cupcakes")
            .resizable()
            .scaledToFit()
            .frame(width: geometry.size.width)
          Text("Your total is £\(self.order.details.cost, specifier: "%.2f")")
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
      Alert(title: Text(confirmationTitle), message: Text(confirmationMessage), dismissButton: .default(Text(confirmationButton)))
    }
  }
  
  func placeOrder() {
    
    guard let encodedOrder = try? JSONEncoder().encode(order.details) else {
      print("Failed to encode order")
      return
    }
    
    let url = URL(string: "https://reqres.in/api/cupcakes")!
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.httpBody = encodedOrder
    
    URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        print("No data in response \(error?.localizedDescription ?? "Unknown error")")
        return
      }
      
      if let decodedOrder = try? JSONDecoder().decode(OrderDetails.self, from: data) {
        self.confirmationTitle = "Thank you!"
        self.confirmationMessage = "Your order for \(decodedOrder.quantity) x \(OrderDetails.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
        self.confirmationButton = "🙂"
        self.showingConfirmation = true
      } else {
        self.confirmationTitle = "Uh oh!"
        self.confirmationMessage = "We tried to process your order\nbut it didn't work.\nPlease try again later."
        self.confirmationButton = "😔"
        self.showingConfirmation = true
      }
    }.resume()
  }
}

struct CheckoutView_Previews: PreviewProvider {
  static var previews: some View {
    CheckoutView(order: Order())
  }
}
