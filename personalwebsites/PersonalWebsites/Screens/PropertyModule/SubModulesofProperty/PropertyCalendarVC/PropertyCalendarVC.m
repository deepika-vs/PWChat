//
//  PropertyCalendarVC.m
//  PersonalWebsites
//
//  Created by vectoscalar on 14/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "PropertyCalendarVC.h"
#import "CalendarMonthTableViewCell.h"
#import "CalendarDayCollectionViewCell.h"
#import "BookedCalendarSlotsTableVC.h"

#define kSectionHeaderHeight    60.0f
#define kNMonthToShowInCalendar  8

#define kCalendarMonthTableViewCellId @"CalendarMonthTableViewCell"
#define kBookedCalendarSlotsTableVCID @"BookedCalendarSlotsTableVC"

@interface PropertyCalendarVC () <CalendarMonthTableViewCellDelegate, BookedCalendarSlotsTableVCDelegate>
{
    NSInteger monthNumberIndex;
    NSInteger yearNumberIndex;
    
    BOOL isYearChanged;
    
    CGFloat monthCellHeight;
    
    NSDate *firstSelectedDate;
}

@end


@implementation PropertyCalendarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Utility addShadowToView:self.calContentView];
    self.calContentView.layer.cornerRadius = 8.0;
    
    //Set tableview delegate.
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    
    //Create tableview cell nib & register with tableview.
    UINib *nib = [UINib nibWithNibName:kCalendarMonthTableViewCellId bundle:nil];
    [self.mTableView registerNib:nib forCellReuseIdentifier:kCalendarMonthTableViewCellId];
    
    
    self.mTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    self.calendar = [NSCalendar currentCalendar];
    // Do any additional setup after loading the view from its nib.
    
    NSDateComponents *components = [self.calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    //Get current month & year from calendar.
    monthNumberIndex = [components month];
    yearNumberIndex = [components year];
    
    //Check is need to show next year months.
    if((12 - monthNumberIndex) < kNMonthToShowInCalendar){
        isYearChanged = YES;
    }
    
    [self initCalenderData];
}


- (void)initCalenderData{
    self.monthsRecordList = [[NSMutableArray alloc] init];
    //TODO::It will update with api data.
    //Initilize BookedSlotsList.
    self.bookedSlotsList = [[NSMutableArray alloc] init];
    //Initilize BookedDateList.
    self.bookedDatesList = [[NSMutableArray alloc] init];
    
    firstSelectedDate = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -UITableViewDelegate <Methods>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return  kNMonthToShowInCalendar;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 01;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([tableView cellForRowAtIndexPath:indexPath]){
        [[tableView cellForRowAtIndexPath:indexPath] removeFromSuperview];
    }
    
    CalendarMonthTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCalendarMonthTableViewCellId forIndexPath:indexPath];
    
    [cell resetSubviews];
    
    if(cell){
        //Set tableview cell delegate
        cell.delegate = self;
        cell.month = nil;
        
        NSInteger rowIndex = indexPath.section;
        
        //Get month by month index
        NSInteger monthIndex = monthNumberIndex + indexPath.section;
        
        if([self.monthsRecordList count] > rowIndex){
            //Get month info from store list.
            cell.month = [self.monthsRecordList objectAtIndex:rowIndex];
        }else{
            
            NSInteger currentYear = 2016;//Default value.
            
            if(monthIndex > 12){
                monthIndex -= 12;
                currentYear = yearNumberIndex + 1;
            }else{
                currentYear = yearNumberIndex;
            }
            
            
            //Create month object add set attributes.
            cell.month = [[CalendarMonth alloc] initWithMonth:monthIndex andYear: currentYear];

            //Add month to the list.
            [self.monthsRecordList addObject:cell.month];
        
        }
        
        //Calculate height for the month cell.
        monthCellHeight = [self getMonthCellHeight:cell.month.startWeekDayOfMonth dayInMonth:cell.month.rangeOfDayInMonth.length];
    }
    
    
    return cell;
}


//Create month header with month's name, year and week's days.

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    CGRect headerFrame = CGRectMake(15, 0, self.view.frame.size.width-30, 60);
    UIView *headerMonthView = [[UIView alloc] initWithFrame:headerFrame];
    
    //Month header' title label frame.
    CGRect monthTitleFrame = headerMonthView.bounds;
    monthTitleFrame.size.height = 25;
    monthTitleFrame.origin.y = 5;
    
    //Month header label.
    UILabel *monthNameAndYearLbl = [[UILabel alloc] initWithFrame:monthTitleFrame];
    
    //Get month by month index
    NSInteger yearNumber = yearNumberIndex;
    if((monthNumberIndex + section) > 12){
        yearNumber = yearNumberIndex + 1;
    }
    
    NSInteger monthIndex = (monthNumberIndex + section - 1) % 12;
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *monthHeaderTitleText = [NSString stringWithFormat:@"%@ %ld", [[dateFormatter monthSymbols] objectAtIndex:monthIndex], (long)yearNumber];
    
    monthNameAndYearLbl.text = monthHeaderTitleText;
    monthNameAndYearLbl.textAlignment = NSTextAlignmentCenter;
    
    //Add week days to header's view.
    
    monthTitleFrame.size.height = 25;
    monthTitleFrame.origin.y = 30;
    
    UIView *monthWeakDaysView = [[UIView alloc] initWithFrame:monthTitleFrame];
    
    [headerMonthView addSubview:monthNameAndYearLbl];
    
    [self addMonthWeekDaysHeaderOn:monthWeakDaysView];
    [headerMonthView addSubview:monthWeakDaysView];
    
    return headerMonthView;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return monthCellHeight;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return kSectionHeaderHeight;
}



