//
//  LargeImgViewController.m
//  PersonalWebsites
//
//  Created by VectoScalar on 18/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "LargeImgViewController.h"

#define kXpadding 10
#define kYpadding 75

@interface LargeImgViewController ()<UIScrollViewDelegate>
{
    NSInteger numberOfImage;
    
    NSInteger scrollViewWidth;
    NSInteger scrollViewHeight;
    
    NSInteger currentXposOfScrollView;
}

@end

@implementation LargeImgViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.needToShowBackButton = YES;
    [self createNavigationBarLeftItems];
    
    self.navigationItem.title = kEmptyStr;
    
    numberOfImage = [self.imagesList count];
    
    [self addScrollView];
    
    [self addImagesToScrollView];
    
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Show current image index from totle.
    self.title = [NSString stringWithFormat:@"%d of %d", self.imgIndex + 1, numberOfImage];
    //Add all image to image view.
}



- (void)addScrollView{
    
    scrollViewWidth = (kScreenWidth - 2 * kXpadding);
    scrollViewHeight = (kScreenHeight - (kXpadding + kYpadding));

    self.mScrollView.delegate = self;
    self.mScrollView.contentSize = CGSizeMake(numberOfImage * scrollViewWidth, scrollViewHeight);
    
    currentXposOfScrollView = self.imgIndex * scrollViewWidth;
    
}



- (void)addImagesToScrollView{
    
    for(NSInteger index = 1; index <= numberOfImage; index++){
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake((index - 1) * scrollViewWidth, 0, scrollViewWidth, scrollViewHeight)];
        
        imageView.image = [self.imagesList objectAtIndex:(index - 1)];
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        //imageView.alignmentRectInsets = UIEdgeInsetsZero;
        
        [self.mScrollView addSubview:imageView];
    }
    
    [self.mScrollView setContentOffset:CGPointMake(currentXposOfScrollView, kYpadding)];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}



-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger xPosDiff = scrollView.contentOffset.x - currentXposOfScrollView;
    
    if(xPosDiff != 0 && xPosDiff > (scrollViewWidth/2)){
        self.imgIndex += 1;
    }else if(xPosDiff != 0 && xPosDiff < (-scrollViewWidth/2)){
        self.imgIndex -= 1;
    }
    
    self.title = [NSString stringWithFormat:@"%d of %d", self.imgIndex + 1, [self.imagesList count]];

    currentXposOfScrollView = scrollView.contentOffset.x;
}

@end
