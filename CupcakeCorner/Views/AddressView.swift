//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Chris Eadie on 13/07/2020.
//

import SwiftUI

struct AddressView: View {
  @ObservedObject var order: Order
  
  var body: some View {
    Form {
      Section {
        TextField("Name", text: $order.name)
        TextField("Street address", text: $order.streetAddress)
        TextField("City", text: $order.city)
        TextField("Postcode", text: $order.postcode)
      }
      Section {
        NavigationLink(destination: CheckoutView(order: order)) {
          Text("Checkout")
        }
      }
    }
    .navigationBarTitle("Delivery details", displayMode: .inline)
  }
}

struct AddressView_Previews: PreviewProvider {
  static var previews: some View {
    AddressView(order: Order())
  }
}
