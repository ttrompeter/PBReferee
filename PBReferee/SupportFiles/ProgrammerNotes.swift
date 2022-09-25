//
//  ProgrammerNotes.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/12/22.
//


//******************************************************************

/*
 TODO Items
 1. Single game to 15 points. Change sides after 8 points to one team.
 2. DONE - In best 3 of 5 games, set timeouts to 3.
 3. If single game, how many timeouts are there? Don't see in rules. My guess is 1.
 4. If game to 21 points, how to handle when goes past 21 to win by 2 points. What to display. Ponibnts end at 21.
 
 */

//******************************************************************

/*
 
 Change of side by teams during match. In the third or fifth game
 of such matches the teams change sides halfway through the game.
 
 A triangle mark is placed on the scoresheet of 3rd or 5th games of a
 match to indicate that the teams change sides after a team scores that
 point in the game. Example: If mark is at point 6, then change sides
 after the point where one team scores 6. Players have 1 minute to change sides.
 
 End-Change Marks
 AT 6 of the third game for 3 games to 11 points
 At 8 of the third game for 3 games to 15 points
 AT 11 of the third game for 3 games to 21 points
 
 Before match begins each team designates who will be the first server for the team
 The first server for each team wears an identifying wristband designating that they
 are the first server for their team.
 
 Which team serves first is determined at the pre-Match briefing. The referee determines
 which team "wins the coin toss" using a "secret" number (1 or 2) written on the back of
 his scorsheet. The winning team then decides to either serve, receive, or chose a side of
 the court. The other team then decides whatver is left. For instance if the winning team
 decides to serve, then the other team decides which side of the court to defend and receives.
 As a result we don't know whihe player will be the first server of the match, the first server
 for each team, or which side of the court the teams will be on until after the pre_match briefing.
 
 Thus, the layout of the scoresheet (whether the arrow points left or right) and the identification
 of values for first servers can't be set until after the pre-Match briefing. Plus the layout depends
 on which side of the court the referee stands.
 
 In doubles, teams may change the starting server between games and should notify the referee.
 Teams switch ends and initial service upon the completion of each game.
 In game three of five, the teams will switch ends when the first team reaches a score of 6 / 8 / 11
 
 */

//******************************************************************

/*
 
 Timeouts
 
 For games to 11 or 15 points each team gets 2 timeouts
 For games to 21 points, each team gets 3 timeouts
 
 A regular timeout last one minute, with the referee announcing when fifrteen seconds remain
 and clalling time in when the timeout ends.
 
 Timeouts can end early if both teams are ready to resume play
 
 Medical timeout is called when a play sustains an injry or has amedical emergency.
 Once medical peresonnel arrive the referee starts a 15 minute period for assessment and treatment.
 Each player can can 1 medical timeout
 If it is determined that there is no medical issue then a regualr timeout is charged.
 
 Equipment timeout. If referee determines that a team needs to adjust equipment and has no timeouts,
 the referee may cal an equipment timeout. Equipment timeouts can last up to 2 minutes.
 
 Timeout between games and matches. A team may request that one or more of their timeouts be used
 to extend the time between games or matches. If that time is not used the timeout(s) are restored.
 
 Referee timeout. CAn be called for extenuating circumstances. These include inclement weatherm medical
 situations, player bleeding on court, player is inclapable of playing but refuses to take a medical timeout.
 
 */

/*
 Violations
 
 Technical Foul – A referee’s assessment of a behavioral violation that results in one point being removed from the score of the offending team, unless their score is zero, in which case a point shall be added to the score of the opposing side. A technical foul shall be issued if one technical warning has already been given and a second technical warning is warranted; or when warranted by a player’s or team’s action, based on the referee’s judgement.
 
 
 The referee is empowered to call technical fouls. When a technical foul is called, one (1) point shall be added to the score of the abusing player’s opponents. If play is not immediately resumed, then the referee is empowered to forfeit the match in favor of the abusing player’s opponents. If a player or team receives two (2) technical fouls in a match or during the tournament, then that match shall automatically result in forfeiture and that player or team shall be expelled from the tournament. (14.M) Actions, which may result in technical fouls are:
           Profanity
           Excessive arguing
           Threats to any player or the referee
           Purposely breaking the ball or striking of the ball between rallies
           Throwing the paddle. If this results in striking a player, spectator, or damage to the court of facility, the technical foul is automatic
           Delay of game:
               Taking too much time during time-outs and between games
               Excessive questioning of the referee
               Excessive or unnecessary appeals
           Any other actions that are considered unsportsmanlike behavior

 If a player’s behavior is not severe enough to warrant a technical foul, a technical warning may be issued. In most situations, the referee should give a technical warning before issuing a technical foul.

 A referee can only be removed if both sides agree that the referee assigned is doing a poor job, or at the discretion of the Tournament Director
 
 */

//******************************************************************





//****************************************************************************************
// Information regardng showing two alerts
//                        Alerts regardng game and match winners
                        
                        
//                        .alert("", isPresented: $presentGameWinnerAlert, actions: {
//                            self.alertItem = AlertItem(title: Text("Game Over"), message: Text("Winner is Team 1"), dismissButton: .default(Text("OK"), action: {
//
//                                if match.isCompleted {
//                                    /// trigger second alert
//                                    DispatchQueue.main.async {
//                                        self.alertItem = AlertItem(title: Text("Match Over"), message: Text("Winner is Team 1"), dismissButton: .default(Text("OK"), action: self.closeMatch))
//                                    }
//                                }
//
//                            //}), secondaryButton: .cancel()  )
//                            }
//                        })

//                        Button(action: {
//
//                            //self.alertItem = AlertItem(title: Text("Game Over"), message: Text("Winner is Team 1"), primaryButton: .default(Text("OK"), action: {
//                            self.alertItem = AlertItem(title: Text("Game Over"), message: Text("Winner is Team 1"), dismissButton: .default(Text("OK"), action: {
//
//                                if match.isCompleted {
//                                    /// trigger second alert
//                                    DispatchQueue.main.async {
//                                        self.alertItem = AlertItem(title: Text("Match Over"), message: Text("Winner is Team 1"), dismissButton: .default(Text("OK"), action: self.closeMatch))
//                                    }
//                                }
//
//                                //}), secondaryButton: .cancel()  )
//                            }))
//                        }, label: {
//                            Text("SHOW ALERT")
//                                .font(.body)
//                                .foregroundColor(Constants.MINT_LEAF)
//                        }).alert(item: $alertItem) { alertItem in
//
//                            //guard let primaryButton = alertItem.primaryButton, let secondaryButton = alertItem.secondaryButton else {
//                            //                                    guard let dismissButton = alertItem.dismissButton else {
//                            //                                        return Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
//                            //                                    }
//                            print("Got here")
//                            //return Alert(title: alertItem.title, message: alertItem.message, primaryButton: primaryButton, secondaryButton: secondaryButton)
//                            return Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
//                        }
//                    }
//
//****************************************************************************************

