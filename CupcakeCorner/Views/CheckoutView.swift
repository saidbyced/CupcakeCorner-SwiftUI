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
              print("Order placed.")
            }
            .padding()
          }
        }
      }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
      CheckoutView(order: Order())
    }
}
