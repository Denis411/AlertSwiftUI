//
//  ContentView.swift
//  CustomAlertSwiftUI
//
//  Created by Dennis Programmer on 7/3/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isAlertShown = false

    var body: some View {
        VStack {
            Button {
                isAlertShown.toggle()
            } label: {
                Text("Stow alert")
            }
        }
        .modifier(AlertViewModifier(
            isAlertPresenter: $isAlertShown,
            confirmAction: print("Confirmed"),
            dismissAction: isAlertShown.toggle())
        )
    }
}


struct AlertViewModifier: ViewModifier {
    @Binding private var isAlertPresenter: Bool
    private var confirmAction: () -> Void
    private var dismissAction: () -> Void

    init(
        isAlertPresenter: Binding<Bool>,
        confirmAction: @escaping @autoclosure () -> Void,
        dismissAction: @escaping @autoclosure () -> Void
    ) {
        self._isAlertPresenter = isAlertPresenter
        self.confirmAction = confirmAction
        self.dismissAction = dismissAction
    }

    func body(content: Content) -> some View {
        if isAlertPresenter {
            return AnyView(content)
        } else {
            return AnyView(
            ZStack(alignment: .center) {
                content
                    .blur(radius: 0.5)
                AlertView(
                    confirmAction: confirmAction(),
                    dismissAction: dismissAction()
                )
                .padding(.leading, 20)
                .padding(.trailing, 20)
            }
            )
        }
    }
}

struct AlertView: View {
    private var confirmAction: () -> Void
    private var dismissAction: () -> Void

    init(
        confirmAction: @escaping @autoclosure() -> Void,
        dismissAction: @escaping @autoclosure() -> Void
    ) {
        self.confirmAction = confirmAction
        self.dismissAction = dismissAction
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Вы ввели очень большие показания приборов учета, все равно отправить?")
                .bold()
                .padding(.leading, 45)
                .padding(.trailing, 45)
                .padding(.top, 50)
                .padding(.bottom, 20)
            createStackOfButtons()
                .padding(.bottom, 30)
        }
        .background(Color.white)
        .border(Color.gray)
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
                .font(.system(size: 15))
                .foregroundColor(.white)
                .padding(.leading, 25)
                .padding(.trailing, 25)
                .padding(.top, 10)
                .padding(.bottom, 10)
                .background(Color.blue)
        }
    }

    private func createDismissButton() -> some View {
        Button {
            dismissAction()
        } label: {
            Text("Oтменить")
                .font(.system(size: 15))
                .foregroundColor(.gray)
                .padding(.leading, 25)
                .padding(.trailing, 25)
                .padding(.top, 10)
                .padding(.bottom, 10)
                .background(Color.white)
                .border(.black)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
