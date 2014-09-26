//
// Created by Mustafin Askar on 26/09/2014.
// Copyright (c) 2014 askar. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AMActionSheetCell : UITableViewCell

+ (CGFloat)getCellHeightFromText:(NSString *)text;
- (void)setText:(NSString *)text;

@end