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
        TextField("Name", text: $order.details.name)
        TextField("Street address", text: $order.details.streetAddress)
        TextField("City", text: $order.details.city)
        TextField("Postcode", text: $order.details.postcode)
      }
      Section {
        NavigationLink(destination: CheckoutView(order: order)) {
          Text("Checkout")
        }
      }.disabled(order.details.addressNotValid)
    }
    .navigationBarTitle("Delivery details", displayMode: .inline)
  }
}

struct AddressView_Previews: PreviewProvider {
  static var previews: some View {
    AddressView(order: Order())
  }
}
