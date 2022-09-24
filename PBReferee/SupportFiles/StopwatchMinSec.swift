//
//  StopwatchHM.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/26/22.
//

import SwiftUI

struct StopwatchMinSec: View {

    @State private var elapsedTime = 0
    @State private var isRunning = false
    @State private var timer: Timer?
    @State var isShowHour = true
   
    var hours: Int {
        elapsedTime / 3600
    }
    var minutes: Int {
        (elapsedTime % 3600) / 60
    }
    var seconds: Int {
        elapsedTime % 60
    }

    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 5) {
                
                StopwatchMSUnit(timeUnit: minutes, timeUnitText: "MIN")
                Text(" : ")
                    .font(.system(size: 25))
                    .offset(y: -12)
                
                StopwatchMSUnit(timeUnit: seconds, timeUnitText: "SEC")
            }

            HStack {
                Button(action: {
                    if isRunning{
                        timer?.invalidate()
                      
                    } else {
                        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                            elapsedTime += 1
                        })
                    }
                    isRunning.toggle()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .frame(width: 60, height: 35, alignment: .center)
                            .foregroundColor(isRunning ? Constants.POMAGRANATE : Constants.MINT_LEAF)

                        Text(isRunning ? "Stop" : "Start")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
                }

                Button(action: {
                    elapsedTime = 0
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            //.frame(width: 80, height: 40, alignment: .center)
                            .frame(width: 60, height: 35, alignment: .center)
                            .foregroundColor(Constants.SILVER)

                        Text("Reset")
                            .font(.footnote)
                            .foregroundColor(Constants.DARK_SLATE)
                    }
                }
            }
//            Text("Credit to: Finsi Ennes")
//                .font(.caption)
//                .foregroundColor(.mint)
        }
        .padding(5)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.gray, lineWidth: 2)
        )

    }
}

struct StopwatchMSUnit: View {

    var timeUnit: Int
    var timeUnitText: String

    // Include "0" as prefix if number is less than 10.
    var timeUnitStr: String {
        let timeUnitStr = String(timeUnit)
        return timeUnit < 10 ? "0" + timeUnitStr : timeUnitStr
    }

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 12.0)
                    .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
                    .frame(width: 40, height: 40, alignment: .center)

                HStack(spacing: 2) {
                    Text(timeUnitStr.substring3(index: 0))
                        .font(.system(size: 24))
                    Text(timeUnitStr.substring3(index: 1))
                        .font(.system(size: 24))
                }
            }
            Text(timeUnitText)
                .font(.system(size: 10))
        }
    }
}

// TRT Commented out
//struct StopwatchMinSec_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            // TRT Commented Out:    darkGray.edgesIgnoringSafeArea(.all)
//
//            Stopwatch()
//        }
//    }
//}

extension String {
    func substring3(index: Int) -> String {
        let arrayString = Array(self)
        return String(arrayString[index])
    }
}

