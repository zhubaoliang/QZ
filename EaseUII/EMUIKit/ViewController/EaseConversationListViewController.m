/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import "EaseConversationListViewController.h"
#import "DetileView.h"
#import "EaseEmotionEscape.h"
#import "EaseConversationCell.h"
#import "EaseConvertToCommonEmoticonsHelper.h"
#import "EaseMessageViewController.h"
#import "NSDate+Category.h"
#import "EaseLocalDefine.h"

@interface EaseConversationListViewController ()
{
    dispatch_queue_t refreshQueue;
}

@end

@implementation EaseConversationListViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self registerNotifications];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self unregisterNotifications];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showRefreshHeader = true;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
   
    
    
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [EaseConversationCell cellIdentifierWithModel:nil];
    EaseConversationCell *cell = (EaseConversationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        // Configure the cell...
    if (cell == nil) {
        cell = [[EaseConversationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if ([self.dataArray count] <= indexPath.row) {
        return cell;
    }
    
    id<IConversationModel> model = [self.dataArray objectAtIndex:indexPath.row];
    cell.model = model;
    
    if (_dataSource && [_dataSource respondsToSelector:@selector(conversationListViewController:latestMessageTitleForConversationModel:)]) {
        cell.detailLabel.attributedText =  [[EaseEmotionEscape sharedInstance] attStringFromTextForChatting:[_dataSource conversationListViewController:self latestMessageTitleForConversationModel:model] textFont:cell.detailLabel.font];
    } else {
        cell.detailLabel.attributedText =  [[EaseEmotionEscape sharedInstance] attStringFromTextForChatting:[self _latestMessageTitleForConversationModel:model]textFont:cell.detailLabel.font];
    }
    
    if (_dataSource && [_dataSource respondsToSelector:@selector(conversationListViewController:latestMessageTimeForConversationModel:)]) {
        cell.timeLabel.text = [_dataSource conversationListViewController:self latestMessageTimeForConversationModel:model];
    } else {
        cell.timeLabel.text = [self _latestMessageTimeForConversationModel:model];
    }
    // 以下为人为修正非官方
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [EaseConversationCell cellHeightWithModel:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //非官方
    if(indexPath.row > self.dataArray.count)
    {
        DetileView *Devc = [[DetileView alloc]init];
        Devc.From = ((EaseConversationCell *)[self.tableView cellForRowAtIndexPath:indexPath]).detailLabel.text;
        [self.navigationController pushViewController:Devc animated:YES];
    }
    else{
    if (_delegate && [_delegate respondsToSelector:@selector(conversationListViewController:didSelectConversationModel:)]) {
        EaseConversationModel *model = [self.dataArray objectAtIndex:indexPath.row];
        [_delegate conversationListViewController:self didSelectConversationModel:model];
    } else {
        EaseConversationModel *model = [self.dataArray objectAtIndex:indexPath.row];
        EaseMessageViewController *viewController = [[EaseMessageViewController alloc] initWithConversationChatter:model.conversation.conversationId conversationType:model.conversation.type];
        viewController.title = model.title;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EaseConversationModel *model = [self.dataArray objectAtIndex:indexPath.row];
        [[EMClient sharedClient].chatManager deleteConversation:model.conversation.conversationId deleteMessages:YES];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - data

-(void)refreshAndSortView
{
    __weak typeof(self) weakself = self;
    if (!refreshQueue) {
        refreshQueue = dispatch_queue_create("com.easemob.conversation.refresh", DISPATCH_QUEUE_SERIAL);
    }
    dispatch_async(refreshQueue, ^{
        if ([weakself.dataArray count] > 1) {
            if ([[weakself.dataArray objectAtIndex:0] isKindOfClass:[EaseConversationModel class]]) {
                NSArray* sorted = [weakself.dataArray sortedArrayUsingComparator:
                                   ^(EaseConversationModel *obj1, EaseConversationModel* obj2){
                                       EMMessage *message1 = [obj1.conversation latestMessage];
                                       EMMessage *message2 = [obj2.conversation latestMessage];
                                       if(message1.timestamp > message2.timestamp) {
                                           return(NSComparisonResult)NSOrderedAscending;
                                       }else {
                                           return(NSComparisonResult)NSOrderedDescending;
                                       }
                                   }];
                [weakself.dataArray removeAllObjects];
                [weakself.dataArray addObjectsFromArray:sorted];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself.tableView reloadData];
        });
    });
}

- (void)tableViewDidTriggerHeaderRefresh
{
    __weak typeof(self) weakself = self;
    if (!refreshQueue) {
        refreshQueue = dispatch_queue_create("com.easemob.conversation.refresh", DISPATCH_QUEUE_SERIAL);
    }
    dispatch_async(refreshQueue, ^{
        NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
        NSArray* sorted = [conversations sortedArrayUsingComparator:
                           ^(EMConversation *obj1, EMConversation* obj2){
                               EMMessage *message1 = [obj1 latestMessage];
                               EMMessage *message2 = [obj2 latestMessage];
                               if(message1.timestamp > message2.timestamp) {
                                   return(NSComparisonResult)NSOrderedAscending;
                               }else {
                                   return(NSComparisonResult)NSOrderedDescending;
                               }
                           }];
        
        
        
        [weakself.dataArray removeAllObjects];
        for (EMConversation *converstion in sorted) {
            EaseConversationModel *model = nil;
            if (weakself.dataSource && [weakself.dataSource respondsToSelector:@selector(conversationListViewController:modelForConversation:)]) {
                model = [weakself.dataSource conversationListViewController:weakself
                                               modelForConversation:converstion];
            }
            else{
                model = [[EaseConversationModel alloc] initWithConversation:converstion];
            }
            
            if (model) {
                [weakself.dataArray addObject:model];
            }
        }
        
        [weakself tableViewDidFinishTriggerHeader:YES reload:YES];
    });
}

#pragma mark - EMGroupManagerDelegate

- (void)didUpdateGroupList:(NSArray *)groupList
{
    [self tableViewDidTriggerHeaderRefresh];
}

#pragma mark - registerNotifications
-(void)registerNotifications{
    [self unregisterNotifications];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].groupManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications{
    [[EMClient sharedClient].chatManager removeDelegate:self];
    [[EMClient sharedClient].groupManager removeDelegate:self];
}

- (void)dealloc{
    [self unregisterNotifications];
}

#pragma mark - private
- (NSString *)_latestMessageTitleForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTitle = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];
    if (lastMessage) {
        EMMessageBody *messageBody = lastMessage.body;
        switch (messageBody.type) {
            case EMMessageBodyTypeImage:{
                latestMessageTitle = NSEaseLocalizedString(@"message.image1", @"[image]");
            } break;
            case EMMessageBodyTypeText:{
                NSString *didReceiveText = [EaseConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                latestMessageTitle = didReceiveText;
            } break;
            case EMMessageBodyTypeVoice:{
                latestMessageTitle = NSEaseLocalizedString(@"message.voice1", @"[voice]");
            } break;
            case EMMessageBodyTypeLocation: {
                latestMessageTitle = NSEaseLocalizedString(@"message.location1", @"[location]");
            } break;
            case EMMessageBodyTypeVideo: {
                latestMessageTitle = NSEaseLocalizedString(@"message.video1", @"[video]");
            } break;
            case EMMessageBodyTypeFile: {
                latestMessageTitle = NSEaseLocalizedString(@"message.file1", @"[file]");
            } break;
            default: {
            } break;
        }
    }
    return latestMessageTitle;
}

- (NSString *)_latestMessageTimeForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTime = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];;
    if (lastMessage) {
        double timeInterval = lastMessage.timestamp ;
        if(timeInterval > 140000000000) {
            timeInterval = timeInterval / 1000;
        }
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        latestMessageTime = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
    }
    return latestMessageTime;
}

@end
