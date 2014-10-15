//
//  GeneralSettingsViewController.m
//  Telegram
//
//  Created by keepcoder on 13.10.14.
//  Copyright (c) 2014 keepcoder. All rights reserved.
//

#import "GeneralSettingsViewController.h"
#import "GeneralSettingsRowItem.h"
#import "GeneralSettingsRowView.h"
#import "GeneralSettingsBlockHeaderView.h"
@interface GeneralSettingsViewController () <TMTableViewDelegate,SettingsListener>
@property (nonatomic,strong) TMTextField *centerTextField;
@property (nonatomic,strong) TMBackButton *backButton;
@property (nonatomic,strong) TMTableView *tableView;
@end

@implementation GeneralSettingsViewController

-(void)loadView {
    [super loadView];
    
    _centerTextField = [TMTextField defaultTextField];
    [self.centerTextField setAlignment:NSCenterTextAlignment];
    [self.centerTextField setAutoresizingMask:NSViewWidthSizable];
    [self.centerTextField setFont:[NSFont fontWithName:@"HelveticaNeue" size:16]];
    [self.centerTextField setTextColor:NSColorFromRGB(0x222222)];
    [[self.centerTextField cell] setTruncatesLastVisibleLine:YES];
    [[self.centerTextField cell] setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.centerTextField setDrawsBackground:NO];
    
    [self.centerTextField setStringValue:NSLocalizedString(@"GeneralSettings.General", nil)];
    
    [self.centerTextField setFrameOrigin:NSMakePoint(self.centerTextField.frame.origin.x, -12)];
    
    self.centerNavigationBarView = (TMView *) self.centerTextField;
    
    _backButton = [[TMBackButton alloc] initWithFrame:NSZeroRect string:NSLocalizedString(@"Compose.Back", nil)];
    self.leftNavigationBarView = [[TMView alloc] initWithFrame:self.backButton.bounds];
    [self.leftNavigationBarView addSubview:self.backButton];
    
    
    self.tableView = [[TMTableView alloc] initWithFrame:self.view.bounds];
    
    self.tableView.tm_delegate = self;
    
    
    [self.view addSubview:self.tableView.containerView];
    
    
    
    //photo
    
    
    [SettingsArchiver addEventListener:self];
    
    
    
    GeneralSettingsBlockHeaderItem *autoPhotoHeader = [[GeneralSettingsBlockHeaderItem alloc] initWithObject:NSLocalizedString(@"GeneralSettings.AutoPhotoDownloadHeader", nil)];
    
    autoPhotoHeader.height = 61;
    
     [self.tableView insert:autoPhotoHeader atIndex:self.tableView.list.count tableRedraw:NO];
    
    
    
    GeneralSettingsRowItem *autoPhotoDownloadGroup = [[GeneralSettingsRowItem alloc] initWithType:SettingsRowItemTypeSwitch callback:^(GeneralSettingsRowItem *item) {
        
        [SettingsArchiver addOrRemoveSetting:AutoGroupPhoto];
        
    } description:NSLocalizedString(@"Settings.Groups", nil) height:44 stateback:^id(GeneralSettingsRowItem *item) {
        return @([SettingsArchiver checkMaskedSetting:AutoGroupPhoto]);
    }];
    
    [self.tableView insert:autoPhotoDownloadGroup atIndex:self.tableView.list.count tableRedraw:NO];
    
    
    GeneralSettingsRowItem *autoPhotoDownloadPrivate = [[GeneralSettingsRowItem alloc] initWithType:SettingsRowItemTypeSwitch callback:^(GeneralSettingsRowItem *item) {
        
        [SettingsArchiver addOrRemoveSetting:AutoPrivatePhoto];
        
    } description:NSLocalizedString(@"Settings.PrivateChats", nil) height:44 stateback:^id(GeneralSettingsRowItem *item) {
        return @([SettingsArchiver checkMaskedSetting:AutoPrivatePhoto]);
    }];
    
    [self.tableView insert:autoPhotoDownloadPrivate atIndex:self.tableView.list.count tableRedraw:NO];
    
    
    //photo end
    
    
    
    //audio
    
    GeneralSettingsBlockHeaderItem *autoAudioHeader = [[GeneralSettingsBlockHeaderItem alloc] initWithObject:NSLocalizedString(@"GeneralSettings.AutoAudioDownloadHeader", nil)];
    
     autoAudioHeader.height = 48;
    
    [self.tableView insert:autoAudioHeader atIndex:self.tableView.list.count tableRedraw:NO];
    
    
    
    
    GeneralSettingsRowItem *autoAudioDownloadGroup = [[GeneralSettingsRowItem alloc] initWithType:SettingsRowItemTypeSwitch callback:^(GeneralSettingsRowItem *item) {
        
        [SettingsArchiver addOrRemoveSetting:AutoGroupAudio];
        
    } description:NSLocalizedString(@"Settings.Groups", nil) height:40 stateback:^id(GeneralSettingsRowItem *item) {
        return @([SettingsArchiver checkMaskedSetting:AutoGroupAudio]);
    }];
    
    [self.tableView insert:autoAudioDownloadGroup atIndex:self.tableView.list.count tableRedraw:NO];
    
    
    GeneralSettingsRowItem *autoAudioDownloadPrivate = [[GeneralSettingsRowItem alloc] initWithType:SettingsRowItemTypeSwitch callback:^(GeneralSettingsRowItem *item) {
        
        [SettingsArchiver addOrRemoveSetting:AutoPrivateAudio];
        
    } description:NSLocalizedString(@"Settings.PrivateChats", nil) height:44 stateback:^id(GeneralSettingsRowItem *item) {
        return @([SettingsArchiver checkMaskedSetting:AutoPrivateAudio]);
    }];
    
    [self.tableView insert:autoAudioDownloadPrivate atIndex:self.tableView.list.count tableRedraw:NO];

    
    //audio end
    
    

    GeneralSettingsRowItem *soundNotification = [[GeneralSettingsRowItem alloc] initWithType:SettingsRowItemTypeChoice callback:^(GeneralSettingsRowItem *item) {
        
    } description:NSLocalizedString(@"Settings.SoundNotification", nil) height:80 stateback:^id(GeneralSettingsRowItem *item) {
        return NSLocalizedString([SettingsArchiver soundNotification], nil);
    }];
    
    [self.tableView insert:soundNotification atIndex:self.tableView.list.count tableRedraw:NO];
    
    
    
    GeneralSettingsRowItem *soundEffects = [[GeneralSettingsRowItem alloc] initWithType:SettingsRowItemTypeSwitch callback:^(GeneralSettingsRowItem *item) {
        
        [SettingsArchiver addOrRemoveSetting:SoundEffects];
        
    } description:NSLocalizedString(@"Settings.SoundEffects", nil) height:42 stateback:^id(GeneralSettingsRowItem *item) {
        return @([SettingsArchiver checkMaskedSetting:SoundEffects]);
    }];
    
    [self.tableView insert:soundEffects atIndex:self.tableView.list.count tableRedraw:NO];
    
    
    GeneralSettingsRowItem *securitySettings = [[GeneralSettingsRowItem alloc] initWithType:SettingsRowItemTypeNext callback:^(GeneralSettingsRowItem *item) {
        
        [[Telegram rightViewController] showSecuritySettings];
        
    } description:NSLocalizedString(@"Settings.SecuritySettings", nil) height:42 stateback:^id(GeneralSettingsRowItem *item) {
        return nil;
    }];
    
    [self.tableView insert:securitySettings atIndex:self.tableView.list.count tableRedraw:NO];
    
    
    
    GeneralSettingsRowItem *advancedSettings = [[GeneralSettingsRowItem alloc] initWithType:SettingsRowItemTypeNext callback:^(GeneralSettingsRowItem *item) {
        
        [[Telegram mainViewController].settingsWindowController showWindowWithAction:SettingsWindowActionChatSettings];
        
    } description:NSLocalizedString(@"Settings.AdvancedSettings", nil) height:42 stateback:^id(GeneralSettingsRowItem *item) {
        return nil;
    }];
    
    [self.tableView insert:advancedSettings atIndex:self.tableView.list.count tableRedraw:NO];
    
    
    
    [self.tableView reloadData];
    
}


