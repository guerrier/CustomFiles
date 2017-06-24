//
//  NCAutoUpload.m
//  Crypto Cloud Technology Nextcloud
//
//  Created by Marino Faggiana on 07/06/17.
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

#import "NCAutoUpload.h"
#import "AppDelegate.h"
#import "NCBridgeSwift.h"

#pragma GCC diagnostic ignored "-Wundeclared-selector"

@interface NCAutoUpload ()
{
    PHFetchResult *_assetsFetchResult;

    CCHud *_hud;
}
@end

@implementation NCAutoUpload

+ (NCAutoUpload *)sharedInstance {
    
    static NCAutoUpload *sharedInstance;
    
    @synchronized(self)
    {
        if (!sharedInstance) {
            
            sharedInstance = [NCAutoUpload new];
        }
        return sharedInstance;
    }
}

#pragma --------------------------------------------------------------------------------------------
#pragma mark ==== Photo Library Change Observer ====
#pragma --------------------------------------------------------------------------------------------

- (void)photoLibraryDidChange:(PHChange *)changeInfo
{
    /*
     PHFetchResultChangeDetails *collectionChanges = [changeInfo changeDetailsForFetchResult:self.assetsFetchResult];
     
     if (collectionChanges) {
     
     self.assetsFetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum | PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAny options:nil];
     
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
     [self uploadNewAssets];
     });
     }
     */
}

#pragma --------------------------------------------------------------------------------------------
#pragma mark === initStateAutoUpload ===
#pragma --------------------------------------------------------------------------------------------

- (void)initStateAutoUpload
{
    tableAccount *account = [[NCManageDatabase sharedInstance] getAccountActive];
    
    if (account.autoUpload) {
        
        [self setupAutoUpload];
        
        if (account.autoUploadBackground) {
         
            [self checkIfLocationIsEnabled];
        }
        
    } else {
                
        [PHPhotoLibrary.sharedPhotoLibrary unregisterChangeObserver:self];
        
        [[CCManageLocation sharedInstance] stopSignificantChangeUpdates];
    }
}

#pragma --------------------------------------------------------------------------------------------
#pragma mark === Camera Upload & Full ===
#pragma --------------------------------------------------------------------------------------------

- (void)setupAutoUpload
{
    if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusAuthorized) {
        
        _assetsFetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum | PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAny options:nil];
        
        [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:self];
        
        [self performSelectorOnMainThread:@selector(uploadNewAssets) withObject:nil waitUntilDone:NO];
        
    } else {
        
        tableAccount *account = [[NCManageDatabase sharedInstance] getAccountActive];

        if (account.autoUpload == YES)
            [[NCManageDatabase sharedInstance] setAccountAutoUploadFiled:@"autoUpload" state:NO];
        
        [PHPhotoLibrary.sharedPhotoLibrary unregisterChangeObserver:self];
        
        [[CCManageLocation sharedInstance] stopSignificantChangeUpdates];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"_access_photo_not_enabled_", nil) message:NSLocalizedString(@"_access_photo_not_enabled_msg_", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"_ok_", nil) otherButtonTitles:nil];
        [alert show];
    }
}

- (void)setupAutoUploadFull
{
    if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusAuthorized) {
        
        _assetsFetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum | PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAny options:nil];
        
        [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:self];
        
        [self performSelectorOnMainThread:@selector(uploadFullAssets) withObject:nil waitUntilDone:NO];
        
    } else {
        
        tableAccount *account = [[NCManageDatabase sharedInstance] getAccountActive];

        if (account.autoUpload == YES)
            [[NCManageDatabase sharedInstance] setAccountAutoUploadFiled:@"autoUpload" state:NO];
        
        [PHPhotoLibrary.sharedPhotoLibrary unregisterChangeObserver:self];
        
        [[CCManageLocation sharedInstance] stopSignificantChangeUpdates];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"_access_photo_not_enabled_", nil) message:NSLocalizedString(@"_access_photo_not_enabled_msg_", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"_ok_", nil) otherButtonTitles:nil];
        [alert show];
    }
}

