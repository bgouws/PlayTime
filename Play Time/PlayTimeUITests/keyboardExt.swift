//
//  keyboardExt.swift
//  Play TimeTests
//
//  Created by Brandon Gouws on 2020/03/15.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import Foundation
import XCTest
// swiftlint:disable all

extension XCUIApplication {

    func tapA() { keys["a"].tap() }
    func tapB() { keys["b"].tap() }
    func tapC() { keys["c"].tap() }
    func tapD() { keys["d"].tap() }
    func tapE() { keys["e"].tap() }
    func tapF() { keys["f"].tap() }
    func tapG() { keys["g"].tap() }
    func tapH() { keys["h"].tap() }
    func tapI() { keys["i"].tap() }
    func tapJ() { keys["j"].tap() }
    func tapK() { keys["k"].tap() }
    func tapL() { keys["l"].tap() }
    func tapM() { keys["m"].tap() }
    func tapN() { keys["n"].tap() }
    func tapO() { keys["o"].tap() }
    func tapP() { keys["p"].tap() }
    func tapQ() { keys["q"].tap() }
    func tapR() { keys["r"].tap() }
    func tapS() { keys["s"].tap() }
    func tapT() { keys["t"].tap() }
    func tapU() { keys["u"].tap() }
    func tapV() { keys["v"].tap() }
    func tapW() { keys["w"].tap() }
    func tapX() { keys["x"].tap() }
    func tapY() { keys["y"].tap() }
    func tapZ() { keys["z"].tap() }

    func tapKeys(text: String) {
        for character in text {
            switch character {
            case "a": tapA()
            case "b": tapB()
            case "c": tapC()
            case "d": tapD()
            case "e": tapE()
            case "f": tapF()
            case "g": tapG()
            case "h": tapH()
            case "i": tapI()
            case "j": tapJ()
            case "k": tapK()
            case "l": tapL()
            case "m": tapM()
            case "n": tapN()
            case "o": tapO()
            case "p": tapP()
            case "q": tapQ()
            case "r": tapR()
            case "s": tapS()
            case "t": tapT()
            case "u": tapU()
            case "v": tapV()
            case "w": tapW()
            case "x": tapX()
            case "y": tapY()
            case "z": tapZ()
            default: XCTFail("Unknown Character")
            }
        }
    }

}
// swiftlint:enable all
