//
//  SideOutExtension.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/22/22.
//

import RealmSwift
import SwiftUI

extension MatchView {
    
    func sideOut() {
        
        scoresheetManager.lastActionType = Constants.LAST_ACTION_TYPE_SIDE_OUT
        scoresheetManager.lastActionScore = 33
        scoresheetManager.lastActionGameNumber = match.currentGameNumber
        scoresheetManager.lastActionIsSecondServer = match.isSecondServer
        scoresheetManager.lastActionPlayerNumber = match.servingPlayerNumber
        
        if match.servingPlayerNumber == 1 || match.servingPlayerNumber == 2 {
            // In here Team 1 was serving at sideout
            $match.games[match.currentGameArrayIndex].sideOutsTeam1.wrappedValue += 1
            switch match.games[match.currentGameArrayIndex].gameScoreTeam1 {
            case 0:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint0Game1Team1.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint0Game2Team1.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint0Game3Team1.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint0Game4Team1.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint0Game5Team1.wrappedValue = true
                }
            case 1:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint1Game1Team1.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint1Game2Team1.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint1Game3Team1.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint1Game4Team1.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint1Game5Team1.wrappedValue = true
                }
            case 2:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint2Game1Team1.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint2Game2Team1.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint2Game3Team1.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint2Game4Team1.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint2Game5Team1.wrappedValue = true
                }
            case 3:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint3Game1Team1.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint3Game2Team1.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint3Game3Team1.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint3Game4Team1.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint3Game5Team1.wrappedValue = true
                }
            case 4:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint4Game1Team1.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint4Game2Team1.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint4Game3Team1.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint4Game4Team1.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint4Game5Team1.wrappedValue = true
                }
            case 5:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint5Game1Team1.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint5Game2Team1.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint5Game3Team1.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint5Game4Team1.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint5Game5Team1.wrappedValue = true
                }
            case 6:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint6Game1Team1.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint6Game2Team1.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint6Game3Team1.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint6Game4Team1.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint6Game5Team1.wrappedValue = true
                }
            case 7:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint7Game1Team1.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint7Game2Team1.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint7Game3Team1.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint7Game4Team1.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint7Game5Team1.wrappedValue = true
                }
            case 8:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint8Game1Team1.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint8Game2Team1.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint8Game3Team1.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint8Game4Team1.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint8Game5Team1.wrappedValue = true
                }
            case 9:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint9Game1Team1.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint9Game2Team1.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint9Game3Team1.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint9Game4Team1.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint9Game5Team1.wrappedValue = true
                }
            case 10:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint10Game1Team1.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint10Game2Team1.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint10Game3Team1.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint10Game4Team1.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint10Game5Team1.wrappedValue = true
                }
            case 11:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint11Game1Team1.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint11Game2Team1.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint11Game3Team1.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint11Game4Team1.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint11Game5Team1.wrappedValue = true
                }
            case 12:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint12Game1Team1.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint12Game2Team1.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint12Game3Team1.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint12Game4Team1.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint12Game5Team1.wrappedValue = true
                }
            case 13:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint13Game1Team1.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint13Game2Team1.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint13Game3Team1.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint13Game4Team1.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint13Game5Team1.wrappedValue = true
                }
            case 14:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint14Game1Team1.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint14Game2Team1.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint14Game3Team1.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint14Game4Team1.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint14Game5Team1.wrappedValue = true
                }
            case 15:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint15Game1Team1.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint15Game2Team1.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint15Game3Team1.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint15Game4Team1.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint15Game5Team1.wrappedValue = true
                }
            case 16:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint16Game1Team1.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint16Game2Team1.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint16Game3Team1.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint16Game4Team1.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint16Game5Team1.wrappedValue = true
                }
            case 17:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint17Game1Team1.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint17Game2Team1.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint17Game3Team1.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint17Game4Team1.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint17Game5Team1.wrappedValue = true
                }
            case 18:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint18Game1Team1.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint18Game2Team1.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint18Game3Team1.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint18Game4Team1.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint18Game5Team1.wrappedValue = true
                }
            case 19:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint19Game1Team1.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint19Game2Team1.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint19Game3Team1.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint19Game4Team1.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint19Game5Team1.wrappedValue = true
                }
            case 20:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint20Game1Team1.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint20Game2Team1.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint20Game3Team1.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint20Game4Team1.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint20Game5Team1.wrappedValue = true
                }
            case 21:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint21Game1Team1.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint21Game2Team1.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint21Game3Team1.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint21Game4Team1.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint21Game5Team1.wrappedValue = true
                }
            default:
                print("Error setting image in switch statement of sideOut() for Team 1")
            }
        } else if match.servingPlayerNumber == 3 || match.servingPlayerNumber == 4 {
            // In here Team 2 was serving at sideout
            $match.games[match.currentGameArrayIndex].sideOutsTeam2.wrappedValue += 1
            switch match.games[match.currentGameArrayIndex].gameScoreTeam2 {
            case 0:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint0Game1Team2.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint0Game2Team2.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint0Game3Team2.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint0Game4Team2.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint0Game5Team2.wrappedValue = true
                }
            case 1:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint1Game1Team2.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint1Game2Team2.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint1Game3Team2.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint1Game4Team2.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint1Game5Team2.wrappedValue = true
                }
            case 2:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint2Game1Team2.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint2Game2Team2.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint2Game3Team2.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint2Game4Team2.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint2Game5Team2.wrappedValue = true
                }
            case 3:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint3Game1Team2.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint3Game2Team2.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint3Game3Team2.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint3Game4Team2.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint3Game5Team2.wrappedValue = true
                }
            case 4:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint4Game1Team2.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint4Game2Team2.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint4Game3Team2.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint4Game4Team2.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint4Game5Team2.wrappedValue = true
                }
            case 5:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint5Game1Team2.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint5Game2Team2.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint5Game3Team2.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint5Game4Team2.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint5Game5Team2.wrappedValue = true
                }
            case 6:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint6Game1Team2.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint6Game2Team2.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint6Game3Team2.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint6Game4Team2.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint6Game5Team2.wrappedValue = true
                }
            case 7:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint7Game1Team2.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint7Game2Team2.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint7Game3Team2.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint7Game4Team2.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint7Game5Team2.wrappedValue = true
                }
            case 8:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint8Game1Team2.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint8Game2Team2.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint8Game3Team2.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint8Game4Team2.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint8Game5Team2.wrappedValue = true
                }
            case 9:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint9Game1Team2.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint9Game2Team2.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint9Game3Team2.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint9Game4Team2.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint9Game5Team2.wrappedValue = true
                }
            case 10:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint10Game1Team2.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint10Game2Team2.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint10Game3Team2.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint10Game4Team2.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint10Game5Team2.wrappedValue = true
                }
            case 11:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint11Game1Team2.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint11Game2Team2.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint11Game3Team2.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint11Game4Team2.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint11Game5Team2.wrappedValue = true
                }
            case 12:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint12Game1Team2.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint12Game2Team2.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint12Game3Team2.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint12Game4Team2.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint12Game5Team2.wrappedValue = true
                }
            case 13:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint13Game1Team2.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint13Game2Team2.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint13Game3Team2.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint13Game4Team2.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint13Game5Team2.wrappedValue = true
                }
            case 14:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint14Game1Team2.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint14Game2Team2.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint14Game3Team2.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint14Game4Team2.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint14Game5Team2.wrappedValue = true
                }
            case 15:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint15Game1Team2.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint15Game2Team2.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint15Game3Team2.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint15Game4Team2.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint15Game5Team2.wrappedValue = true
                }
            case 16:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint16Game1Team2.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint16Game2Team2.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint16Game3Team2.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint16Game4Team2.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint16Game5Team2.wrappedValue = true
                }
            case 17:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint17Game1Team2.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint17Game2Team2.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint17Game3Team2.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint17Game4Team2.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint17Game5Team2.wrappedValue = true
                }
            case 18:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint18Game1Team2.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint18Game2Team2.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint18Game3Team2.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint18Game4Team2.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint18Game5Team2.wrappedValue = true
                }
            case 19:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint19Game1Team2.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint19Game2Team2.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint19Game3Team2.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint19Game4Team2.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint19Game5Team2.wrappedValue = true
                }
            case 20:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint20Game1Team2.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint20Game2Team2.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint20Game3Team2.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint20Game4Team2.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint20Game5Team2.wrappedValue = true
                }
            case 21:
                if match.currentGameNumber == 1 {
                    $match.images[0].isSideoutPoint21Game1Team2.wrappedValue = true
                } else if match.currentGameNumber == 2 {
                    $match.images[0].isSideoutPoint21Game2Team2.wrappedValue = true
                } else if match.currentGameNumber == 3 {
                    $match.images[0].isSideoutPoint21Game3Team2.wrappedValue = true
                } else if match.currentGameNumber == 4 {
                    $match.images[0].isSideoutPoint21Game4Team2.wrappedValue = true
                } else if match.currentGameNumber == 5 {
                    $match.images[0].isSideoutPoint21Game5Team2.wrappedValue = true
                }
            default:
                print("Error setting image in switch statement of sideOut() for Team 2")
            }
        }
        
        
        // Set server to the next server
        setServingPlayerNumber()
        $match.isSecondServer.wrappedValue.toggle()
        $match.whoIsServingText.wrappedValue = "1st Server"
        
        // Team service game is over so change values for isTeam1Serving and isServingLeftSide
        $match.isTeam1Serving.wrappedValue.toggle()
        $match.isServingLeftSide.wrappedValue.toggle()
        
        updateScore()
    }
}

