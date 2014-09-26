//
// Created by Mustafin Askar on 22/09/2014.
// Copyright (c) 2014 Crystal Spring. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AMActionSheet : UIView <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) void (^selectedRowIndex)(NSInteger rowIndex);

- (id)initWithItems:(NSArray *)items;

- (void)show;
- (void)hide;

@end