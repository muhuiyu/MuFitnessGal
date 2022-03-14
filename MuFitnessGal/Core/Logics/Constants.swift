//
//  Constants.swift
//  Lango
//
//  Created by Mu Yu on 8/1/21.
//

import UIKit

struct Constants {
    static let cornerRadius: CGFloat = 8
    static let paddingToTop: CGFloat = 16
    static let textSpacingSmall: CGFloat = 4
    
    static let horizonalPadding: CGFloat = 8
    static let horizonalPaddingLarge: CGFloat = 8
    
    struct video {
        static let height: CGFloat = 240
    }
    struct message {
        static let cornerRadius: CGFloat = 16
    }
    struct textButton {
        static let cornerRadius: CGFloat = 16
        static let cornerRadiusLarge: CGFloat = 24
        struct height {
            static let medium: CGFloat = 44
            static let large: CGFloat = 60
            static let small: CGFloat = 32
        }
    }
    struct headerHeight {
        static let withLargeTitle: CGFloat = 100
    }
    struct card {
        static let cornerRadius: CGFloat = 8
        struct size {
            static let small: CGFloat = 120
            static let medium: CGFloat = 200
            static let large: CGFloat = 300
        }
    }
    struct grid {
        static let cornerRadius: CGFloat = 8
        static let inset: CGFloat = Constants.spacing.medium
        struct size {
            static let small: CGFloat = 60
            static let medium: CGFloat = 120
            static let large: CGFloat = 180
            static let enormous: CGFloat = 240
        }
    }
    struct avatarImageSize {
        static let enormous: CGFloat = 96
        static let large: CGFloat = 44
        static let medium: CGFloat = 32
        static let small: CGFloat = 24
    }
    
    struct iconButtonSize {
        static let superb: CGFloat = 80
        static let enormous: CGFloat = 60
        static let large: CGFloat = 44
        static let medium: CGFloat = 32
        static let small: CGFloat = 24
        static let trivial: CGFloat = 20
        static let slight: CGFloat = 12
    }
    struct chipView {
        static let cornerRadius: CGFloat = 16
        static let iconPadding: CGFloat = 4
    }
    struct spacing {
        static let enormous: CGFloat = 36
        static let large: CGFloat = 24
        static let medium: CGFloat = 16
        static let small: CGFloat = 8
        static let trivial: CGFloat = 4
        static let slight: CGFloat = 2
    }
    struct progressBar {
        static let height: CGFloat = 8
        static let cornerRadius: CGFloat = 4
    }
    
    struct deckCell {
        static let height: CGFloat = 120
    }
    
    struct settingsPage {
        static let userAvatarHeaderHeight: CGFloat = 200
    }
    
    struct imageSize {
        static let cover: CGFloat = 250
        static let illustation: CGFloat = 200
        static let header: CGFloat = 150
        static let thumbnail: CGFloat = 44
        static let cellBackground: CGFloat = 64
        static let fitScreen: CGFloat = 375
        static let sessionQuizFlagHeight: CGFloat = 200
    }
    struct textField {
        static let cornerRaduis: CGFloat = 8
        static let height: CGFloat = 44
    }
    struct collectionCell {
        static let enormous: CGFloat = 120
    }
    struct slider {
        static let labelWidth: CGFloat = 100
    }
}
