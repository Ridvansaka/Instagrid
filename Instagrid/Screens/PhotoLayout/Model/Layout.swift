//
//  Layout.swift
//  Instagrid
//
//  Created by SAKA Ridvan on 20/12/2019.
//  Copyright © 2019 SAKA Ridvan. All rights reserved.
//

import Foundation
enum Layout: CaseIterable {
    case OneTopTwoBottom, TwoTopOneBottom, TwoTopTwoBottom
    
    func getTopNumber() -> Int {
        switch self {
        case .OneTopTwoBottom:
            return 1
        case .TwoTopOneBottom:
            return 2
        case .TwoTopTwoBottom:
            return 2
        }
    }
    func getBottomNumber() -> Int {
        switch self {
        case .OneTopTwoBottom:
            return 2
        case .TwoTopOneBottom:
            return 1
        case .TwoTopTwoBottom:
            return 2
        }
    }
}