#pragma mark -Helper Methods
//Create week's days view for month's header.
- (void) addMonthWeekDaysHeaderOn: (UIView *) view{
    CGRect rect = view.bounds;
    
    CGFloat width = rect.size.width / 7 - 1.0;
    
    for (int i = 0; i< 7; i++){
        CGRect weekDayLblRect = CGRectMake(i * (width+1) , 0, width, 25);
        
        UILabel *dayTitle = [[UILabel alloc] initWithFrame:weekDayLblRect];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        //Week day name upto 3 chars.
        NSString *weekDay = [NSString stringWithFormat:@"%@", [[[dateFormatter weekdaySymbols] objectAtIndex:i] substringToIndex:03]];
        
        dayTitle.text = weekDay;
        
        [dayTitle setFont:[UIFont fontWithName:kFontName size:13]];
        //dayTitle.textColor = [UIColor whiteColor];
        dayTitle.textAlignment = NSTextAlignmentCenter;
        
        [view addSubview:dayTitle];
    }
}



//Calculate height for month, according to number of days & start week day of the month.
- (CGFloat) getMonthCellHeight:(NSInteger) weekDayOfMonth dayInMonth:(NSInteger) nDay{
    
    monthCellHeight = kCalDayCellHeight * 5;
    
    //Check if number of days can we fit in 5 rows Or it need one more row.
    if(((8 - weekDayOfMonth) + 28) < nDay){
        monthCellHeight += kCalDayCellHeight;
    }
    
    return monthCellHeight;
}


//Check book slots list.
- (IBAction)userPressedCheckSlotButton:(PWButton *)sender {
    BookedCalendarSlotsTableVC *bookedSlotsTable = [[BookedCalendarSlotsTableVC alloc] initWithNibName:kBookedCalendarSlotsTableVCID bundle:nil];
    
    bookedSlotsTable.slotRecordsList = [[NSMutableArray alloc] initWithArray:self.bookedSlotsList];
    
    bookedSlotsTable.delegate = self;
    
    [self.navigationController pushViewController:bookedSlotsTable animated:YES];
}


#pragma mark -CalendarMonthTableViewCellDelegate <Method>

- (BOOL) isDateBooked:(NSDate *)date{
    
    if([self.bookedDatesList count] > 0){
        
        for(NSDate *bookedDate in self.bookedDatesList){
            
            if([Utility compareTwoDate:date with:bookedDate] == NSOrderedSame){
                return YES;
            }
        }
    }
    
    return NO;
}


- (NSDate *) getSelectedFirstDate{
    
    return firstSelectedDate;
}


- (void)setSelectedFirstDate:(NSDate *) firstDate{
    
    firstSelectedDate = firstDate;
}


- (void) reloadTableView{
    [self.mTableView reloadData];
}

#pragma mark -Helper <Methods>
//Add dates of a slots to booked list.

- (void) addSlotToList:(CalendarBookedSlot *)slot{
    
    for (NSDate *date = slot.firstDate;                    // initialisation
         [date compare:slot.lastDate] != NSOrderedDescending; // compare
         date = [date dateByAddingTimeInterval:24*60*60])    // increment
    {
        [self.bookedDatesList addObject:date];
        
        //Update data records.
        [self updateMainDataForDate: date];
    }
    
    
    [self.bookedSlotsList addObject:slot];
}


- (void)updateMainDataForDate:(NSDate *)date{
    //Update main record.
    NSDateComponents *components = [self.calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    int nDay = [components day];
    int nMonth = [components month];
    
    if(nMonth >= monthNumberIndex){
        nMonth = nMonth - monthNumberIndex;
    }else{
        nMonth = 12 - monthNumberIndex + nMonth;
    }
    
    CalendarMonth *monthRecord = [self.monthsRecordList objectAtIndex:nMonth];
    CalendarMonthDay *dayRecord = [monthRecord.daysRecordList objectAtIndex:nDay - 1];
    dayRecord.isBooked = YES;
    
    //Update record data.
    [monthRecord.daysRecordList replaceObjectAtIndex:(nDay - 1) withObject:dayRecord];
    [self.monthsRecordList replaceObjectAtIndex:nMonth withObject:monthRecord];
}


#pragma mark -BookedCalendarSlotsTableVCDelegate <Methods>

- (void)deleteSlotFromMainRecord:(CalendarBookedSlot *)slot{
    for (CalendarBookedSlot *slotRecord in self.bookedSlotsList) {
        
        if(([slot.name compare:slotRecord.name] == NSOrderedSame) && [slot.email compare:slotRecord.email] == NSOrderedSame){
            
            //TODO:: Remove record form booked list.
            [self.bookedSlotsList removeObject:slotRecord];
            
            [self.mTableView reloadData];
            
            return;
        }
    }
}
@end
