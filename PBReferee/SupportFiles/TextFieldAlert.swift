//
//  TextFieldAlert.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 9/5/22.
//

import SwiftUI

struct TextFieldAlert: View {

    let screenSize = UIScreen.main.bounds
    
    @Binding var isShown: Bool
    @Binding var alertText: String
    @FocusState private var textFieldAlertInFocus: textFieldAlertFocusable?
    var title = ""
    var message = ""
    var onDone: (String) -> Void = {_ in }
    //var onCancel: () -> Void = { } // Does not do anything
    
    enum textFieldAlertFocusable: Hashable {
        case inputField
    }
    
    var body: some View {
        
        VStack (spacing: 10) {
            Text(title)
                .font(.headline)
            Text(message)
                .font(.callout)
                .fixedSize(horizontal: false, vertical: true)
            TextField("", text: $alertText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(Constants.MINT_LEAF)
                .focused($textFieldAlertInFocus, equals: .inputField)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                        self.textFieldAlertInFocus = .inputField
                    }
                }
                .onSubmit {
                    isShown = false
                    onDone(alertText)
                }
            HStack {
                Button("Save") {
                    isShown = false
                    onDone(alertText)
                }
                Text("             ")
                Button("Cancel") {
                    isShown = false
                    //onCancel()
                }
            }
            .padding(.horizontal, 20)
        }
        .padding()
        .frame(width: screenSize.width * 0.3, height: screenSize.height * 0.3)
        .background(Constants.MINT_LEAF)
        .foregroundColor(Constants.WHITE)
        .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
        .offset(y: isShown ? 0 : screenSize.height) //if not shown, then move off screen
        .animation(.spring(), value: isShown)
        //.shadow(color: Constants.DARK_SLATE, radius: 3, x: -5, y: -5)
        .buttonStyle(InitialsButtonStyle())
    }
}

struct TextFieldAlert_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldAlert(isShown: .constant(true), alertText: .constant(""))
    }
}