#pragma --------------------------------------------------------------------------------------------
#pragma mark === Location ===
#pragma --------------------------------------------------------------------------------------------

- (BOOL)checkIfLocationIsEnabled
{
    tableAccount *account = [[NCManageDatabase sharedInstance] getAccountActive];
    
    [CCManageLocation sharedInstance].delegate = self;
    
    if ([CLLocationManager locationServicesEnabled]) {
        
        NSLog(@"[LOG] checkIfLocationIsEnabled : authorizationStatus: %d", [CLLocationManager authorizationStatus]);
        
        if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways) {
            
            if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined ) {
                
                NSLog(@"[LOG] checkIfLocationIsEnabled : Location services not determined");
                [[CCManageLocation sharedInstance] startSignificantChangeUpdates];
                
            } else {
                
                if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusAuthorized) {
                    
                    if (account.autoUploadBackground == YES)
                        [[NCManageDatabase sharedInstance] setAccountAutoUploadFiled:@"autoUploadBackground" state:NO];
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"_location_not_enabled_", nil) message:NSLocalizedString(@"_location_not_enabled_msg_", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"_ok_", nil) otherButtonTitles:nil];
                    [alert show];
                    
                } else {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"_access_photo_not_enabled_", nil) message:NSLocalizedString(@"_access_photo_not_enabled_msg_", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"_ok_", nil) otherButtonTitles:nil];
                    [alert show];
                }
            }
            
        } else {
            
            if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusAuthorized) {
                
                if (account.autoUploadBackground == NO)
                    [[NCManageDatabase sharedInstance] setAccountAutoUploadFiled:@"autoUploadBackground" state:YES];
                
                [[CCManageLocation sharedInstance] startSignificantChangeUpdates];
                
            } else {
                
                if (account.autoUploadBackground == YES)
                    [[NCManageDatabase sharedInstance] setAccountAutoUploadFiled:@"autoUploadBackground" state:NO];
                
                [[CCManageLocation sharedInstance] stopSignificantChangeUpdates];
                
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"_access_photo_not_enabled_", nil) message:NSLocalizedString(@"_access_photo_not_enabled_msg_", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"_ok_", nil) otherButtonTitles:nil];
                [alert show];
            }
        }
        
    } else {
        
        if (account.autoUploadBackground == YES)
            [[NCManageDatabase sharedInstance] setAccountAutoUploadFiled:@"autoUploadBackground" state:NO];
        
        [[CCManageLocation sharedInstance] stopSignificantChangeUpdates];
        
        if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusAuthorized) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"_location_not_enabled_", nil) message:NSLocalizedString(@"_location_not_enabled_msg_", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"_ok_", nil) otherButtonTitles:nil];
            [alert show];
            
        } else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"_access_photo_location_not_enabled_", nil) message:NSLocalizedString(@"_access_photo_location_not_enabled_msg_", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"_ok_", nil) otherButtonTitles:nil];
            [alert show];
        }
    }
    
    tableAccount *tableAccount = [[NCManageDatabase sharedInstance] getAccountActive];
    return tableAccount.autoUploadBackground;
}


