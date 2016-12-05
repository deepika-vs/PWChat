//
//  CalendarDayViewCell.m
//  PersonalWebsites
//
//  Created by VectoScalar on 09/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "CalendarDayCollectionViewCell.h"
#import "BookSlotFormView.h"

@interface CalendarDayCollectionViewCell()

@end

@implementation CalendarDayCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}


- (void) initCellWithDefaultValues{
    
    self.dayContentsView.layer.borderWidth = 0.28;
    
    self.dayContentsView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self updateColorOfCellBG: kInputFieldBGColor andTextColor:[UIColor blackColor]];
    
    self.day = [[CalendarMonthDay alloc] init];
    self.day.isSelected = NO;
    self.day.isBooked = NO;
}


- (void) setDayContents:(NSInteger) dayForDate{
    
    if(dayForDate != -1){
        //Day for date must not be zero. Date can't be zero.
        self.dayDateLabel.text = [NSString stringWithFormat:@"%d", dayForDate];
        //[self.dayDateLabel setFont:[UIFont fontWithName:kFontNameWithBold size:13]];
    }else{
        self.dayDateLabel.text = kEmptyStr;
    }
}


- (void) updateDayRecord:(CalendarMonthDay *)dayRecord{
    self.day = dayRecord;
}


- (void)updateBookedSelection{
    [self updateColorOfCellBG: kNavColor andTextColor: [UIColor whiteColor]];
    self.day.isSelected = YES;
}


- (void)updateSelection {
    if(self.day.isBooked == YES || self.day.isSelected == NO){
        [self updateColorOfCellBG: kNavColor andTextColor: [UIColor whiteColor]];
        self.day.isSelected = YES;
        
    }else{
        [self updateColorOfCellBG: kInputFieldBGColor andTextColor: [UIColor blackColor]];
        self.day.isSelected = NO;
    }
}



- (void)updateColorOfCellBG: (UIColor *) color andTextColor: (UIColor *) textColor{
    
    [self setBackgroundColor:color];
    [self.dayDateLabel setTextColor:textColor];
}

@end
