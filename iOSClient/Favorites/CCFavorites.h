//
//  CCFavorites.h
//  Crypto Cloud Technology Nextcloud
//
//  Created by Marino Faggiana on 16/01/17.
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

#import <UIKit/UIKit.h>

#import "CCDetail.h"
#import "UIScrollView+EmptyDataSet.h"
#import "TWMessageBarManager.h"
#import "AHKActionSheet.h"
#import "CCFavoritesCell.h"
#import "CCUtility.h"
#import "CCCoreData.h"
#import "CCMain.h"
#import "CCGraphics.h"
#import "CCAccountWeb.h"
#import "CCBancomat.h"
#import "CCCartaDiCredito.h"
#import "CCCartaIdentita.h"
#import "CCContoCorrente.h"
#import "CCNote.h"
#import "CCPassaporto.h"
#import "CCPatenteGuida.h"

@interface CCFavorites : UIViewController <UITableViewDataSource, UITableViewDelegate, UIDocumentInteractionControllerDelegate, UIActionSheetDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, CCAccountWebDelegate, CCBancomatDelegate, CCCartaDiCreditoDelegate, CCCartaIdentitaDelegate, CCContoCorrenteDelegate, CCNoteDelegate, CCPassaportoDelegate, CCPatenteGuidaDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) CCMetadata *metadata;
@property (nonatomic, strong) NSString *serverUrl;
@property (nonatomic, strong) NSString *titleViewControl;

@property (nonatomic, weak) CCDetail *detailViewController;
@property (nonatomic, strong) UIDocumentInteractionController *docController;

@end
