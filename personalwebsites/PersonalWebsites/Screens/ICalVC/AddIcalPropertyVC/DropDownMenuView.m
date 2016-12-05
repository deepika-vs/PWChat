//
//  DropDownMenuView.m
//  PersonalWebsites
//
//  Created by vectoscalar on 17/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "DropDownMenuView.h"
#import "DropDownCell.h"

#define kDropDownCell @"DropDownCell"

#define kCellEstimatedHeight 44
#define kMaxHeight 150

@implementation DropDownMenuView
@synthesize delegate;


- (id)initWithFrame:(CGRect)frame andListViewFrame:(CGRect)listViewFrame andMenuList:(NSArray *)menuArray
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        menuList = [NSArray arrayWithArray:menuArray];
        [self configureUIWithFrame:frame andListViewFrame:listViewFrame andMenuList:menuArray];
        
    }
    return  self;
}



- (void)configureUIWithFrame:(CGRect)frame andListViewFrame:(CGRect)listViewFrame andMenuList:(NSArray *)menuArray
{
    mainView = [[UIView alloc] initWithFrame:frame];
    mainView.backgroundColor = [UIColor clearColor];
    
    blurView = [[UIView alloc] initWithFrame:frame];
    
    
    [mainView addSubview:blurView];
    [UIView animateWithDuration:0.2 animations:^{
        blurView.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.2];
    }];
    
    
    tblView = [[UITableView alloc] initWithFrame:CGRectMake(listViewFrame.origin.x,listViewFrame.origin.y+listViewFrame.size.height,listViewFrame.size.width,0)];
    tblView.backgroundColor = [UIColor whiteColor];
    tblView.delegate = self;
    tblView.dataSource = self;
    tblView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    tblView.rowHeight = UITableViewAutomaticDimension;
    tblView.estimatedRowHeight  = kCellEstimatedHeight;
    
    tblView.layer.cornerRadius = 4.0f;
    
    UINib *nib = [UINib nibWithNibName:kDropDownCell bundle:nil];
    [tblView registerNib:nib forCellReuseIdentifier:kDropDownCell];
    
    
    [mainView addSubview:tblView];
    
    
    [UIView animateWithDuration:.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        CGFloat height = ([menuArray count]*kCellEstimatedHeight);
        
        if(height > kMaxHeight)
            height  = kMaxHeight;
        
        
        tblView.frame = CGRectMake(listViewFrame.origin.x,listViewFrame.origin.y+listViewFrame.size.height,listViewFrame.size.width,height);
        
    } completion:^(BOOL finished) {
        
    }];
    
    [self addSubview:mainView];
    
    [self addTapGestureToMainView];
}



- (void)addTapGestureToMainView
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOutside)];
    [blurView addGestureRecognizer:gesture];
}


- (void)userTappedOutside
{
    //Hide menu
    [UIView animateWithDuration:.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        CGRect frame = tblView.frame;
        frame.size.height = 0;
        tblView.frame = frame;
        
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:.2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            blurView.backgroundColor = [UIColor clearColor];
            
            
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
            
        }];//Completion of Second Animtaion
        
    }];
    
}


#pragma mark - UITable View delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menuList count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DropDownCell *cell = [tableView dequeueReusableCellWithIdentifier:kDropDownCell];
    
    [cell updateMenuItem:[menuList objectAtIndex:indexPath.row]];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [delegate didUserSelectedMenuOption:[menuList objectAtIndex:indexPath.row]];
    [self userTappedOutside];
}

@end
