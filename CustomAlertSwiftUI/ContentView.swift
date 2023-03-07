//
//  ContentView.swift
//  CustomAlertSwiftUI
//
//  Created by Dennis Programmer on 7/3/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isAlertShown = true

    var body: some View {
        VStack {
            Button {
                isAlertShown.toggle()
            } label: {
                Text("Stow alert")
            }
        }
        .modifier(AlertViewModifier(isAlertPresenter: $isAlertShown))
    }
}


struct AlertViewModifier: ViewModifier {
    @Binding var isAlertPresenter: Bool
//    @Binding var confirmAction: () -> Void
//    @Binding var dismissAction: () -> Void


    func body(content: Content) -> some View {
        if isAlertPresenter {
            return AnyView(content)
        } else {
            return AnyView(
            ZStack(alignment: .center) {
                AlertView(
                    confirmAction: .constant({}),
                    dismissAction: .constant({})
                )
            }
            )
        }
    }
}

struct AlertView: View {
    @Binding var confirmAction: () -> Void
    @Binding var dismissAction: () -> Void

    var body: some View {
        createStackOfButtons()
    }

    private func createStackOfButtons() -> some View {
        HStack(alignment: .center, spacing: 10) {
            createConfirmButton()
            createDismissButton()
        }
    }

    private func createConfirmButton() -> some View {
        Button {
            confirmAction()
        } label: {
            Text("Oтправить")
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
        }
    }

    private func createDismissButton() -> some View {
        Button {
            dismissAction()
        } label: {
            Text("Oтменить")
                .foregroundColor(.gray)
                .padding()
                .background(Color.white)
                .border(.black)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
