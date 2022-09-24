//
//  LargeScoresheetImageView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/19/22.
//

import SwiftUI

struct EnlargedImageView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var scoresheetManager: ScoresheetManager
    @EnvironmentObject var sheetManager: SheetManager
    @State private var imageToUse = UIImage()
    //@State private var isUseScoresheetImage = true
    
    var body: some View {
        
        VStack (spacing: 30) {
            
            Image(uiImage: imageToUse)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 650.0, height: 550.0, alignment: .center)
                .border(Color.gray, width: 3.0)
                .clipped()
          
            VStack {
                Button("Close") {
                    dismiss()
                }
                .buttonStyle(SheetButtonStyle())
            }
            
        }  // Top VStack
        .onAppear {
            if scoresheetManager.isShowScoresheetImage {
                $imageToUse.wrappedValue = getStoredImage(imageName: "scoresheet.png")
            } else {
                $imageToUse.wrappedValue = getStoredImage(imageName: "statistics.png")
            }
        }
    }
}

//struct LargeScoresheetImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        EnlargedImageView()
//    }
//}