- (void)statusAuthorizationLocationChanged
{
    tableAccount *account = [[NCManageDatabase sharedInstance] getAccountActive];
    
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusNotDetermined){
        
        if (![CCManageLocation sharedInstance].firstChangeAuthorizationDone) {
            
            ALAssetsLibrary *assetLibrary = [CCUtility defaultAssetsLibrary];
            
            [assetLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                                        usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                            
                                        } failureBlock:^(NSError *error) {
                                            
                                        }];
        }
        
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways) {
            
            if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusAuthorized) {
                
                if ([CCManageLocation sharedInstance].firstChangeAuthorizationDone) {
                    
                    if (account.autoUploadBackground == YES)
                        [[NCManageDatabase sharedInstance] setAccountAutoUploadFiled:@"autoUploadBackground" state:NO];
                    
                    [[CCManageLocation sharedInstance] stopSignificantChangeUpdates];
                }
                
            } else {
                
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"_access_photo_not_enabled_", nil) message:NSLocalizedString(@"_access_photo_not_enabled_msg_", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"_ok_", nil) otherButtonTitles:nil];
                [alert show];
            }
            
        } else if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusNotDetermined){
            
            if (account.autoUploadBackground == YES) {
                
                [[NCManageDatabase sharedInstance] setAccountAutoUploadFiled:@"autoUploadBackground" state:NO];
                
                [[CCManageLocation sharedInstance] stopSignificantChangeUpdates];
                
                if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusAuthorized) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"_location_not_enabled_", nil) message:NSLocalizedString(@"_location_not_enabled_msg_", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"_ok_", nil) otherButtonTitles:nil];
                    [alert show];
                    
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"_access_photo_location_not_enabled_", nil) message:NSLocalizedString(@"_access_photo_location_not_enabled_msg_", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"_ok_", nil) otherButtonTitles:nil];
                    [alert show];
                }
            }
        }
        
        if (![CCManageLocation sharedInstance].firstChangeAuthorizationDone) {
            
            [CCManageLocation sharedInstance].firstChangeAuthorizationDone = YES;
        }
    }
}

- (void)changedLocation
{
    // Only in background
    tableAccount *account = [[NCManageDatabase sharedInstance] getAccountActive];
    
    if (account.autoUpload && account.autoUploadBackground && [[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground) {
        
        if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusAuthorized) {
            
            //check location
            if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways) {
                
                NSLog(@"[LOG] Changed Location call uploadNewAssets");
                
                [self uploadNewAssets];
            }
            
        } else {
            
            if (account.autoUpload == YES)
                [[NCManageDatabase sharedInstance] setAccountAutoUploadFiled:@"autoUpload" state:NO];
            
            if (account.autoUploadBackground == YES)
                [[NCManageDatabase sharedInstance] setAccountAutoUploadFiled:@"autoUploadBackground" state:NO];
            
            [[CCManageLocation sharedInstance] stopSignificantChangeUpdates];
            [PHPhotoLibrary.sharedPhotoLibrary unregisterChangeObserver:self];
        }
    }
}

#pragma --------------------------------------------------------------------------------------------
#pragma mark ===== Upload Assets : NEW & FULL ====
#pragma --------------------------------------------------------------------------------------------

- (void)uploadNewAssets
{
    [self uploadAssetsNewAndFull:NO];
}

- (void)uploadFullAssets
{
    [self uploadAssetsNewAndFull:YES];
}

- (void)uploadAssetsNewAndFull:(BOOL)assetsFull
{
    PHFetchResult *newAssetToUpload;
    tableAccount *account = [[NCManageDatabase sharedInstance] getAccountActive];
    
    // ONLY FOR TEST
    //[self getCameraRollNewItemsWithDatePhotoTEST:[NSDate distantPast] dateVideo:[NSDate distantPast] account:account];
    
    // Check Asset : NEW or FULL
    if (assetsFull) {
        
        newAssetToUpload = [self getCameraRollNewItemsWithDatePhoto:[NSDate distantPast] dateVideo:[NSDate distantPast] account:account];
        
    } else {
        
        NSDate *databaseDatePhoto = account.autoUploadDatePhoto;
        NSDate *databaseDateVideo = account.autoUploadDateVideo;
        
        newAssetToUpload = [self getCameraRollNewItemsWithDatePhoto:databaseDatePhoto dateVideo:databaseDateVideo account:account];
    }
    
    // News Assets ? if no verify if blocked Table Auto Upload -> Autostart
    if ([newAssetToUpload count] == 0) {
        
        NSLog(@"[LOG] Auto upload, no new asset found for date image %@, date video %@", account.autoUploadDatePhoto, account.autoUploadDateVideo);
        return;
        
    } else {
        
        NSLog(@"[LOG] Auto upload, new %lu asset found for date image %@, date video %@", (unsigned long)[newAssetToUpload count], account.autoUploadDatePhoto, account.autoUploadDateVideo);
    }
    
    if (assetsFull) {
        
        if (!_hud)
            _hud = [[CCHud alloc] initWithView:[[[UIApplication sharedApplication] delegate] window]];
        
        [_hud visibleHudTitle:NSLocalizedString(@"_create_full_upload_", nil) mode:MBProgressHUDModeIndeterminate color:nil];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void) {
        
        if (assetsFull)
            [self performSelectorOnMainThread:@selector(uploadFullAssetsToNetwork:) withObject:newAssetToUpload waitUntilDone:NO];
        else
            [self performSelectorOnMainThread:@selector(uploadNewAssetsToNetwork:) withObject:newAssetToUpload waitUntilDone:NO];
    });
}

