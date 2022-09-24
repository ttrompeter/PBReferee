//
//  PDFKitView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/7/22.
//

import SwiftUI
import PDFKit

struct PDFKitView: UIViewRepresentable {
    
    let pdfDocument: PDFDocument
    
    init(showing pdfDoc: PDFDocument) {
        self.pdfDocument = pdfDoc
    }
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ pdfView: PDFView, context: Context) {
        pdfView.document = pdfDocument
    }
}

//struct PDFKitView_Previews: PreviewProvider {
//    static var previews: some View {
//        PDFKitView()
//    }
//}

