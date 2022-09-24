//
//  RulesView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/20/22.
//

import SwiftUI
import PDFKit

struct RulesView: View {
    
    @Environment(\.dismiss) var dismiss
    let pdfDoc: PDFDocument
    
    init() {
        //let url = Bundle.main.url(forResource: "PickleballRulebook2022", withExtension: "pdf")!
        //pdfDoc = PDFDocument(url: url)!
        pdfDoc = PDFDocument(url: Bundle.main.url(forResource: "PickleballRulebook2022", withExtension: "pdf")!)!
    }
    
    var body: some View {
        VStack {
            PDFKitView(showing: pdfDoc)
        }
        .padding()
        VStack {
            Button("Close") {
                dismiss()
            }
            .buttonStyle(SheetButtonStyle())
        }
        .padding(.bottom)
    }
}

//struct PDFUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        PDFUIView()
//    }
//}

