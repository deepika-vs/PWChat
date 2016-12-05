//
//  PropertryCalendarCell.m
//  PersonalWebsites
//
//  Created by VectoScalar on 09/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "CalendarMonthTableViewCell.h"
#import "CalendarDayCollectionViewCell.h"

#define kCalendarDayCollectionViewCellID  @"CalendarDayCollectionViewCell"
#define kBookingFormTitleText             @"Booking From"


@interface CalendarMonthTableViewCell()<BookSlotFormViewDelegate, UIScrollViewDelegate>
{

}
@end


@implementation CalendarMonthTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //Set collectionview delegate.
    self.mCollectionView.delegate = self;
    self.mCollectionView.dataSource = self;
    
    //Register nib.
    UINib *dayCellNib = [UINib nibWithNibName:kCalendarDayCollectionViewCellID bundle:nil];
    
    [self.mCollectionView registerNib:dayCellNib forCellWithReuseIdentifier:kCalendarDayCollectionViewCellID];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSInteger nDayInMonth = self.month.rangeOfDayInMonth.length;
    
    NSInteger dayOfWeek = self.month.startWeekDayOfMonth;
    
    //Check can month fit in fisrt 35 cells.
    if((28 + (8 - dayOfWeek)) >= nDayInMonth){
        return 35;
    }
    
    return 42;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CalendarDayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCalendarDayCollectionViewCellID forIndexPath:indexPath];
    
    if(cell){
        //Init cell with default values.
        [cell initCellWithDefaultValues];
        
        NSInteger dayForDate = [self getDateForTheDay: indexPath.row];
        
        //Set day date of the cell.
        [cell setDayContents:dayForDate];
        
        CalendarMonthDay *dayRecord = nil;
        
        if(dayForDate != -1){
            
            if([self.month.daysRecordList count] < dayForDate){
                //Create a new day record.
                dayRecord = [[CalendarMonthDay alloc] initWithDay: dayForDate andMonth:[self.month getMonthNumber] andYear:[self.month getYearNumber]];
                
                [self.month.daysRecordList addObject:dayRecord];
                
            }else if([self.month.daysRecordList count] >= dayForDate){
                dayRecord = [self.month.daysRecordList objectAtIndex:dayForDate - 1];
            }
            
            //Set default day record.
            [cell updateDayRecord:dayRecord];
            
            if(cell.day.isBooked){
                [cell updateBookedSelection];
            }
        }
    }
    
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CalendarDayCollectionViewCell *cell = (CalendarDayCollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
    
    if(cell.day && cell.day.isBooked == NO){
        NSDate *date = cell.day.date;
        //check is date should not passed before selection.
        if([Utility compareTwoDate:date with: [NSDate date]] != NSOrderedAscending){
            
            [cell updateSelection];
            
            //Update data for the day.
            //[self.month.daysRecordList replaceObjectAtIndex:cell.day.dayNumDate - 1 withObject:cell.day];
            
            NSDate *firstSelectedDate = [self.delegate getSelectedFirstDate];
            if (!firstSelectedDate) {
                [self.delegate setSelectedFirstDate:date];
            }else{
                //Check all dates in slots must not booked.
                BOOL canBookSlot = [self validateDatesOfSlotBeforeBooking: firstSelectedDate toDate: date];
                
                if(canBookSlot == YES){
                    //Show sellection color here
                    BookSlotFormView *fromView = (BookSlotFormView*)[[BookSlotFormView alloc] initWithTitle:kBookingFormTitleText];
                    
                    fromView.delegate = self;
                    
                    //Create slot to book.
                    if([Utility compareTwoDate:firstSelectedDate with:date] == NSOrderedAscending){
                        [fromView createSlotWithDate:firstSelectedDate endDate: date];
                    }else{
                        [fromView createSlotWithDate:date endDate: firstSelectedDate];
                    }
                    
                    [[[UIApplication sharedApplication] keyWindow] addSubview:fromView];
                    
                }else{
                    //Remove selection from datalist of the day
                    //Show the warning the slot can't book.
                }
                
                [self.delegate setSelectedFirstDate:nil];
            }
        }
    }
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat cellSize = collectionView.frame.size.width/7 - 1;
    
    return CGSizeMake(cellSize, 45);
}


#pragma mark -CalendarDayViewCellDelegate methods

- (NSInteger)getDateForTheDay:(NSInteger) rowNum{
    
    NSInteger dayDate = rowNum - self.month.startWeekDayOfMonth + 2;
    
    if(dayDate > 0 && dayDate <=  self.month.rangeOfDayInMonth.length){
        return  dayDate;
    }
    
    return -1;
}


#pragma mark - Public helper method

- (void)resetSubviews {
    [self.mCollectionView reloadData];
}


- (BOOL) validateDatesOfSlotBeforeBooking:(NSDate *) firstDate toDate:(NSDate *) endDate{
    
    BOOL isSelectedDatesValid = NO;
    
    NSComparisonResult result = [Utility compareTwoDate: firstDate with:endDate]; // comparing two dates
    
    NSDate *toDayDate = [NSDate date];
    
    if(result == NSOrderedAscending){
        NSLog(@"today is less");
        isSelectedDatesValid = [self validateDates: firstDate to:endDate toDay: toDayDate];
    }
    else if(result == NSOrderedDescending){
        NSLog(@"newDate is less");
        isSelectedDatesValid = [self validateDates: endDate to:firstDate toDay: toDayDate];
    }
    else{
        NSLog(@"Both dates are same");
    }
    
    return isSelectedDatesValid;
}


-(BOOL) validateDates:(NSDate *) startDate to:(NSDate *) endDate toDay:(NSDate *) today{
    for (NSDate *date = startDate;                    // initialisation
         [date compare:endDate] != NSOrderedDescending; // compare
         date = [date dateByAddingTimeInterval:24*60*60])    // increment
    {
        if([self.delegate isDateBooked:date] == YES || [Utility compareTwoDate: today with: date] == NSOrderedDescending){
            return NO;
        }
    }
    
    return YES;
}


#pragma mark -BookSlotFormViewDelegate methods

- (void)userPressedToBookSlot:(CalendarBookedSlot *)bookSlot{
    [self.delegate addSlotToList:bookSlot];    
    [self.delegate reloadTableView];
}


- (void) userPressedCancelSlot{
    [self resetSubviews];
    //[self.delegate reloadTableView];
}


#pragma mark -Helper methods

- (NSInteger) getDayComponentFromDate:(NSDate *) date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    return [components day];
}



-(void) updateDayDataForBookedDay:(NSInteger) day{
    CalendarMonthDay *dayRecord = [self.month.daysRecordList objectAtIndex:(day - 1)];
    dayRecord.isBooked = YES;
    [self.month.daysRecordList replaceObjectAtIndex:(day - 1) withObject:dayRecord];
}

@end
