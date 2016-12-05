//
//  PropertyPagerController.m
//  PersonalWebsites
//
//  Created by vectoscalar on 14/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "PropertyPagerController.h"
#import <MXSegmentedPager/MXSegmentedPager.h>

#import "AboutPropertyVC.h"
#import "PropertyRatesVC.h"
#import "PropertyAmenitiesVC.h"
#import "PropertyGalleryVC.h"
#import "PropertyCalendarVC.h"

#define kAboutPropertyNib       @"AboutPropertyVC"
#define kPropertyRatesNib       @"PropertyRatesVC"
#define kPropertyAmenitiesNib   @"PropertyAmenitiesVC"
#define kPropertyGalleryNib     @"PropertyGalleryVC"
#define kPropertyCalendarNib    @"PropertyCalendarVC"



@interface PropertyPagerController ()<MXSegmentedPagerDelegate,MXSegmentedPagerDataSource>
{
    NSMutableArray* tabBarOptionsTitle;
}

@property (nonatomic, strong) MXSegmentedPager* segmentedPager;

@end

@implementation PropertyPagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = kPropertyScreenTitle;
    
    self.needToShowBackButton = YES;
    
    [self createNavigationBarLeftItems];
    
    
    [self configureTabOptions];
    
    [self addPagerToView];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillLayoutSubviews {
    
    self.segmentedPager.frame = (CGRect){
        .origin.x       = 0.0f,
        .origin.y       = self.navigationController.navigationBar.frame.size.height + 20,
        .size.width     = self.view.frame.size.width,
        .size.height    = kScreenHeight - self.navigationController.navigationBar.frame.size.height - 20
    };
    
    DebugLog(@"--Segmented Pager Frame--%@",NSStringFromCGRect(self.segmentedPager.frame));
    
    [super viewWillLayoutSubviews];
}



#pragma mark - Overridden methods

- (void)userTappedOnRightBarButton:(id) sender
{
    [self hideRightNavigationItem];
    
}


- (void)configureTabOptions
{
    if(!tabBarOptionsTitle){
        tabBarOptionsTitle = [[NSMutableArray alloc] init];
    }
    
    //First options
    id icon  = kFontAwesomeText(kInfoFA);
    id title = kAbtPropertyScreenTitle;
    NSString *opt = [NSString stringWithFormat:@" %@  %@", icon, title];
    [tabBarOptionsTitle addObject:opt];
    
    //Second option
    icon  = kFontAwesomeText(kDollarFA);
    title = kRatesScreenTitle;
    opt = [NSString stringWithFormat:@"%@  %@", icon, title];
    [tabBarOptionsTitle addObject:opt];
    
    //Third option
    icon  = kFontAwesomeText(kAmenitiesFA);
    title = kAmenityScreenTitle;
    opt = [NSString stringWithFormat:@"%@  %@", icon, title];
    [tabBarOptionsTitle addObject:opt];
    
    
    //Fourth option
    icon  = kFontAwesomeText(kGalleryFA);
    title = kGalleryScreenTitle;
    opt = [NSString stringWithFormat:@"%@  %@", icon, title];
    [tabBarOptionsTitle addObject:opt];
    
    //Fifth option
    icon  = kFontAwesomeText(kICalFA);
    title = KCalanderScreenTitle;
    opt = [NSString stringWithFormat:@"%@  %@", icon, title];
    [tabBarOptionsTitle addObject:opt];
    
}