-(void)didChangeSettingsMask:(SettingsMask)mask {
    [self.tableView reloadData];
}

- (CGFloat)rowHeight:(NSUInteger)row item:(GeneralSettingsRowItem *) item {
    return  item.height;
}

- (BOOL)isGroupRow:(NSUInteger)row item:(GeneralSettingsRowItem *) item {
    return NO;
}

- (TMRowView *)viewForRow:(NSUInteger)row item:(TMRowItem *) item {
    
    if([item isKindOfClass:[GeneralSettingsBlockHeaderItem class]]) {
        return [self.tableView cacheViewForClass:[GeneralSettingsBlockHeaderView class] identifier:@"GeneralSettingsBlockHeaderView"];
    }
    
    if([item isKindOfClass:[GeneralSettingsRowItem class]]) {
        return [self.tableView cacheViewForClass:[GeneralSettingsRowView class] identifier:@"GeneralSettingsRowViewClass"];
    }
    
    return nil;
    
}

- (void)selectionDidChange:(NSInteger)row item:(GeneralSettingsRowItem *) item {
    
}

- (BOOL)selectionWillChange:(NSInteger)row item:(GeneralSettingsRowItem *) item {
    return NO;
}

- (BOOL)isSelectable:(NSInteger)row item:(GeneralSettingsRowItem *) item {
    return NO;
}


@end