- (void)uploadNewAssetsToNetwork:(PHFetchResult *)newAssetToUpload
{
    [self uploadAssetsToNetwork:newAssetToUpload assetsFull:NO];
}

- (void)uploadFullAssetsToNetwork:(PHFetchResult *)newAssetToUpload
{
    [self uploadAssetsToNetwork:newAssetToUpload assetsFull:YES];
}

- (void)uploadAssetsToNetwork:(PHFetchResult *)newAssetToUpload assetsFull:(BOOL)assetsFull
{
    tableAccount *tableAccount = [[NCManageDatabase sharedInstance] getAccountActive];
    NSMutableArray *metadataNetFull = [NSMutableArray new];
  
    NSString *autoUploadPath = [[NCManageDatabase sharedInstance] getAccountAutoUploadPath:app.activeUrl];
    BOOL useSubFolder = tableAccount.autoUploadCreateSubfolder;
    
    // Create the folder for Photos & if request the subfolders
    if(![[NCAutoUpload sharedInstance] createFolderSubFolderAutoUploadFolderPhotos:autoUploadPath useSubFolder:useSubFolder assets:newAssetToUpload selector:selectorUploadAutoUploadAll]) {
        
        // end loading
        [_hud hideHud];
        
        return;
    }
    
    for (PHAsset *asset in newAssetToUpload) {
        
        NSString *serverUrl;
        NSDate *assetDate = asset.creationDate;
        PHAssetMediaType assetMediaType = asset.mediaType;
        NSString *session;
        NSString *fileName = [CCUtility createFileNameFromAsset:asset key:nil];
        
        // Select type of session
        
        if (assetMediaType == PHAssetMediaTypeImage && tableAccount.autoUploadWWAnPhoto == NO) session = k_upload_session;
        if (assetMediaType == PHAssetMediaTypeVideo && tableAccount.autoUploadWWAnVideo == NO) session = k_upload_session;
        if (assetMediaType == PHAssetMediaTypeImage && tableAccount.autoUploadWWAnPhoto) session = k_upload_session_wwan;
        if (assetMediaType == PHAssetMediaTypeVideo && tableAccount.autoUploadWWAnVideo) session = k_upload_session_wwan;
        
        NSDateFormatter *formatter = [NSDateFormatter new];
        
        [formatter setDateFormat:@"yyyy"];
        NSString *yearString = [formatter stringFromDate:assetDate];
        
        [formatter setDateFormat:@"MM"];
        NSString *monthString = [formatter stringFromDate:assetDate];
        
        if (useSubFolder)
            serverUrl = [NSString stringWithFormat:@"%@/%@/%@", autoUploadPath, yearString, monthString];
        else
            serverUrl = autoUploadPath;
        
        CCMetadataNet *metadataNet = [[CCMetadataNet alloc] initWithAccount:app.activeAccount];
        
        metadataNet.action = actionUploadAsset;
        metadataNet.assetLocalIdentifier = asset.localIdentifier;
        if (assetsFull) {
            metadataNet.selector = selectorUploadAutoUploadAll;
            
            // Option 
            if ([[NCBrandOptions sharedInstance] use_storeLocalAutoUploadAll] == true)
                metadataNet.selectorPost = nil;
            else
                metadataNet.selectorPost = selectorUploadRemovePhoto;
            
            metadataNet.priority = NSOperationQueuePriorityLow;
        } else {
            metadataNet.selector = selectorUploadAutoUpload;
            metadataNet.selectorPost = nil;
            metadataNet.priority = NSOperationQueuePriorityLow;
        }
        metadataNet.fileName = fileName;
        metadataNet.serverUrl = serverUrl;
        metadataNet.session = session;
        metadataNet.taskStatus = k_taskStatusResume;
        
        if (assetsFull) {
            [metadataNetFull addObject:metadataNet];
        } else {            
            NCRequestAsset *requestAsset = [NCRequestAsset new];
            requestAsset.delegate = self;
            
            [requestAsset writeAssetToSandboxFileName:metadataNet.fileName assetLocalIdentifier:metadataNet.assetLocalIdentifier selector:metadataNet.selector selectorPost:metadataNet.selectorPost errorCode:0 metadataNet:metadataNet serverUrl:serverUrl activeUrl:app.activeUrl directoryUser:app.directoryUser cryptated:NO session:metadataNet.session taskStatus:0 delegate:nil];
        }
    }
    
    // Insert all assets (Full) in TableAutoUpload
    if (assetsFull && [metadataNetFull count] > 0) {
        
        [[NCManageDatabase sharedInstance] addAutoUploadWithMetadatasNet:metadataNetFull];
          
        // Update icon badge number
        [app updateApplicationIconBadgeNumber];
    }
    
    // end loading
    [_hud hideHud];
}

