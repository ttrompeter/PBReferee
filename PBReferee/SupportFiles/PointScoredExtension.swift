//
//  PointScoredMatchExtension.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/20/22.
//

import RealmSwift
import SwiftUI

extension MatchView {
    
    func pointScored() {
        
        //*********************************************************************************************
        //scoreImagesRow1.remove(at: (pointNumber - 1))
        //scoreImagesRow1.insert(ScoreImage(boxImageName: "boxleftbackslash", boxNumber: "\(pointNumber)", isShowSideOut: false, sideOutImageName: "sideoutright"), at: (pointNumber - 1))
        /*
         Give each PointImage a unique number
         - - - - - - - - - - - - - - - - - - -
         For Team 1
         Game 1: 1 - 21  (need to allow for further expansion up to 30 points per game in case game goes longer than 21 points)
         Game 2: 31 - 51
         Game 3: 61 - 81
         Game 4: 101 - 121
         Game 5: 131 - 151
         - - - - - - - - - - - - - - - - - - -
         For Team 2
         Game 1: 201 - 221  (need to allow for further expansion up to 30 points per game in case game goes longer than 21 points)
         Game 2: 231 - 251
         Game 3: 261 - 281
         Game 4: 301 - 321
         Game 5: 331 - 351
         */
        
        var pointNumber = 0
        
        // Add the point to the proper player's point count
        if match.servingPlayerNumber == 1 {
            $match.games[match.currentGameArrayIndex].player1Points.wrappedValue += 1
            pointNumber = match.games[match.currentGameArrayIndex].player1Points +  match.games[match.currentGameArrayIndex].player2Points
        } else if match.servingPlayerNumber == 2 {
            $match.games[match.currentGameArrayIndex].player2Points.wrappedValue += 1
            pointNumber = match.games[match.currentGameArrayIndex].player1Points +  match.games[match.currentGameArrayIndex].player2Points
        } else if match.servingPlayerNumber == 3 {
            $match.games[match.currentGameArrayIndex].player3Points.wrappedValue += 1
            pointNumber = match.games[match.currentGameArrayIndex].player3Points +  match.games[match.currentGameArrayIndex].player4Points
        } else if match.servingPlayerNumber == 4 {
            $match.games[match.currentGameArrayIndex].player4Points.wrappedValue += 1
            pointNumber = match.games[match.currentGameArrayIndex].player3Points +  match.games[match.currentGameArrayIndex].player4Points
        }
        // Set the proper image value for the point scored
        if match.currentGameNumber == 1 {
            print("game number in pointScored: \(match.currentGameNumber)")
            // Game 1
            if match.isTeam1Serving {
                print("pointNumber in pointScored for Team 1: \(pointNumber)")
                if pointNumber > 0 && pointNumber < 21 {
                    print("Cases 1 - 20 for Team 1: Set image to either fwd slash or backslash as appropriate")
                    if match.isSecondServer {
                        // Is second server so use back slash image
                        $match.points[pointNumber - 1].boxImageName.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
                        print("Image set in match as Second Server Team 1 after set: \($match.points[pointNumber - 1].boxImageName)")
                    } else {
                        // Is first server so used forward slash image
                        $match.points[pointNumber - 1].boxImageName.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
                        print("Image set in match as First Server Team 1 after set: \($match.points[pointNumber - 1].boxImageName)")
                    }
                } else if pointNumber == 21 {
                    if match.isSecondServer {
                        $match.points[pointNumber - 1].boxImageName.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
                    } else {
                        $match.points[pointNumber - 1].boxImageName.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
                    }
                } else {
                    print("Error setting point image for Team 1 in pointScored() for Game 1 in PointScoredExtension of MatchView\npointNumber: \(pointNumber)\nservingPlayerNumber: \(match.servingPlayerNumber)")
                }
                
            } else {
                // Team 2 is serving
                // points index row numbers for Team 2 Game 1 are 105 - 125
                pointNumber = match.games[match.currentGameArrayIndex].player3Points +  match.games[match.currentGameArrayIndex].player4Points
                print("pointNumber in pointScored for Team 2: \(pointNumber)")
                if pointNumber > 0 && pointNumber < 21 {
                    print("Cases 1 - 20 for Team 2: Set image to either fwd slash or backslash as appropriate")
                    if match.isSecondServer {
                        
                        $match.points[pointNumber + 104].boxImageName.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
                    } else {
                        $match.points[pointNumber + 104].boxImageName.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
                    }
                } else if pointNumber == 21 {
                    if match.isSecondServer {
                        $match.points[pointNumber + 104].boxImageName.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
                    } else {
                        $match.points[pointNumber + 104].boxImageName.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
                    }
                } else {
                    print("Error setting point image for Team 2 in pointScored() in PointScoredExtension of MatchView\npointNumber: \(pointNumber)\nservingPlayerNumber: \(match.servingPlayerNumber)")
                }
            }
        }
        
        
        //*********************************************************************************************
        
        /*
         
         
         scoresheetManager.lastActionType = Constants.LAST_ACTION_TYPE_POINT
         scoresheetManager.lastActionScore = 11
         scoresheetManager.lastActionGameNumber = match.currentGameNumber
         scoresheetManager.lastActionIsSecondServer = match.isSecondServer
         scoresheetManager.lastActionPlayerNumber = match.servingPlayerNumber
         
         // TODO: - Need to handle game to 21 points if it goes past 21 points
         if match.servingPlayerNumber == 1 {
         $match.games[match.currentGameArrayIndex].player1Points.wrappedValue += 1
         // Player 1 Team 1 is serving as second server on Team 1
         if match.isSecondServer {
         // Second server uses backslash to mark points
         switch match.games[match.currentGameArrayIndex].gameScoreTeam1 {
         case 1:
         if match.currentGameNumber == 1 {
         $match.images[0].point1Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point1Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point1Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point1Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point1Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point1Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 2:
         if match.currentGameNumber == 1 {
         $match.images[0].point2Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point2Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point2Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point2Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point2Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point2Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 3:
         if match.currentGameNumber == 1 {
         $match.images[0].point3Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point3Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point3Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point3Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point3Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point3Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 4:
         if match.currentGameNumber == 1 {
         $match.images[0].point4Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point4Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point4Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point4Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point4Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point4Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 5:
         if match.currentGameNumber == 1 {
         $match.images[0].point5Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point5Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point5Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point5Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point5Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point5Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 6:
         if match.currentGameNumber == 1 {
         $match.images[0].point6Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point6Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point6Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point6Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point6Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point6Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 7:
         if match.currentGameNumber == 1 {
         $match.images[0].point7Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point7Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point7Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point7Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point7Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point7Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 8:
         if match.currentGameNumber == 1 {
         $match.images[0].point8Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point8Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point8Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point8Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point8Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point8Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 9:
         if match.currentGameNumber == 1 {
         $match.images[0].point9Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point9Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point9Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point9Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point9Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point9Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 10:
         if match.currentGameNumber == 1 {
         $match.images[0].point10Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point10Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point10Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point10Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point10Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point10Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 11:
         if match.currentGameNumber == 1 {
         $match.images[0].point11Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point11Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point11Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point11Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point11Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point11Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 12:
         if match.currentGameNumber == 1 {
         $match.images[0].point12Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point12Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point12Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point12Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point12Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point1Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 13:
         if match.currentGameNumber == 1 {
         $match.images[0].point13Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point13Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point13Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point13Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point13Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point13Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 14:
         if match.currentGameNumber == 1 {
         $match.images[0].point14Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point14Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point14Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point14Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point14Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point14Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 15:
         if match.currentGameNumber == 1 {
         $match.images[0].point15Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point15Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point15Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point15Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point15Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point15Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 16:
         if match.currentGameNumber == 1 {
         $match.images[0].point16Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point16Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point16Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point16Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point16Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point16Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 17:
         if match.currentGameNumber == 1 {
         $match.images[0].point17Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point17Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point17Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point17Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point17Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point17Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 18:
         if match.currentGameNumber == 1 {
         $match.images[0].point18Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point18Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point18Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point18Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point18Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point18Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 19:
         if match.currentGameNumber == 1 {
         $match.images[0].point19Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point19Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point19Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point19Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point19Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point19Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 20:
         if match.currentGameNumber == 1 {
         $match.images[0].point20Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point20Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point20Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point20Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point20Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point20Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 21:
         if match.currentGameNumber == 1 {
         $match.images[0].point21Game1ImageTm1.wrappedValue = Constants.BOX_RIGHT_END_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point21Game2ImageTm1.wrappedValue = Constants.BOX_RIGHT_END_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point21Game3ImageTm1.wrappedValue = Constants.BOX_RIGHT_END_BACK_SLASH
         } else {
         $match.images[0].point21Game3ImageTm1.wrappedValue = Constants.BOX_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point21Game4ImageTm1.wrappedValue = Constants.BOX_RIGHT_ONLY_END_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point21Game5ImageTm1.wrappedValue = Constants.BOX_BACK_SLASH
         }
         default:
         print("Error setting image in switch statement of pointScored()")
         }
         } else {
         // Player 1 Team 1 is serving as first server on Team 1
         // First server uses forwardslash to mark points - "squareleftfwdslash"
         //print("    > > > gameScoreTeam1 in pointScored() [2]: \(match.gameScoreTeam1)")
         switch match.games[match.currentGameArrayIndex].gameScoreTeam1 {
         case 1:
         if match.currentGameNumber == 1 {
         $match.images[0].point1Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point1Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point1Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point1Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point1Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point1Game5ImageTm1.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         case 2:
         if match.currentGameNumber == 1 {
         $match.images[0].point2Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point2Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point2Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point2Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point2Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point2Game5ImageTm1.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         case 3:
         if match.currentGameNumber == 1 {
         $match.images[0].point3Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point3Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point3Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point3Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point3Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point3Game5ImageTm1.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         case 4:
         if match.currentGameNumber == 1 {
         $match.images[0].point4Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point4Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point4Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point4Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point4Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point4Game5ImageTm1.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         case 5:
         if match.currentGameNumber == 1 {
         $match.images[0].point5Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point5Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point5Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point5Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point5Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point5Game5ImageTm1.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         case 6:
         if match.currentGameNumber == 1 {
         $match.images[0].point6Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point6Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point6Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point6Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point6Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point6Game5ImageTm1.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         case 7:
         if match.currentGameNumber == 1 {
         $match.images[0].point7Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point7Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point7Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point7Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point7Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point7Game5ImageTm1.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         case 8:
         if match.currentGameNumber == 1 {
         $match.images[0].point8Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point8Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point8Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point8Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point8Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point8Game5ImageTm1.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         case 9:
         if match.currentGameNumber == 1 {
         $match.images[0].point9Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point9Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point9Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point9Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point9Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point9Game5ImageTm1.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         case 10:
         if match.currentGameNumber == 1 {
         $match.images[0].point10Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point10Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point10Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point10Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point10Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point10Game5ImageTm1.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         case 11:
         if match.currentGameNumber == 1 {
         $match.images[0].point11Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point11Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point11Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point11Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point11Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point11Game5ImageTm1.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         case 12:
         if match.currentGameNumber == 1 {
         $match.images[0].point12Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point12Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point12Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point12Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point12Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point12Game5ImageTm1.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         case 13:
         if match.currentGameNumber == 1 {
         $match.images[0].point13Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point13Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point13Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point13Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point13Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point1Game5ImageTm1.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         case 14:
         if match.currentGameNumber == 1 {
         $match.images[0].point14Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point14Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point14Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point14Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point14Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point14Game5ImageTm1.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         case 15:
         if match.currentGameNumber == 1 {
         $match.images[0].point15Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point15Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point15Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point15Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point15Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point15Game5ImageTm1.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         case 16:
         if match.currentGameNumber == 1 {
         $match.images[0].point16Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point16Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point16Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point16Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point16Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point16Game5ImageTm1.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         case 17:
         if match.currentGameNumber == 1 {
         $match.images[0].point17Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point17Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point17Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point17Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point17Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point17Game5ImageTm1.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         case 18:
         if match.currentGameNumber == 1 {
         $match.images[0].point18Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point18Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point18Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point18Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point18Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point18Game5ImageTm1.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         case 19:
         if match.currentGameNumber == 1 {
         $match.images[0].point19Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point19Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point19Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point19Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point19Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point19Game5ImageTm1.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         case 20:
         if match.currentGameNumber == 1 {
         $match.images[0].point20Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point20Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point20Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point20Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point20Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point20Game5ImageTm1.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         case 21:
         if match.currentGameNumber == 1 {
         $match.images[0].point21Game1ImageTm1.wrappedValue = Constants.BOX_RIGHT_END_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point21Game2ImageTm1.wrappedValue = Constants.BOX_RIGHT_END_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point21Game3ImageTm1.wrappedValue = Constants.BOX_RIGHT_END_FORWARD_SLASH
         } else {
         $match.images[0].point21Game3ImageTm1.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point21Game4ImageTm1.wrappedValue = Constants.BOX_RIGHT_ONLY_END_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point21Game5ImageTm1.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         default:
         print("Error setting image in switch statement of pointScored()")
         }
         }
         // End if player 1 serving
         } else if  match.servingPlayerNumber == 2 {
         $match.games[match.currentGameArrayIndex].player2Points.wrappedValue += 1
         // Player 2 Team 1 is serving as second server on Team 1
         if match.isSecondServer {
         // Second server uses backslash to mark points - "squareleftbackslash"
         
         //print("    > > > gameScoreTeam1 in pointScored()[3]: \(match.gameScoreTeam1)")
         switch match.games[match.currentGameArrayIndex].gameScoreTeam1 {
         case 1:
         if match.currentGameNumber == 1 {
         $match.images[0].point1Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point1Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point1Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point1Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point1Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point1Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 2:
         if match.currentGameNumber == 1 {
         $match.images[0].point2Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point2Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point2Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point2Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point2Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point2Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 3:
         if match.currentGameNumber == 1 {
         $match.images[0].point3Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point3Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point3Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point3Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         }
         else if match.currentGameNumber == 4 {
         $match.images[0].point3Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         }
         else if match.currentGameNumber == 5 {
         $match.images[0].point3Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 4:
         if match.currentGameNumber == 1 {
         $match.images[0].point4Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point4Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point4Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point4Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point4Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point4Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 5:
         if match.currentGameNumber == 1 {
         $match.images[0].point5Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point5Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point5Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point5Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point5Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point5Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 6:
         if match.currentGameNumber == 1 {
         $match.images[0].point6Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point6Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point6Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point6Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point6Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point6Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 7:
         if match.currentGameNumber == 1 {
         $match.images[0].point7Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point7Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point7Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point7Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point7Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point7Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 8:
         if match.currentGameNumber == 1 {
         $match.images[0].point8Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point8Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point8Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point8Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point8Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point8Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 9:
         if match.currentGameNumber == 1 {
         $match.images[0].point9Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point9Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point9Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point9Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         }
         else if match.currentGameNumber == 4 {
         $match.images[0].point9Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         }
         else if match.currentGameNumber == 5 {
         $match.images[0].point9Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 10:
         if match.currentGameNumber == 1 {
         $match.images[0].point10Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point10Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point10Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point10Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point10Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point10Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 11:
         if match.currentGameNumber == 1 {
         $match.images[0].point11Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point11Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point11Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point11Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point11Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point11Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 12:
         if match.currentGameNumber == 1 {
         $match.images[0].point12Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point12Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point12Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point12Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point12Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point12Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 13:
         if match.currentGameNumber == 1 {
         $match.images[0].point13Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point13Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point13Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point13Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point13Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point13Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 14:
         if match.currentGameNumber == 1 {
         $match.images[0].point14Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point14Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point14Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point14Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point14Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point14Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 15:
         if match.currentGameNumber == 1 {
         $match.images[0].point15Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point15Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point15Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point15Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point15Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point15Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 16:
         if match.currentGameNumber == 1 {
         $match.images[0].point16Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point16Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point16Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point16Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point16Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point16Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 17:
         if match.currentGameNumber == 1 {
         $match.images[0].point17Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point17Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point17Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point17Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point17Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point17Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 18:
         if match.currentGameNumber == 1 {
         $match.images[0].point18Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point18Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point18Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point18Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point18Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point18Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 19:
         if match.currentGameNumber == 1 {
         $match.images[0].point19Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point19Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point19Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point19Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point19Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point19Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 20:
         if match.currentGameNumber == 1 {
         $match.images[0].point20Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point20Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point20Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point20Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point20Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point20Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 21:
         if match.currentGameNumber == 1 {
         $match.images[0].point21Game1ImageTm1.wrappedValue = Constants.BOX_RIGHT_END_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point21Game2ImageTm1.wrappedValue = Constants.BOX_RIGHT_END_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point21Game3ImageTm1.wrappedValue = Constants.BOX_RIGHT_END_BACK_SLASH
         } else {
         $match.images[0].point21Game3ImageTm1.wrappedValue = Constants.BOX_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point21Game4ImageTm1.wrappedValue = Constants.BOX_RIGHT_ONLY_END_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point21Game5ImageTm1.wrappedValue = Constants.BOX_BACK_SLASH
         }
         default:
         print("Error setting image in switch statement of pointScored()")
         }
         } else {
         // Player 2 Team 1 is serving as first server on Team 1
         // First server uses forwardslash to mark points - "squareleftfwdslash"
         //print("    > > > gameScoreTeam1 in pointScored() [4]: \(match.gameScoreTeam1)")
         switch match.games[match.currentGameArrayIndex].gameScoreTeam1 {
         case 1:
         if match.currentGameNumber == 1 {
         $match.images[0].point1Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point1Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point1Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point1Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point1Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point1Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 2:
         if match.currentGameNumber == 1 {
         $match.images[0].point2Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point2Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point2Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point2Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point2Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point2Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 3:
         if match.currentGameNumber == 1 {
         $match.images[0].point3Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point3Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point3Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point3Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point3Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point3Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 4:
         if match.currentGameNumber == 1 {
         $match.images[0].point4Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point4Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point4Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point4Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point4Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point4Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 5:
         if match.currentGameNumber == 1 {
         $match.images[0].point5Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point5Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point5Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point5Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point5Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point5Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 6:
         if match.currentGameNumber == 1 {
         $match.images[0].point6Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point6Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point6Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point6Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point6Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point6Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 7:
         if match.currentGameNumber == 1 {
         $match.images[0].point7Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point7Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point7Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point7Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point7Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point7Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 8:
         if match.currentGameNumber == 1 {
         $match.images[0].point8Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point8Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point8Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point8Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point8Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point8Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 9:
         if match.currentGameNumber == 1 {
         $match.images[0].point9Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point9Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point9Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point9Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point9Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point9Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 10:
         if match.currentGameNumber == 1 {
         $match.images[0].point10Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point10Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point10Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point10Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point10Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point10Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 11:
         if match.currentGameNumber == 1 {
         $match.images[0].point11Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point11Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point11Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point11Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point11Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point11Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 12:
         if match.currentGameNumber == 1 {
         $match.images[0].point12Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point12Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point12Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point12Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point12Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point12Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 13:
         if match.currentGameNumber == 1 {
         $match.images[0].point13Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point13Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point13Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point13Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point13Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point13Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 14:
         if match.currentGameNumber == 1 {
         $match.images[0].point14Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point14Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point14Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point14Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point14Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point14Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 15:
         if match.currentGameNumber == 1 {
         $match.images[0].point15Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point15Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point15Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point15Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point15Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point15Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 16:
         if match.currentGameNumber == 1 {
         $match.images[0].point16Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point16Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point16Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point16Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point16Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point16Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 17:
         if match.currentGameNumber == 1 {
         $match.images[0].point17Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point17Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point17Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point17Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point17Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point17Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 18:
         if match.currentGameNumber == 1 {
         $match.images[0].point18Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point18Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point18Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point18Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point18Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point18Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 19:
         if match.currentGameNumber == 1 {
         $match.images[0].point19Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point19Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point19Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point19Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point19Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point19Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 20:
         if match.currentGameNumber == 1 {
         $match.images[0].point20Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point20Game2ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point20Game3ImageTm1.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point20Game3ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point20Game4ImageTm1.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point20Game5ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 21:
         if match.currentGameNumber == 1 {
         $match.images[0].point21Game1ImageTm1.wrappedValue = Constants.BOX_RIGHT_END_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point21Game2ImageTm1.wrappedValue = Constants.BOX_RIGHT_END_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point21Game3ImageTm1.wrappedValue = Constants.BOX_RIGHT_END_FORWARD_SLASH
         } else {
         $match.images[0].point21Game3ImageTm1.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point21Game4ImageTm1.wrappedValue = Constants.BOX_RIGHT_ONLY_END_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point21Game5ImageTm1.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         default:
         print("Error setting image in switch statement of pointScored()")
         }
         }
         // End if player 2 serving
         } else if  match.servingPlayerNumber == 3 {
         $match.games[match.currentGameArrayIndex].player3Points.wrappedValue += 1
         // Player 1 Team 2 is serving as second server on Team 2
         if match.isSecondServer {
         // Second server uses backslash to mark points - "squareleftbackslash"
         
         //print("    > > > gameScoreTeam2 in pointScored()[5]: \(match.gameScoreTeam2)")
         switch match.games[match.currentGameArrayIndex].gameScoreTeam2 {
         case 1:
         if match.currentGameNumber == 1 {
         $match.images[0].point1Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point1Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point1Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point1Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point1Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point1Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 2:
         if match.currentGameNumber == 1 {
         $match.images[0].point2Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point2Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point2Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point2Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         }
         else if match.currentGameNumber == 4 {
         $match.images[0].point2Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point2Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 3:
         if match.currentGameNumber == 1 {
         $match.images[0].point3Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point3Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point3Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point3Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point3Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point3Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 4:
         if match.currentGameNumber == 1 {
         $match.images[0].point4Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point4Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point4Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point4Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point4Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point4Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 5:
         if match.currentGameNumber == 1 {
         $match.images[0].point5Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point5Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point5Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point5Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point5Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point5Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 6:
         if match.currentGameNumber == 1 {
         $match.images[0].point6Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point6Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point6Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point6Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point6Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point6Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 7:
         if match.currentGameNumber == 1 {
         $match.images[0].point7Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point7Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point7Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point7Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point7Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point7Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 8:
         if match.currentGameNumber == 1 {
         $match.images[0].point8Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point8Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point8Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point8Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point8Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point8Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 9:
         if match.currentGameNumber == 1 {
         $match.images[0].point9Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point9Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point9Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point9Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point9Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point9Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 10:
         if match.currentGameNumber == 1 {
         $match.images[0].point10Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point10Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point10Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point10Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point10Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point10Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 11:
         if match.currentGameNumber == 1 {
         $match.images[0].point11Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point11Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point11Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point11Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point11Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point11Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 12:
         if match.currentGameNumber == 1 {
         $match.images[0].point12Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point12Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point12Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point12Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point12Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point12Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 13:
         if match.currentGameNumber == 1 {
         $match.images[0].point13Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point13Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point13Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point13Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point13Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point1Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 14:
         if match.currentGameNumber == 1 {
         $match.images[0].point14Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point14Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point14Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point14Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point14Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point14Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 15:
         if match.currentGameNumber == 1 {
         $match.images[0].point15Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point15Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point15Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point15Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point15Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point15Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 16:
         if match.currentGameNumber == 1 {
         $match.images[0].point16Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point16Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point16Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point16Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point16Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         }
         else if match.currentGameNumber == 5 {
         $match.images[0].point16Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 17:
         if match.currentGameNumber == 1 {
         $match.images[0].point17Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point17Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point17Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point17Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point17Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         }
         else if match.currentGameNumber == 5 {
         $match.images[0].point17Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 18:
         if match.currentGameNumber == 1 {
         $match.images[0].point18Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point18Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point18Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point18Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point18Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point18Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 19:
         if match.currentGameNumber == 1 {
         $match.images[0].point19Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point19Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point19Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point19Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point19Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point19Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 20:
         if match.currentGameNumber == 1 {
         $match.images[0].point20Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point20Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point20Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else {
         $match.images[0].point20Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point20Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point20Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 21:
         if match.currentGameNumber == 1 {
         $match.images[0].point21Game1ImageTm2.wrappedValue = Constants.BOX_RIGHT_END_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point21Game2ImageTm2.wrappedValue = Constants.BOX_RIGHT_END_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point21Game3ImageTm2.wrappedValue = Constants.BOX_RIGHT_END_BACK_SLASH
         } else {
         $match.images[0].point21Game3ImageTm2.wrappedValue = Constants.BOX_BACK_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point21Game4ImageTm2.wrappedValue = Constants.BOX_RIGHT_ONLY_END_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point21Game5ImageTm2.wrappedValue = Constants.BOX_BACK_SLASH
         }
         
         default:
         print("Error setting image in switch statement of pointScored()")
         }
         } else {
         // Player 1 Team 2 is serving as first server on Team 2
         // First server uses forwardslash to mark points - "squareleftfwdslash"
         //print("    > > > gameScoreTeam2 in pointScored() [6]: \(match.gameScoreTeam2)")
         switch match.games[match.currentGameArrayIndex].gameScoreTeam2 {
         case 1:
         if match.currentGameNumber == 1 {
         $match.images[0].point1Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point1Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point1Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point1Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point1Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point1Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 2:
         if match.currentGameNumber == 1 {
         $match.images[0].point2Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point2Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point2Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point2Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point2Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point2Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 3:
         if match.currentGameNumber == 1 {
         $match.images[0].point3Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point3Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point3Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point3Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         }
         else if match.currentGameNumber == 4 {
         $match.images[0].point3Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point3Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 4:
         if match.currentGameNumber == 1 {
         $match.images[0].point4Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point4Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point4Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point4Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point4Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point4Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 5:
         if match.currentGameNumber == 1 {
         $match.images[0].point5Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point5Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point5Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point5Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point5Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point5Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 6:
         if match.currentGameNumber == 1 {
         $match.images[0].point6Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point6Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point6Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point6Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point6Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point6Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 7:
         if match.currentGameNumber == 1 {
         $match.images[0].point7Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point7Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point7Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point7Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point7Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point7Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 8:
         if match.currentGameNumber == 1 {
         $match.images[0].point8Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point8Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point8Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point8Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point8Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point8Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 9:
         if match.currentGameNumber == 1 {
         $match.images[0].point9Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point9Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point9Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point9Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point9Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point9Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 10:
         if match.currentGameNumber == 1 {
         $match.images[0].point10Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point10Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point10Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point10Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point10Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point10Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 11:
         if match.currentGameNumber == 1 {
         $match.images[0].point11Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point11Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point11Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point11Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point11Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point11Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 12:
         if match.currentGameNumber == 1 {
         $match.images[0].point12Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point12Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point12Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point12Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point12Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point12Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 13:
         if match.currentGameNumber == 1 {
         $match.images[0].point13Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point13Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point13Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point13Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point13Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point13Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 14:
         if match.currentGameNumber == 1 {
         $match.images[0].point14Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point14Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point14Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point14Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point14Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point14Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 15:
         if match.currentGameNumber == 1 {
         $match.images[0].point15Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point15Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point15Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point15Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point15Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point15Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 16:
         if match.currentGameNumber == 1 {
         $match.images[0].point16Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point16Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point16Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point16Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point16Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point16Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 17:
         if match.currentGameNumber == 1 {
         $match.images[0].point17Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point17Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point17Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point17Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point17Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point17Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 18:
         if match.currentGameNumber == 1 {
         $match.images[0].point18Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point18Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point18Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point18Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point18Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point18Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 19:
         if match.currentGameNumber == 1 {
         $match.images[0].point19Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point19Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point19Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point19Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point19Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point19Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 20:
         if match.currentGameNumber == 1 {
         $match.images[0].point20Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point20Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point20Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point20Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point20Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point20Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 21:
         if match.currentGameNumber == 1 {
         $match.images[0].point21Game1ImageTm2.wrappedValue = Constants.BOX_RIGHT_END_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point21Game2ImageTm2.wrappedValue = Constants.BOX_RIGHT_END_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point21Game3ImageTm2.wrappedValue = Constants.BOX_RIGHT_END_FORWARD_SLASH
         } else {
         $match.images[0].point21Game3ImageTm2.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point21Game4ImageTm2.wrappedValue = Constants.BOX_RIGHT_ONLY_END_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point21Game5ImageTm2.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         default:
         print("Error setting image in switch statement of pointScored()")
         }
         }
         
         // End if player 3 serving
         }
         
         else if  match.servingPlayerNumber == 4 {
         $match.games[match.currentGameArrayIndex].player4Points.wrappedValue += 1
         // Player 2 Team 2 is serving as second server on Team 2
         if match.isSecondServer {
         // Second server uses backslash to mark points - "squareleftbackslash"
         
         //print("    > > > gameScoreTeam2 in pointScored()[7]: \(match.gameScoreTeam2)")
         switch match.games[match.currentGameArrayIndex].gameScoreTeam2 {
         case 1:
         if match.currentGameNumber == 1 {
         $match.images[0].point1Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point1Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         $match.images[0].point1Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 4 {
         $match.images[0].point1Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point1Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 2:
         if match.currentGameNumber == 1 {
         $match.images[0].point2Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point2Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         $match.images[0].point2Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 4 {
         $match.images[0].point2Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point2Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 3:
         if match.currentGameNumber == 1 {
         $match.images[0].point3Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point3Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         $match.images[0].point3Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 4 {
         $match.images[0].point3Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point3Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 4:
         if match.currentGameNumber == 1 {
         $match.images[0].point4Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point4Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         $match.images[0].point4Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 4 {
         $match.images[0].point4Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point4Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 5:
         if match.currentGameNumber == 1 {
         $match.images[0].point5Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point5Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         $match.images[0].point5Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 4 {
         $match.images[0].point5Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point5Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 6:
         if match.currentGameNumber == 1 {
         $match.images[0].point6Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point6Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         $match.images[0].point6Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 4 {
         $match.images[0].point6Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point6Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 7:
         if match.currentGameNumber == 1 {
         $match.images[0].point7Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point7Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         $match.images[0].point7Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 4 {
         $match.images[0].point7Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point7Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 8:
         if match.currentGameNumber == 1 {
         $match.images[0].point8Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point8Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         $match.images[0].point8Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 4 {
         $match.images[0].point8Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point8Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 9:
         if match.currentGameNumber == 1 {
         $match.images[0].point9Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point9Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         $match.images[0].point9Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 4 {
         $match.images[0].point9Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point9Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 10:
         if match.currentGameNumber == 1 {
         $match.images[0].point10Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point10Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         $match.images[0].point10Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 4 {
         $match.images[0].point10Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point10Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 11:
         if match.currentGameNumber == 1 {
         $match.images[0].point11Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point11Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         $match.images[0].point11Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 4 {
         $match.images[0].point11Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point11Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 12:
         if match.currentGameNumber == 1 {
         $match.images[0].point12Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point12Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         $match.images[0].point12Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 4 {
         $match.images[0].point12Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point12Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 13:
         if match.currentGameNumber == 1 {
         $match.images[0].point13Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point13Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         $match.images[0].point13Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 4 {
         $match.images[0].point13Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point13Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 14:
         if match.currentGameNumber == 1 {
         $match.images[0].point14Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point14Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         $match.images[0].point14Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 4 {
         $match.images[0].point14Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point14Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 15:
         if match.currentGameNumber == 1 {
         $match.images[0].point15Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point15Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         $match.images[0].point15Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 4 {
         $match.images[0].point15Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point15Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 16:
         if match.currentGameNumber == 1 {
         $match.images[0].point16Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point16Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         $match.images[0].point16Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 4 {
         $match.images[0].point16Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point16Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 17:
         if match.currentGameNumber == 1 {
         $match.images[0].point17Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point17Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         $match.images[0].point17Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 4 {
         $match.images[0].point17Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point17Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 18:
         if match.currentGameNumber == 1 {
         $match.images[0].point18Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point18Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         $match.images[0].point18Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 4 {
         $match.images[0].point18Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point18Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 19:
         if match.currentGameNumber == 1 {
         $match.images[0].point19Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point19Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         $match.images[0].point19Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 4 {
         $match.images[0].point19Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point19Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 20:
         if match.currentGameNumber == 1 {
         $match.images[0].point20Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point20Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         $match.images[0].point20Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 4 {
         $match.images[0].point20Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point20Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 21:
         if match.currentGameNumber == 1 {
         $match.images[0].point21Game1ImageTm2.wrappedValue = Constants.BOX_RIGHT_END_BACK_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point21Game2ImageTm2.wrappedValue = Constants.BOX_RIGHT_END_BACK_SLASH
         } else if match.currentGameNumber == 3 {
         $match.images[0].point21Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         } else if match.currentGameNumber == 4 {
         $match.images[0].point21Game4ImageTm2.wrappedValue = Constants.BOX_RIGHT_ONLY_END_BACK_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point21Game5ImageTm2.wrappedValue = Constants.BOX_BACK_SLASH
         }
         
         default:
         print("Error setting image in switch statement of pointScored()")
         }
         } else {
         // Player 2 Team 2 is serving as first server on Team 2
         // First server uses forwardslash to mark points - "squareleftfwdslash"
         //print("    > > > gameScoreTeam2 in pointScored() [8]: \(match.gameScoreTeam2)")
         switch match.games[match.currentGameArrayIndex].gameScoreTeam2 {
         case 1:
         if match.currentGameNumber == 1 {
         $match.images[0].point1Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point1Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point1Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point1Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point1Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point1Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 2:
         if match.currentGameNumber == 1 {
         $match.images[0].point2Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point2Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point2Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point2Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point2Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point2Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 3:
         if match.currentGameNumber == 1 {
         $match.images[0].point3Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point3Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point3Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point3Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point3Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point3Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 4:
         if match.currentGameNumber == 1 {
         $match.images[0].point4Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point4Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point4Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point4Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point4Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point4Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 5:
         if match.currentGameNumber == 1 {
         $match.images[0].point5Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point5Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point5Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point5Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point5Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point5Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 6:
         if match.currentGameNumber == 1 {
         $match.images[0].point6Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point6Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point6Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point6Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point6Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point6Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 7:
         if match.currentGameNumber == 1 {
         $match.images[0].point7Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point7Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point7Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point7Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point7Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point7Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 8:
         if match.currentGameNumber == 1 {
         $match.images[0].point8Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point8Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point8Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point8Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point8Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point8Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 9:
         if match.currentGameNumber == 1 {
         $match.images[0].point9Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point9Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point9Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point9Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point9Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point9Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 10:
         if match.currentGameNumber == 1 {
         $match.images[0].point10Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point10Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point10Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point10Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point10Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point10Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 11:
         if match.currentGameNumber == 1 {
         $match.images[0].point11Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point11Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point11Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point11Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point11Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point11Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_BACK_SLASH
         }
         case 12:
         if match.currentGameNumber == 1 {
         $match.images[0].point12Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point12Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point12Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point12Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point12Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point12Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 13:
         if match.currentGameNumber == 1 {
         $match.images[0].point13Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point13Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point13Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point13Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point13Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point13Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 14:
         if match.currentGameNumber == 1 {
         $match.images[0].point14Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point14Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point14Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point14Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point14Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point14Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 15:
         if match.currentGameNumber == 1 {
         $match.images[0].point15Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point15Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point15Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point15Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point15Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point15Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 16:
         if match.currentGameNumber == 1 {
         $match.images[0].point16Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point16Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point16Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point16Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point16Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point16Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 17:
         if match.currentGameNumber == 1 {
         $match.images[0].point17Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point17Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point17Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point17Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point17Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point17Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 18:
         if match.currentGameNumber == 1 {
         $match.images[0].point18Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point18Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point18Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point18Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point18Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point18Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 19:
         if match.currentGameNumber == 1 {
         $match.images[0].point19Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point19Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point19Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point19Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point19Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point19Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 20:
         if match.currentGameNumber == 1 {
         $match.images[0].point20Game1ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point20Game2ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point20Game3ImageTm2.wrappedValue = Constants.BOX_LEFT_FORWARD_SLASH
         } else {
         $match.images[0].point20Game3ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point20Game4ImageTm2.wrappedValue = Constants.BOX_LEFT_ONLY_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point20Game5ImageTm2.wrappedValue = Constants.BOX_BOTTOM_LEFT_FORWARD_SLASH
         }
         case 21:
         if match.currentGameNumber == 1 {
         $match.images[0].point21Game1ImageTm2.wrappedValue = Constants.BOX_RIGHT_END_FORWARD_SLASH
         } else if match.currentGameNumber == 2 {
         $match.images[0].point21Game2ImageTm2.wrappedValue = Constants.BOX_RIGHT_END_FORWARD_SLASH
         } else if match.currentGameNumber == 3 {
         if match.selectedMatchFormat == 3 {
         $match.images[0].point21Game3ImageTm2.wrappedValue = Constants.BOX_RIGHT_END_FORWARD_SLASH
         } else {
         $match.images[0].point21Game3ImageTm2.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         } else if match.currentGameNumber == 4 {
         $match.images[0].point21Game4ImageTm2.wrappedValue = Constants.BOX_RIGHT_ONLY_END_FORWARD_SLASH
         } else if match.currentGameNumber == 5 {
         $match.images[0].point21Game5ImageTm2.wrappedValue = Constants.BOX_FORWARD_SLASH
         }
         default:
         print("Error setting image in switch statement of pointScored()")
         }
         }
         }
         
         */
        
        
    } // End PointScored
    
}

