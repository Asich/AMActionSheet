//
// Created by Mustafin Askar on 26/09/2014.
// Copyright (c) 2014 askar. All rights reserved.
//

#import "AMActionSheetCell.h"
#import "AMActionSheetHelper.h"

#define kTFont [UIFont fontWithName:@"Avenir-Book" size:13]

@implementation AMActionSheetCell {
    UILabel *tLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

+ (CGFloat)getCellHeightFromText:(NSString *)text {
    CGSize maxSize = CGSizeMake([AMActionSheetHelper screenWidth]  - 20, 40);
    CGSize expTextSize = [text sizeWithFont:kTFont constrainedToSize:maxSize lineBreakMode:NSLineBreakByTruncatingTail];
    return expTextSize.height + 20;
    /*[UIFont fontWithName:@"Avenir-Book" size:<#(CGFloat)fontSize#>]*/
}

- (void)setText:(NSString *)text {
    tLabel.frame = CGRectMake(10, 10, [AMActionSheetHelper screenWidth] - 20 /*minus width if image*/, 20);
    tLabel.text = text;
    [tLabel sizeToFit];
}

- (void)configUI {
    tLabel = [[UILabel alloc] init];
    tLabel.backgroundColor = [UIColor clearColor];
    tLabel.font = kTFont;
    tLabel.numberOfLines = 2;
    tLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:tLabel];
}

@end