- (void)addDatabaseAutoUpload:(CCMetadataNet *)metadataNet modificationDate:(NSDate *)modificationDate assetMediaType:(PHAssetMediaType)assetMediaType
{
    if ([[NCManageDatabase sharedInstance] addAutoUploadWithMetadataNet:metadataNet]) {
        
        [[NCManageDatabase sharedInstance] addActivityClient:metadataNet.fileName fileID:metadataNet.assetLocalIdentifier action:k_activityDebugActionAutoUpload selector:metadataNet.selector note:[NSString stringWithFormat:@"Add Auto Upload, Asset Data: %@", [NSDateFormatter localizedStringFromDate:modificationDate dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle]] type:k_activityTypeInfo verbose:k_activityVerboseHigh activeUrl:app.activeUrl];
        
    } else {
        
        [[NCManageDatabase sharedInstance] addActivityClient:metadataNet.fileName fileID:metadataNet.assetLocalIdentifier action:k_activityDebugActionAutoUpload selector:metadataNet.selector note:[NSString stringWithFormat:@"Add Auto Upload [File already present in Table autoUpload], Asset Data: %@", [NSDateFormatter localizedStringFromDate:modificationDate dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle]] type:k_activityTypeInfo verbose:k_activityVerboseHigh activeUrl:app.activeUrl];
    }
    
    // Update Camera Auto Upload data
    if ([metadataNet.selector isEqualToString:selectorUploadAutoUpload])
        [[NCManageDatabase sharedInstance] setAccountAutoUploadDateAssetType:assetMediaType assetDate:modificationDate];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // Update icon badge number
        [app updateApplicationIconBadgeNumber];
    });
}

#pragma --------------------------------------------------------------------------------------------
#pragma mark ===== Load Auto Upload ====
#pragma --------------------------------------------------------------------------------------------

