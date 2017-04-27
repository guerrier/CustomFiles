//
//  NCBrandColor.swift
//  Crypto Cloud Technology Nextcloud
//
//  Created by Marino Faggiana on 24/04/17.
//  Copyright (c) 2017 TWS. All rights reserved.
//
//  Author Marino Faggiana <m.faggiana@twsweb.it>
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

import UIKit

class NCBrandColor: NSObject {

    static let sharedInstance: NCBrandColor = {
        let instance = NCBrandColor()
        return instance
    }()

    // Color
    public var brand:                   UIColor = UIColor(red: 30.0/255.0, green: 39.0/255.0, blue: 81.0/255.0, alpha: 1.0)     // DARK BLU : #1E2751
    public let customer:                UIColor = UIColor(red: 30.0/255.0, green: 39.0/255.0, blue: 81.0/255.0, alpha: 1.0)     // DARK BLU : #1E2751

    public var connectionNo:            UIColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
    public var cryptocloud:             UIColor = UIColor(red: 241.0/255.0, green: 90.0/255.0, blue: 34.0/255.0, alpha: 1.0)
    public var navigationBarProgress:   UIColor = .white
    public var navigationBarText:       UIColor = .white
    public var menuBackground:          UIColor = .white
    public var moreNormal:              UIColor = .black
    public var moreSettings:            UIColor = .black
    public var seperator:               UIColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
    public var tabBar:                  UIColor = .white
    public var tableBackground:         UIColor = .white
    public var transferBackground:      UIColor = UIColor(red: 178.0/255.0, green: 244.0/255.0, blue: 258.0/255.0, alpha: 0.1)
    
    // Color modify
    public func getColorSelectBackgrond() -> UIColor {
        return self.brand.withAlphaComponent(0.1)
    }
}

class NCBrandImages: NSObject {

    static let sharedInstance: NCBrandImages = {
        let instance = NCBrandImages()
        return instance
    }()
    
    public var login:                   String = "Clarosync_loginLogo"
    public var navigationLogo:          String = "Clarosync_navigationLogo"
    public var navigationLogoOffline:   String = "Clarosync_navigationLogo"
    public var BackgroundDetail:        String = "Clarosync_backgroundDetail"
    public var themingBackground:       String = "Clarosync_themingBackground"
}

