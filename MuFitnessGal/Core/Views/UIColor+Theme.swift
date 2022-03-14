//
//  UIColor+Theme.swift
//  Tonari
//
//  Created by Mu Yu on 8/1/21.
//

import UIKit

extension UIColor {
    
    struct background {
        static let view = UIColor(hex: "f9f9f9")
        static let header = UIColor(hex: "E7F1F1")
    }
    
    struct brand {
        static let primary = UIColor(hex: "4C8C87")
        static let secondary = UIColor(hex: "F68B5D")
        static let tertiary = UIColor(hex: "E9DBCB")
        static let light = UIColor(hex: "F8F2E9")
    }
    
    struct basic {
        static let light = UIColor(hex: "FAFCFE")
        static let dark = UIColor(hex: "0E0E2C")
        static let accent = UIColor(hex: "ECF1F4")
        static let darkAccent = UIColor(hex: "D4DADB")
    }
    
    struct text {
        static let body = UIColor(hex: "4A4A68")
        static let subtle = UIColor(hex: "8C8CA1")
        static let correctionTinted = UIColor(hex: "54B948")
        static let errorTinted = UIColor(hex: "ff2626")
        static let buttonLink = UIColor.systemBlue
        static let active = UIColor.brand.secondary
    }
    
    struct action {
        static let destructive = UIColor(hex: "FF3B30")
        static let success = UIColor(hex: "34C759")
    }
    
    // Input
    struct textField {
        static let backgroundPrimary = UIColor(hex: "ebeff5")
    }
    
    // Voice Call
    struct VoiceCall {
        static let background = UIColor(hex: "#192B49")
        static let declineButton = UIColor(hex: "EE1F4B")
        static let button = UIColor(hex: "111C2D")
    }
    
    struct auth {
        static let google = UIColor(hex: "DB4437")
        static let apple = UIColor(hex: "2E3033")
        static let facebook = UIColor(hex: "3B5998")
    }
    struct optionCell {
//        static let correct = UIColor(hex: "98E59B")
//        static let wrong = UIColor(hex: "FFAAAA")
        static let correct = UIColor.systemGreen.withAlphaComponent(0.8)
        static let wrong = UIColor.systemRed.withAlphaComponent(0.8)
    }
    struct message {
        struct background {
            static let fromMe = UIColor(hex: "5B63B3")
            static let fromOther = UIColor.systemBackground
        }
        struct text {
            static let fromMe = UIColor.white
            static let fromOther = UIColor.label
        }
    }
}
