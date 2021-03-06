//
//  NCBrand.swift
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
    public let customer:                UIColor = UIColor(red: 30.0/255.0, green: 39.0/255.0, blue: 81.0/255.0, alpha: 1.0)     // DARK BLU : #1E2751

    public var brand:                   UIColor
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
    
    override init() {        
        self.brand = self.customer
    }
    
    // Color modify
    public func getColorSelectBackgrond() -> UIColor {
        return self.brand.withAlphaComponent(0.1)
    }
}

class NCBrandOptions: NSObject {
    
    static let sharedInstance: NCBrandOptions = {
        let instance = NCBrandOptions()
        return instance
    }()
    
    public let brand:                           String = "ClaroBox"
    public let mailMe:                          String = "info@clarobox.com"
    public let textCopyrightNextcloudiOS:       String = "ClaroBox for iOS %@ © 2017 T.W.S. Inc."
    public let textCopyrightNextcloudServer:    String = "ClaroBox Server %@"
    public let loginBaseUrl:                    String = "https://www.clarodrive.com"
    public let loginBaseUrlMultiDomains:        [String] = ["domain.com", "domain.it"]
    public let pushNotificationServer:          String = "https://push-notifications.nextcloud.com"
    public let linkLoginProvider:               String = "https://nextcloud.com/providers"
    public let textLoginProvider:               String = "_login_bottom_label_"
    public let middlewarePingUrl:               String = "https://35.163.169.207/ocs/v2.php/apps/amx_ping_middleware/api/v1/ping"
    public let webLoginAutenticationProtocol:   String = "amx://"
    public let webCloseViewProtocol:            String = "amx://change/plan"
    public let folderBrandAutoUpload:           String = NSLocalizedString("_auto_upload_folder_", comment: "")
    
    // Auto Upload default folder
    public var folderDefaultAutoUpload:         String = "Photos"
    
    // Capabilities Group
    public let capabilitiesGroups:              String = "group.it.twsweb.ClaroBox"
    
    // Options
    public let use_login_web:                   Bool = true
    public let use_firebase:                    Bool = true
    public let use_default_auto_upload:         Bool = true
    public let use_themingColor:                Bool = false
    public let use_themingBackground:           Bool = false
    public let use_multiDomains:                Bool = false
    public let use_middlewarePing:              Bool = true
    public let use_storeLocalAutoUploadAll:     Bool = false

    public let disable_intro:                   Bool = true
    public let disable_linkLoginProvider:       Bool = true
    public let disable_request_login_url:       Bool = false
    public let disable_multiaccount:            Bool = true
    public let disable_cryptocloudsystem:       Bool = true
    public let disable_manage_account:          Bool = true
    
    override init() {
        
        if folderBrandAutoUpload != "" {
            
            self.folderDefaultAutoUpload = self.folderBrandAutoUpload
        }
    }
}