- (void)loadAutoUpload:(NSNumber *)maxConcurrent
{
    CCMetadataNet *metadataNet;
    PHFetchResult *result;
    
    // Stop Timer
    [app.timerProcessAutoUpload invalidate];
    
    NSInteger maxConcurrentUpload = [maxConcurrent integerValue];
    NSInteger counterUploadInQueueAndInLock = [app getNumberUploadInQueues] + [app getNumberUploadInQueuesWWan] + [[[NCManageDatabase sharedInstance] getLockAutoUpload] count];
    NSInteger counterNewUpload = 0;
 
    // ------------------------- <selector Auto Upload> -------------------------
    
    while (counterUploadInQueueAndInLock < maxConcurrentUpload) {
        
        metadataNet = [[NCManageDatabase sharedInstance] getAutoUploadWithSelector:selectorUploadAutoUpload];
        if (metadataNet) {
            
            result = [PHAsset fetchAssetsWithLocalIdentifiers:@[metadataNet.assetLocalIdentifier] options:nil];
            
        } else
            break;
        
        if (result.count > 0) {
            
            [[CCNetworking sharedNetworking] uploadFileFromAssetLocalIdentifier:metadataNet.assetLocalIdentifier fileName:metadataNet.fileName serverUrl:metadataNet.serverUrl cryptated:metadataNet.cryptated session:metadataNet.session taskStatus:metadataNet.taskStatus selector:metadataNet.selector selectorPost:metadataNet.selectorPost errorCode:metadataNet.errorCode delegate:app.activeMain];
            
            counterNewUpload++;
            
        } else {
            
            [[NCManageDatabase sharedInstance] addActivityClient:metadataNet.fileName fileID:metadataNet.assetLocalIdentifier action:k_activityDebugActionUpload selector:selectorUploadAutoUploadAll note:@"Internal error image/video not found [0]" type:k_activityTypeFailure verbose:k_activityVerboseHigh activeUrl:app.activeUrl];
            
            [[NCManageDatabase sharedInstance] deleteAutoUploadWithAssetLocalIdentifier:metadataNet.assetLocalIdentifier];
        }
        
        counterUploadInQueueAndInLock = [app getNumberUploadInQueues] + [app getNumberUploadInQueuesWWan] + [[[NCManageDatabase sharedInstance] getLockAutoUpload] count];
    }
    
    // ------------------------- <selector Auto Upload All> ----------------------
    
    // Verify num error MAX 10 after STOP
    NSArray *metadatas = [[NCManageDatabase sharedInstance] getMetadatasWithPredicate:[NSPredicate predicateWithFormat:@"account = %@ AND sessionSelector = %@ AND (sessionTaskIdentifier = %i OR sessionTaskIdentifierPlist = %i)", app.activeAccount, selectorUploadAutoUploadAll, k_taskIdentifierError, k_taskIdentifierError] sorted:nil ascending:NO];
    
    NSInteger errorCount = [metadatas count];
    
    if (errorCount >= 10) {
        
        [app messageNotification:@"_error_" description:@"_too_errors_automatic_all_" visible:YES delay:k_dismissAfterSecond type:TWMessageBarMessageTypeError errorCode:0];
    
    } else {
    
        while (counterUploadInQueueAndInLock < maxConcurrentUpload) {
        
            metadataNet =  [[NCManageDatabase sharedInstance] getAutoUploadWithSelector:selectorUploadAutoUploadAll];
            if (metadataNet) {
                
                result = [PHAsset fetchAssetsWithLocalIdentifiers:@[metadataNet.assetLocalIdentifier] options:nil];
        
            } else
                break;
            
            if (result.count > 0) {
            
                [[CCNetworking sharedNetworking] uploadFileFromAssetLocalIdentifier:metadataNet.assetLocalIdentifier fileName:metadataNet.fileName serverUrl:metadataNet.serverUrl cryptated:metadataNet.cryptated session:metadataNet.session taskStatus:metadataNet.taskStatus selector:metadataNet.selector selectorPost:metadataNet.selectorPost errorCode:metadataNet.errorCode delegate:app.activeMain];
            
                counterNewUpload++;
                            
            } else {
            
                [[NCManageDatabase sharedInstance] addActivityClient:metadataNet.fileName fileID:metadataNet.assetLocalIdentifier action:k_activityDebugActionUpload selector:selectorUploadAutoUploadAll note:@"Internal error image/video not found [0]" type:k_activityTypeFailure verbose:k_activityVerboseHigh activeUrl:app.activeUrl];
            
                [[NCManageDatabase sharedInstance] deleteAutoUploadWithAssetLocalIdentifier:metadataNet.assetLocalIdentifier];
            }
        
            counterUploadInQueueAndInLock = [app getNumberUploadInQueues] + [app getNumberUploadInQueuesWWan] + [[[NCManageDatabase sharedInstance] getLockAutoUpload] count];
        }
    }
    
    // Verify Lock
    NSInteger counterUploadInQueue = [app getNumberUploadInQueues] + [app getNumberUploadInQueuesWWan];
    NSArray *tableMetadatasInLock = [[NCManageDatabase sharedInstance] getLockAutoUpload];

    if (counterNewUpload == 0 && counterUploadInQueue == 0 && [tableMetadatasInLock count] > 0) {
        
        // Unlock
        for (tableMetadata *metadata in tableMetadatasInLock) {
            
            if ([[NCManageDatabase sharedInstance] isTableInvalidated:metadata] == NO)
                [[NCManageDatabase sharedInstance] unlockAutoUploadWithAssetLocalIdentifier:metadata.assetLocalIdentifier];
        }
    }
    
    // Start Timer
    app.timerProcessAutoUpload = [NSTimer scheduledTimerWithTimeInterval:k_timerProcessAutoUpload target:app selector:@selector(processAutoUpload) userInfo:nil repeats:YES];
}

