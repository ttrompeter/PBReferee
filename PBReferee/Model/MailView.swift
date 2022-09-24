//
//  MailView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/10/22.
//

import SwiftUI
import UIKit
import MessageUI

public typealias MailViewCallback = ((Result<MFMailComposeResult, Error>) -> Void)?

public struct MailView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentation
    @Binding var data: ComposeMailData
    let callback: MailViewCallback

    public init(data: Binding<ComposeMailData>,
                callback: MailViewCallback) {
        _data = data
        self.callback = callback
    }

    public class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var presentation: PresentationMode
        @Binding var data: ComposeMailData
        let callback: MailViewCallback

        public init(presentation: Binding<PresentationMode>,
             data: Binding<ComposeMailData>,
             callback: MailViewCallback) {
            _presentation = presentation
            _data = data
            self.callback = callback
        }

        public func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            if let error = error {
                callback?(.failure(error))
            } else {
                callback?(.success(result))
            }
            $presentation.wrappedValue.dismiss()
        }
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(presentation: presentation, data: $data, callback: callback)
    }

    public func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setSubject(data.subject)
        vc.setToRecipients(data.recipients)
        vc.setMessageBody(data.message, isHTML: false)
        
        // TRT Changes to only use single attachement and specific for snapshot of score sheet
        let imageUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("scoresheet.png")
        let matchUIImage = UIImage(contentsOfFile: imageUrl.path)!
        let matchData = matchUIImage.pngData()!
        vc.addAttachmentData(matchData, mimeType: "image/png", fileName: "FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].match.png")
        // End TRT Changes
        
        data.attachments?.forEach {
            vc.addAttachmentData($0.data, mimeType: $0.mimeType, fileName: $0.fileName)
        }
        vc.accessibilityElementDidLoseFocus()
        return vc
    }

    public func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                                context: UIViewControllerRepresentableContext<MailView>) {
    }

    public static var canSendMail: Bool {
        MFMailComposeViewController.canSendMail()
    }
}

public struct ComposeMailData {
    public let subject: String
    public let recipients: [String]?
    public let message: String
    public let attachments: [AttachmentData]?
    
    public init(subject: String,
                recipients: [String]?,
                message: String,
                attachments: [AttachmentData]?) {
        self.subject = subject
        self.recipients = recipients
        self.message = message
        self.attachments = attachments
    }
    
    public static let empty = ComposeMailData(subject: "", recipients: nil, message: "", attachments: nil)
}

public struct AttachmentData {
    public let data: Data
    public let mimeType: String
    public let fileName: String
    
    public init(data: Data,
                mimeType: String,
                fileName: String) {
        self.data = data
        self.mimeType = mimeType
        self.fileName = fileName
    }
}


// This is the code for the view that composes and sends the email. This copy is here for referenc3
//struct MailViewTest: View {
//   @State private var mailData = ComposeMailData(subject: "A subject",
//                                                 recipients: ["i.love@swiftuirecipes.com"],
//                                                 message: "Here's a message",
//                                                 attachments: [AttachmentData(data: "Some text".data(using: .utf8)!,
//                                                                              mimeType: "text/plain",
//                                                                              fileName: "text.txt")
//                                                 ])
//   @State private var showMailView = false
//
//    var body: some View {
//        Button(action: {
//            showMailView.toggle()
//        }) {
//            Text("Send mail")
//        }
//        .disabled(!MailView.canSendMail)
//        .sheet(isPresented: $showMailView) {
//            MailView(data: $mailData) { result in
//                print(result)
//            }
//        }
//    }
//}





//==============================================================================================
// To attach an image to email
//let imageData: NSData = UIImagePNGRepresentation(imageView.image)!
//mail.addAttachmentData(imageData, mimeType: "image/png", fileName: "imageName.png")
// Image(uiImage: UIImage(named: "cat")!)

// 2018 Answer
//func sendMail(imageView: UIImageView) {
//    if MFMailComposeViewController.canSendMail() {
//      let mail = MFMailComposeViewController()
//      mail.mailComposeDelegate = self;
//      mail.setCcRecipients(["yyyy@xxx.com"])
//      mail.setSubject("Your messagge")
//      mail.setMessageBody("Message body", isHTML: false)
//      let imageData: NSData = UIImagePNGRepresentation(imageView.image)!
//      mail.addAttachmentData(imageData, mimeType: "image/png", fileName: "imageName.png")
//      self.presentViewController(mail, animated: true, completion: nil)
//    }
//  }


//let imageData = UIImagePNGRepresentation(image)!
//let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//let imageURL = docDir.appendingPathComponent("tmp.png")
//try! imageData.write(to: imageURL)
//
//let newImage = UIImage(contentsOfFile: imageURL.path)!