#pragma mark - MX Segmented Pager Delegate
- (void)addPagerToView
{
    [self.view addSubview:self.segmentedPager];
    
    self.segmentedPager.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    
    
    self.segmentedPager.segmentedControl.selectionIndicatorColor = kNavColor;
    
    // self.segmentedPager.segmentedControl.selectionIndicatorHeight = kIndicatorHeight;
    
    self.segmentedPager.backgroundColor = [UIColor whiteColor];
    
    
    self.segmentedPager.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    
    self.segmentedPager.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName :kNavColor};
    
    //Style for unselected title
    self.segmentedPager.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : kNavColor,NSFontAttributeName:kFontAwesomeFont(15)};
    
    self.segmentedPager.segmentedControl.selectionIndicatorHeight = 2.0f;
    
    self.segmentedPager.segmentedControl.backgroundColor = [UIColor whiteColor];
    
    self.segmentedPager.pager.gutterWidth = 1.0;
    
}


#pragma -mark Properties

- (MXSegmentedPager *)segmentedPager {
    if (!_segmentedPager) {
        
        // Set a segmented pager
        _segmentedPager = [[MXSegmentedPager alloc] init];
        _segmentedPager.delegate    = self;
        _segmentedPager.dataSource  = self;
    }
    return _segmentedPager;
}


#pragma -mark <MXSegmentedPagerDelegate>

- (void)segmentedPager:(MXSegmentedPager *)segmentedPager didSelectViewWithTitle:(NSString *)title {
    DebugLog(@"%@ page selected.", title);

    [self hideRightNavigationItem];
}


#pragma -mark <MXSegmentedPagerDataSource>

- (NSInteger)numberOfPagesInSegmentedPager:(MXSegmentedPager *)segmentedPager {
    return [tabBarOptionsTitle count];
}


- (NSString *)segmentedPager:(MXSegmentedPager *)segmentedPager titleForSectionAtIndex:(NSInteger)index {
    
    return [tabBarOptionsTitle objectAtIndex:index];
}


- (UIView *)segmentedPager:(MXSegmentedPager *)segmentedPager viewForPageAtIndex:(NSInteger)index {
    
    return [self getViewForIndex:(int)index];

}



- (UIView *)getViewForIndex:(int)index
{
    //PropertyVCPage page = index;
    
    switch (index) {
        case AboutPropertyPage: //About
        {
            AboutPropertyVC *aboutVC = [[AboutPropertyVC alloc] initWithNibName:kAboutPropertyNib bundle:nil];
            [self addChildViewController:aboutVC];
            [aboutVC didMoveToParentViewController:self];
            //[aboutVC setContainerVC:self];
            return aboutVC.view;
        }
        case PropertyRatesPage: //Rates
        {
            PropertyRatesVC *rateVC = [[PropertyRatesVC alloc] initWithNibName:kPropertyRatesNib bundle:nil];
            [self addChildViewController:rateVC];
            [rateVC didMoveToParentViewController:self];
            //[rateVC setContainerVC:self];
            return rateVC.view;
        }
        case PropertyAmenityPage: //Amenities
        {
            PropertyAmenitiesVC *amenitiesVC = [[PropertyAmenitiesVC alloc] initWithNibName:kPropertyAmenitiesNib bundle:nil];
            [self addChildViewController:amenitiesVC];
            [amenitiesVC didMoveToParentViewController:self];
            //[amenitiesVC setContainerVC:self];
            return amenitiesVC.view;
        }
        case PropertyGalleryPage: //Gallery
        {
            PropertyGalleryVC *galleryVC = [[PropertyGalleryVC alloc] initWithNibName:kPropertyGalleryNib bundle:nil];
            [self addChildViewController:galleryVC];
            [galleryVC didMoveToParentViewController:self];
            [galleryVC setContainerVC:self];
            return galleryVC.view;
            
        }
        case PropertyCalendarPage: //Calendar
        {
            PropertyCalendarVC *caldendarVC = [[PropertyCalendarVC alloc] initWithNibName:kPropertyCalendarNib bundle:nil];
            [self addChildViewController:caldendarVC];
            [caldendarVC didMoveToParentViewController:self];
            //[caldendarVC setContainerVC:self];
            return caldendarVC.view;
        }
        default:
            NSLog(@"Wrong page index in property module");
            break;
    }
    
    return [UIView new];
}


@end