#pragma --------------------------------------------------------------------------------------------
#pragma mark ===== Create Folder SubFolder Auto Upload Folder Photos ====
#pragma --------------------------------------------------------------------------------------------

- (BOOL)createFolderSubFolderAutoUploadFolderPhotos:(NSString *)folderPhotos useSubFolder:(BOOL)useSubFolder assets:(PHFetchResult *)assets selector:(NSString *)selector
{
    OCnetworking *ocNetworking = [[OCnetworking alloc] initWithDelegate:nil metadataNet:nil withUser:app.activeUser withPassword:app.activePassword withUrl:app.activeUrl isCryptoCloudMode:NO];
    
    if ([ocNetworking automaticCreateFolderSync:folderPhotos]) {
        
        (void)[[NCManageDatabase sharedInstance] addDirectoryWithServerUrl:folderPhotos permissions:@""];
        
    } else {
        
        // Activity
        [[NCManageDatabase sharedInstance] addActivityClient:folderPhotos fileID:@"" action:k_activityDebugActionAutoUpload selector:selector note:NSLocalizedStringFromTable(@"_not_possible_create_folder_", @"Error", nil) type:k_activityTypeFailure verbose:k_activityVerboseDefault activeUrl:app.activeUrl];
        
        [app messageNotification:@"_error_" description:@"_error_createsubfolders_upload_" visible:YES delay:k_dismissAfterSecond type:TWMessageBarMessageTypeError errorCode:0];

        return false;
    }
    
    // Create if request the subfolders
    if (useSubFolder) {
        
        for (NSString *dateSubFolder in [CCUtility createNameSubFolder:assets]) {
            
            if ([ocNetworking automaticCreateFolderSync:[NSString stringWithFormat:@"%@/%@", folderPhotos, dateSubFolder]]) {
                
                (void)[[NCManageDatabase sharedInstance] addDirectoryWithServerUrl:[NSString stringWithFormat:@"%@/%@", folderPhotos, dateSubFolder] permissions:@""];
                
            } else {
                
                // Activity
                [[NCManageDatabase sharedInstance] addActivityClient:[NSString stringWithFormat:@"%@/%@", folderPhotos, dateSubFolder] fileID:@"" action:k_activityDebugActionAutoUpload selector:selector note:NSLocalizedString(@"_error_createsubfolders_upload_",nil) type:k_activityTypeFailure verbose:k_activityVerboseDefault activeUrl:app.activeUrl];
                
                [app messageNotification:@"_error_" description:@"_error_createsubfolders_upload_" visible:YES delay:k_dismissAfterSecond type:TWMessageBarMessageTypeError errorCode:0];

                return false;
            }
        }
    }
    
    return true;
}

#pragma --------------------------------------------------------------------------------------------
#pragma mark ===== get Camera Roll new Asset ====
#pragma --------------------------------------------------------------------------------------------

