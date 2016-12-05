//
//  PropertyAmenitiesVC.m
//  PersonalWebsites
//
//  Created by vectoscalar on 14/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "PropertyAmenitiesVC.h"
#import "AmenityWrapper.h"
#import "AmenitySection.h"
#import "AmenityCell.h"
#import "AddAmenituView.h"

#define kAmenityCellKey         @"AmenityCell"
#define kAmenityCategoryKey     @"amenityCategory"
#define kAmenitiesKey           @"amenities"

#define kTestFile               @"DummyTestFile"
#define kTestFileExt            @"json"
#define kAddNewAmenityCategory  @"Enter a new category name for amenities"
#define kAddCatPlaceHolder      @"Category name"
#define kAddCategoryButtonTitle @"Add Category"


@interface PropertyAmenitiesVC () <AmenityCellDelegate,AddAmenityViewDelegate>{
    UIView *mainUIView;
    UITextField *textField;
}

@end

@implementation PropertyAmenitiesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Prepare data for amenities view.
    [self prepareAmenityData];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //Register cell.
    UINib *nibCell = [UINib nibWithNibName:kAmenityCellKey bundle:nil];
    [self.mTableView registerNib:nibCell forCellReuseIdentifier:kAmenityCellKey];
    
    self.mTableView.estimatedRowHeight  = 100;
    self.mTableView.rowHeight = UITableViewAutomaticDimension;
    // Do any additional setup after loading the view from its nib.
    
    [self performSelector:@selector(createFloatingButton) withObject:nil afterDelay:0.1];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)prepareAmenityData{
    if(self.amenityObjArray == nil){
        self.amenityObjArray = [[NSMutableArray alloc] init];
    }
    
    id data = [self parseJsonFileToJsonObject:kTestFile];
    //TODO: Tobe apply iskindofclass for real.
    NSArray *tempArray = [NSArray arrayWithArray:(NSArray*)data];
    
    for(NSDictionary *dict in tempArray)
    {
        AmenityWrapper *amenity  = [[AmenityWrapper alloc] init];
        
        amenity.categoryTitle = [dict objectForKey:kAmenityCategoryKey];
        amenity.amenitiesArray = [NSMutableArray arrayWithArray:[dict objectForKey:kAmenitiesKey]];
        
        [self.amenityObjArray addObject:amenity];
    }
    
    //1- Read contents through api.
    //2- nAmenity = arraylength(numOfAmeCagtegory).
    //3- Iterate for loop & create an emenitydata object and add it to amenityObjArray.
    
    //For testing reading data from dummy file.
}



- (id) parseJsonFileToJsonObject:(NSString *) fileName{
    NSError *error = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:kTestFileExt];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    id jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if(error != nil){
        NSLog(@"Json parse failed from filepath: %@", fileName);
        return nil;
    }
    
    return jsonArray;
}



#pragma mark - PropertyAmenities TableviewDelegates.

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger nRows = [self.amenityObjArray count];
    if(nRows > 0){
        self.addAmenityCatMsg.hidden = YES;
    }else{
        self.addAmenityCatMsg.hidden = NO;
    }
    return nRows;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AmenityCell *cell = [tableView dequeueReusableCellWithIdentifier:kAmenityCellKey forIndexPath:indexPath];
    NSLog(@"----IndexPath ---%d",(int)indexPath.row);
    if(indexPath.row >=0)
    {
        AmenityWrapper *amenity = [self.amenityObjArray objectAtIndex:indexPath.row];
        
        NSArray *amenitiesList =  [NSArray arrayWithArray:amenity.amenitiesArray];
        
        cell.amenityCategoryLbl.text = [amenity.categoryTitle uppercaseString];
        [cell addAmenitiesToCell:amenitiesList withCellWidth:self.view.frame.size.width];
    }
    
    cell.delegate = self;
    return cell;
}


#pragma mark -AmenityCellDelegates

- (void)userPressedDeleteAmenityon:(AmenityCell *)cell amenityIndex:(int)amenityIndex{
    NSUInteger rowNum = [self.mTableView indexPathForCell:cell].row;
    //Delete amenity.
    
    AmenityWrapper *amenity = [[AmenityWrapper alloc] init];
    amenity = [self.amenityObjArray objectAtIndex:rowNum];
    
    NSMutableArray *listArray = [NSMutableArray arrayWithArray:amenity.amenitiesArray];
    if(amenityIndex < [listArray count])
    {
        [listArray removeObjectAtIndex:amenityIndex];
        
        [amenity.amenitiesArray removeAllObjects];
        
        [amenity.amenitiesArray addObjectsFromArray:listArray];
        
        [cell addAmenitiesToCell:amenity.amenitiesArray withCellWidth:cell.bounds.size.width];
    }
    
    
    [self.mTableView reloadRowsAtIndexPaths:@[[self.mTableView indexPathForCell:cell]] withRowAnimation:NO];
    [UIView commitAnimations];
    
}



- (void)userPressedDeleteCategoryOn:(AmenityCell *)cell{
    NSIndexPath* indexPath = [self.mTableView indexPathForCell:cell];
    //Delete amenity.
    
    AmenityWrapper *amenity = [[AmenityWrapper alloc] init];
    amenity = [self.amenityObjArray objectAtIndex:indexPath.row];
    
    if(amenity != nil)
    {
        [self.mTableView beginUpdates];
        [self.amenityObjArray removeObjectAtIndex:indexPath.row];
        [self.mTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.mTableView endUpdates];
    }
    
    [self.mTableView reloadData];
}



- (void)userPressedAddNewAmenityOn:(AmenityCell *)cell addAmenity:(NSString *) amenityText{
    NSUInteger rowNum = [self.mTableView indexPathForCell:cell].row;
    
    AmenityWrapper *amenity = [[AmenityWrapper alloc] init];
    amenity = [self.amenityObjArray objectAtIndex:rowNum];
    
    if(amenity != nil)
    {
        [amenity.amenitiesArray addObject:amenityText];
        [cell addAmenitiesToCell:amenity.amenitiesArray withCellWidth:cell.bounds.size.width];
    }
    
    [self.mTableView reloadRowsAtIndexPaths:@[[self.mTableView indexPathForCell:cell]] withRowAnimation:NO];
    [UIView commitAnimations];
}


#pragma mark - FLoating button action
- (void)floatingButtonTapped
{
    AddAmenituView *view = [[AddAmenituView alloc]initWithTitle:kAddNewAmenityCategory andPlaceholder: kAddCatPlaceHolder andBtnTitle:kAddCategoryButtonTitle];
    view.delegate = self;
    [[[UIApplication sharedApplication] keyWindow] addSubview:view];
}


#pragma mark  - Add amenityView delegate
- (void)didUserAddedAmenity:(NSString *)content onView:(AddAmenituView *)view
{
    AmenityWrapper *amenity  = [[AmenityWrapper alloc] init];
    amenity.categoryTitle = content;
    amenity.amenitiesArray = [[NSMutableArray alloc] init];
    
    [self.amenityObjArray addObject:amenity];
    
    [self.mTableView reloadData];
}

@end
