//
//  ViolationReference.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/21/22.
//

import SwiftUI

struct ViolationReferenceView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var sheetManager: SheetManager
    
    var body: some View {
        
        VStack (spacing: 30) {
            
            HStack {
                Text("Violation Reference")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Constants.DARK_SLATE)
                Image("violation")
                    .resizable()
                    .frame(width: 80, height: 60)
                    .clipped()
            }
            
            ZStack {
                Rectangle()
                    .frame(width: CGFloat(660), height: CGFloat(410))
                    .foregroundColor(Constants.CLOUDS)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                VStack (alignment: .leading) {
    
                    Text("Violation Reference Information Goes Here")
                            .font(.headline)
                    Text("Violation Reference For You")
                       
                }
                
            }
          
            VStack {
                Button("Close") {
                    dismiss()
                }
                .buttonStyle(SheetButtonStyle())
            }
            
        }  // Top VStack
    }
}

struct ViolationReferenceView_Previews: PreviewProvider {
    static var previews: some View {
        ViolationReferenceView()
    }
}

