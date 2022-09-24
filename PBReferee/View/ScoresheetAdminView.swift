//
//  ScreenshotAdminView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/8/22.
//

import MessageUI
import RealmSwift
import ScreenshotSwiftUI
import SwiftUI
import UIKit

struct ScoresheetAdminView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedRealmObject var match: Match
    
    // // TODO: - Fix recipients for email instead of hardcoded value
    @State private var mailData = ComposeMailData(subject: "Pickleball Match Report",
                                                  recipients: ["ttrompeter@zoho.com"],
                                                  message: "Match report sent from Pickleball Referee. Completed score sheet is attached.",
                                                  attachments:  [])  // Empty array of attachments until this is working for matc hsnapshot image
    
    // imageView: UIImageView
    // let imageData: NSData = UIImagePNGRepresentation(imageView.image)!
    // mail.addAttachmentData(imageData, mimeType: "image/png", fileName: "imageName.png")
    //      addAttachmentData($0.data, mimeType: $0.mimeType, fileName: $0.fileName)
    //[AttachmentData(data: UIImagePNGRepresentation(imageView.image)!,
    //mimeType: "image/png",
    //fileName: "FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].match.png")]
    
    @State private var showMailView = false
    @State private var showPrintView = false
    @State private var imageToUse = UIImage()
    @State private var presentEnlargedImage = false
    
    var body: some View {
        
        VStack {
            
            HStack {
                Text("Scoresheet Screenshot")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Constants.DARK_SLATE)
            }
            .padding(.vertical, 10)
            
            
            VStack (alignment: .leading) {
                
                ZStack {
                    Rectangle()
                        .frame(width: CGFloat(640), height: CGFloat(570))
                        .foregroundColor(Constants.CLOUDS)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    
                    VStack {
                        
                        Image(uiImage: imageToUse)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 550.0, height: 430.0, alignment: .center)
                            .border(Color.gray, width: 3.0)
                            .clipped()
                        
                        Button {
                            presentEnlargedImage = true
                        } label: {
                            Text("Show Enlarged Image")
                                .padding(10)
                                .font(.headline)
                                .foregroundColor(Constants.MINT_LEAF)
                        }
                        .padding()
                        .sheet(isPresented: $presentEnlargedImage) { EnlargedImageView() }
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                showPrintView = true
                                
                            }) {
                                Image("printer")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .clipped()
                            }
                            .sheet(isPresented: $showPrintView) {
                                ActivityViewController(activityItems: [imageToUse])
                            }
                            Text("Print")
                            Spacer()
                            Button(action: {
                                //$mailData.recipients[0] = [match.emailAddressForScoresheetSnaphot]
                                showMailView = true
                            }) {
                                Image("envelope")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .clipped()
                            }
                            .disabled(!MailView.canSendMail)
                            .sheet(isPresented: $showMailView) {
                                MailView(data: $mailData) { result in
                                    print(result)
                                }
                            }
                            Text("Email")
                            Spacer()
                        }
                    }
                    .frame(width: 550, height: 500)
                }  // End ZStack
                .padding(.leading, 20)
                
                
                
            }
            
            Spacer()
            HStack (spacing: 40) {
                Button("Close") {
                    dismiss()
                }
                .buttonStyle(SheetButtonStyle())
            }
            .padding(.bottom, 20)
        }   // End Top VStack
        .onAppear {
            $imageToUse.wrappedValue = getStoredImage(imageName: "scoresheet.png")
        }
    }
    
}
struct ScreenshotAdminView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresheetAdminView(match: Match())
    }
}




