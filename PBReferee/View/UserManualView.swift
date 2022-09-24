//
//  UserManualView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/28/22.
//

import PDFKit
import SwiftUI

struct UserManualView: View {
    
    @Environment(\.dismiss) var dismiss
    let pdfDoc: PDFDocument
    
    init() {
        pdfDoc = PDFDocument(url: Bundle.main.url(forResource: "user_manual", withExtension: "pdf")!)!
    }
    
    var body: some View {
        VStack {
            PDFKitView(showing: pdfDoc)
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: "xmark")
            }
        }
        
        
//        VStack {
//            Button("Close") {
//                dismiss()
//            }
//            .buttonStyle(SheetButtonStyle())
//        }
//        .padding(.bottom)
        
    }
}

//struct UserManualView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserManualView()
//    }
//}