- (PHFetchResult *)getCameraRollNewItemsWithDatePhotoOLD:(NSDate *)datePhoto dateVideo:(NSDate *)dateVideo account:(tableAccount *)account
{
    @synchronized(self) {
 
        if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized) {
            
            PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
                    
            NSPredicate *predicateImage = [NSCompoundPredicate andPredicateWithSubpredicates:@[[NSPredicate predicateWithFormat:@"mediaType = %i", PHAssetMediaTypeImage], [NSPredicate predicateWithFormat:@"creationDate > %@", datePhoto]]];
            
            NSPredicate *predicateVideo = [NSCompoundPredicate andPredicateWithSubpredicates:@[[NSPredicate predicateWithFormat:@"mediaType = %i", PHAssetMediaTypeVideo], [NSPredicate predicateWithFormat:@"creationDate > %@", dateVideo]]];
                    
            NSPredicate *predicate;
            
            if (account.autoUploadPhoto && account.autoUploadVideo) {
                
                predicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[predicateImage, predicateVideo]];
                
            } else if (account.autoUploadPhoto) {
                
                predicate = predicateImage;
                
            } else if (account.autoUploadVideo) {
                
                predicate = predicateVideo;
            }
                    
            PHFetchOptions *newInstantUploadAssetsFetchOptions = [PHFetchOptions new];
            newInstantUploadAssetsFetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
            newInstantUploadAssetsFetchOptions.predicate = predicate;
            
            PHAssetCollection *collection = result[0];
            
            PHFetchResult *newAssetToUpload = [PHAsset fetchAssetsInAssetCollection:collection options:newInstantUploadAssetsFetchOptions];
            
            return newAssetToUpload;
            
        } else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"_access_photo_not_enabled_", nil) message:NSLocalizedString(@"_access_photo_not_enabled_msg_", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"_ok_", nil) otherButtonTitles:nil];
            [alert show];
        }
    }
    
    return nil;
}

- (PHFetchResult *)getCameraRollNewItemsWithDatePhoto:(NSDate *)datePhoto dateVideo:(NSDate *)dateVideo account:(tableAccount *)account
{
    @synchronized(self) {
        
        if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized) {
            
            PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
            
            NSPredicate *predicateImage = [NSCompoundPredicate andPredicateWithSubpredicates:@[[NSPredicate predicateWithFormat:@"mediaType = %i", PHAssetMediaTypeImage], [NSPredicate predicateWithFormat:@"modificationDate > %@", datePhoto]]];
            NSPredicate *predicateVideo = [NSCompoundPredicate andPredicateWithSubpredicates:@[[NSPredicate predicateWithFormat:@"mediaType = %i", PHAssetMediaTypeVideo], [NSPredicate predicateWithFormat:@"modificationDate > %@", dateVideo]]];
            
            NSPredicate *predicate;
            
            if (account.autoUploadPhoto && account.autoUploadVideo) {
                
                predicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[predicateImage, predicateVideo]];
                
            } else if (account.autoUploadPhoto) {
                
                predicate = predicateImage;
                
            } else if (account.autoUploadVideo) {
                
                predicate = predicateVideo;
            }
            
            PHFetchOptions *newInstantUploadAssetsFetchOptions = [PHFetchOptions new];
            newInstantUploadAssetsFetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"modificationDate" ascending:YES]];
            newInstantUploadAssetsFetchOptions.predicate = predicate;
            
            PHAssetCollection *collection = result[0];
            
            PHFetchResult *newAssetToUpload = [PHAsset fetchAssetsInAssetCollection:collection options:newInstantUploadAssetsFetchOptions];

#ifdef DEBUG
            for (PHAsset *asset in newAssetToUpload)
                NSLog(@"%@ > %@ - %@", asset.modificationDate, datePhoto, asset);
#endif
            
            return newAssetToUpload;
            
        } else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"_access_photo_not_enabled_", nil) message:NSLocalizedString(@"_access_photo_not_enabled_msg_", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"_ok_", nil) otherButtonTitles:nil];
            [alert show];
        }
    }
    
    return nil;
}

@end
