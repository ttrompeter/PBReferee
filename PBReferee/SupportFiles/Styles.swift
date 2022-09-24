//
//  Styles.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 7/28/22.
//

//
//  Styles.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 7/11/22.
//

import SwiftUI


struct CoinTossButtonStyle: ButtonStyle {
    private struct ContentView<Content: View>: View {
        @Environment(\.isEnabled) private var isEnabled
        var view: Content
        var body: some View {
            view
                .padding()
                .frame(width: 140, height: 40)
                .background(Color(.mintleaf))
                .foregroundColor(isEnabled ? Color(.slate) : .white)
                .font(.callout)
                .clipShape(Capsule())
                .opacity(isEnabled ? 1.0 : 0.6)
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        ContentView(view: configuration.label)
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct EndMatchButtonStyle: ButtonStyle {
    private struct ContentView<Content: View>: View {
        @Environment(\.isEnabled) private var isEnabled
        var view: Content
        var body: some View {
            view
                .padding()
                .frame(width: 140, height: 40)
                .background(Color(.pomegranate))
                .foregroundColor(isEnabled ? .white : Color(.lightGray))
                .font(.callout)
                .clipShape(Capsule())
                .opacity(isEnabled ? 1.0 : 0.6)
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        ContentView(view: configuration.label)
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct FunctionsButtonStyle: ButtonStyle {
    private struct ContentView<Content: View>: View {
        @Environment(\.isEnabled) private var isEnabled
        var view: Content
        var body: some View {
            view
                .padding()
                .frame(width: 140, height: 40)
                .background(Color(.silver))
                .foregroundColor(Color(.slate))
                .font(.callout)
                .clipShape(Capsule())
                .opacity(isEnabled ? 1.0 : 0.5)
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        ContentView(view: configuration.label)
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct FunctionsButtonStyleGreen: ButtonStyle {
    private struct ContentView<Content: View>: View {
        @Environment(\.isEnabled) private var isEnabled
        var view: Content
        var body: some View {
            view
                .padding()
                .frame(width: 140, height: 40)
                .background(Color(.mintleaf))
                .foregroundColor(isEnabled ? .white : Color(.slate))
                .font(.callout)
                .clipShape(Capsule())
                .opacity(isEnabled ? 1.0 : 0.6)
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        ContentView(view: configuration.label)
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

//struct FunctionsButtonStyleMandatory: ButtonStyle {
//    private struct ContentView<Content: View>: View {
//        @Environment(\.isEnabled) private var isEnabled
//        var view: Content
//        var body: some View {
//            view
//                .padding()
//                .frame(width: 140, height: 40)
//                .background(Constants.MINT_LEAF)
//                .foregroundColor(Constants.WHITE)
//                .font(.callout)
//                .clipShape(Capsule())
//                .opacity(isEnabled ? 1.0 : 0.5)
//        }
//    }
//
//    func makeBody(configuration: Configuration) -> some View {
//        ContentView(view: configuration.label)
//            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
//            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
//    }
//}

struct InitialsButtonStyle: ButtonStyle {
    private struct ContentView<Content: View>: View {
        @Environment(\.isEnabled) private var isEnabled
        var view: Content
        var body: some View {
            view
                .padding()
                .frame(width: 100, height: 30)
                .background(Color(.silver))
                .foregroundColor(Color(.slate))
                .font(.callout)
                .clipShape(Capsule())
                .opacity(isEnabled ? 1.0 : 0.5)
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        ContentView(view: configuration.label)
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct MatchSetupButtonStyle: ButtonStyle {
    
    private struct ContentView<Content: View>: View {
        @Environment(\.isEnabled) private var isEnabled
        var view: Content
        var body: some View {
            view
                .padding()
                .frame(width: 140, height: 40)
                .background(Color(.pomegranate))
                .foregroundColor(.white)
                .font(.callout)
                .clipShape(Capsule())
                .opacity(isEnabled ? 1.0 : 0.5)
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        ContentView(view: configuration.label)
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct MediumButtonStyle: ButtonStyle {
    private struct ContentView<Content: View>: View {
        @Environment(\.isEnabled) private var isEnabled
        var view: Content
        var body: some View {
            view
                .padding()
                .frame(width: 100, height: 40)
                .background(Color(.silver))
                .foregroundColor(isEnabled ? Color(.slate) : .white)
                .font(.title)
                .clipShape(Capsule())
                .opacity(isEnabled ? 1.0 : 0.6)
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        ContentView(view: configuration.label)
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct PointsSideoutButtonStyle: ButtonStyle {
    private struct ContentView<Content: View>: View {
        @Environment(\.isEnabled) private var isEnabled
        var view: Content
        var body: some View {
            view
                .padding()
                .frame(width: 170, height: 50)
            //.background(isEnabled ? Constants.MINT_LEAF : Constants.SILVER)
                .background(Color(.mintleaf))
                .foregroundColor(isEnabled ? .white : Color(.grayslate))
                .font(.title)
                .clipShape(Capsule())
                .opacity(isEnabled ? 1.0 : 0.6)
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        ContentView(view: configuration.label)
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct SetupWarningButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 150, height: 70)
            .background(Color(.yarrow))
            .font(.body)
            .foregroundColor(Color(.slate))
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .shadow(radius: 5)
        //.cornerRadius(10)
    }
}

struct SheetButtonStyle: ButtonStyle {
    private struct ContentView<Content: View>: View {
        @Environment(\.isEnabled) private var isEnabled
        var view: Content
        var body: some View {
            view
                .padding()
                .frame(width: 120, height: 30)
                .background(Color(.silver))
                .foregroundColor(isEnabled ? Color(.slate) : .white)
                .font(.callout)
                .clipShape(Capsule())
                .opacity(isEnabled ? 1.0 : 0.6)
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        ContentView(view: configuration.label)
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct TimeoutsButtonStyle: ButtonStyle {
    private struct ContentView<Content: View>: View {
        @Environment(\.isEnabled) private var isEnabled
        var view: Content
        var body: some View {
            view
                .padding()
                .frame(width: 180, height: 40)
            //.background(isEnabled ? Constants.MINT_LEAF : Constants.SILVER)
                .background(Color(.mintleaf))
                .foregroundColor(isEnabled ? Color(.slate) : .white)
                .font(.callout)
                .clipShape(Capsule())
                .opacity(isEnabled ? 1.0 : 0.6)
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        ContentView(view: configuration.label)
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct WelcomeButtonStyle: ButtonStyle {
    
    private struct ContentView<Content: View>: View {
        @Environment(\.isEnabled) private var isEnabled
        var view: Content
        var body: some View {
            view
                .padding()
                .frame(width: 200, height: 60)
                .background(Color(.mintleaf))
                .foregroundColor(isEnabled ? .white : Color(.grayslate))
                .font(.title)
                .clipShape(Capsule())
                .opacity(isEnabled ? 1.0 : 0.6)
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        ContentView(view: configuration.label)
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct WideButtonStyle: ButtonStyle {
    private struct ContentView<Content: View>: View {
        @Environment(\.isEnabled) private var isEnabled
        var view: Content
        var body: some View {
            view
                .padding()
                .frame(width: 260, height: 50)
            //.background(isEnabled ? Constants.MINT_LEAF : Constants.SILVER)
                .background(Color(.mintleaf))
                .foregroundColor(isEnabled ? .white : Color(.grayslate))
                .font(.title)
                .clipShape(Capsule())
                .opacity(isEnabled ? 1.0 : 0.6)
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        ContentView(view: configuration.label)
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}


// ====================================================================================

//// One Tutorial Solution for changing buttons using .isEnabled
//public struct ButtonStyleContent<Content: View>: View {
//
//    public init(@ViewBuilder viewBuilder: @escaping ContentBuilder) {
//        self.viewBuilder = viewBuilder
//    }
//
//    public typealias ContentBuilder = (_ isEnabled: Bool) -> Content
//
//    private let viewBuilder: ContentBuilder
//
//    @Environment(\.isEnabled)
//    public var isEnabled: Bool
//
//    public var body: some View {
//        viewBuilder(isEnabled)
//    }
//}

//// A Tutorial Solution for changing buttons using .isEnabled
//struct MyButtonStyle: ButtonStyle {
//
//    func makeBody(configuration: Configuration) -> some View {
//        ButtonStyleContent { isEnabled in
//            configuration.label
//                .padding()
//                .background(backgroundColor(isEnabled: isEnabled))
//                .clipShape(Capsule())
//        }
//    }
//
//    func backgroundColor(isEnabled: Bool) -> Color {
//        isEnabled ? .green : .red
//    }
//}


// ====================================================================================

//struct TimeoutsButtonOriginal: ButtonStyle {
//
//    // Options Buttons - Match Setup / Introduction / Reference / Etc.
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .padding()
//            .frame(width: 180, height: 40)
//            .background(Constants.SILVER)
//            .font(.body)
//            .foregroundColor(Constants.DARK_SLATE)
//            .clipShape(Capsule())
//            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
//            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
//    }
//}

// ====================================================================================

// Information about styling TextField objects
//struct ContentView: View {
//    @State private var text = ""
//
//    var body: some View {
//        TextField("type something...", text: $text)
//            .textFieldStyle(RoundedBorderTextFieldStyle())
//    }
//}

//struct SuperCustomTextFieldStyle: TextFieldStyle {
//    func _body(configuration: TextField<_Label>) -> some View {
//        configuration
//            .padding()
//            .border(Color.accentColor)
//    }
//}

//struct ContentView: View {
//    @State private var text = ""
//
//    var body: some View {
//        TextField("type something...", text: $text)
//            .textFieldStyle(SuperCustomTextFieldStyle())
//    }
//}


