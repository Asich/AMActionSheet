//
// Created by Mustafin Askar on 22/09/2014.
// Copyright (c) 2014 Crystal Spring. All rights reserved.
//

#import "AMActionSheet.h"
#import "AMActionSheetHelper.h"
#import "AMActionSheetCell.h"

@interface AMActionSheet () {}

@property (nonatomic, strong) UIView *holderView;
@property (nonatomic, strong) UITableView *listView;

@end

@implementation AMActionSheet {}

- (id)initWithItems:(NSArray *)items {
    CGRect frame = CGRectMake(0, 0, [AMActionSheetHelper screenWidth], [AMActionSheetHelper screenHeight]);
    self = [super initWithFrame:frame];
    if (self) {
        _items = items;
        [self configUI];
        [self.listView reloadData];
        [self adaptViewHeighs];
    }
    return self;
}

#pragma mark -

- (void)registerGestureOnView:(UIView *)view {
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(datePickerDoneClicked)];
    singleFingerTap.delegate = self;
    [view addGestureRecognizer:singleFingerTap];
}

- (void)datePickerDoneClicked {
    [self hide];
}

#pragma mark - tapgesturerecognizer delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return [touch.view isKindOfClass:[AMActionSheet class]];
}

#pragma mark - uitableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [AMActionSheetCell getCellHeightFromText:self.items[(NSUInteger) indexPath.row]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    AMActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AMActionSheetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    [cell setText:self.items[(NSUInteger) indexPath.row]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedRowIndex) {
        self.selectedRowIndex(indexPath.row);
    }
    [self datePickerDoneClicked];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *fview = [[UIView alloc] initWithFrame:CGRectZero];
    return fview;
}

#pragma mark - config ui

- (void)configUI {
    [self registerGestureOnView:self];

    self.holderView = [[UIView alloc] initWithFrame:CGRectMake(0, [AMActionSheetHelper screenHeight], [AMActionSheetHelper screenWidth], 344)];
    self.holderView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.holderView];

    [self drawCloseButton];

    [self drawTableView];

    [[AMActionSheetHelper delegateWindow] addSubview:self];
}

- (void)drawTableView {
    CGRect frame = CGRectMake(0, 44, [AMActionSheetHelper screenWidth], 300);
    self.listView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    [self.holderView addSubview:self.listView];
}

- (void)drawCloseButton {
    UIView *tHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.holderView.width, 44)];
    tHeader.backgroundColor = [UIColor clearColor];

    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(tHeader.width - 44, 0, 44, 44);
    UIImage *scaledImage = [AMActionSheetHelper scaleImage:[UIImage imageNamed:@"icon-close-light.png"]];
    UIImage *scaledTapImage = [AMActionSheetHelper scaleImage:[UIImage imageNamed:@"icon-close-light_tap.png"]];
    [closeButton setImage:scaledImage forState:UIControlStateNormal];
    [closeButton setImage:scaledTapImage forState:UIControlStateHighlighted];
    [closeButton addTarget:self action:@selector(datePickerDoneClicked) forControlEvents:UIControlEventTouchUpInside];

    closeButton.backgroundColor = [UIColor clearColor];
    [tHeader addSubview:closeButton];
    [self.holderView addSubview:tHeader];
}

#pragma mark - setters/getters

- (void)setItems:(NSArray *)items {
    _items = items;
    //redraw
}

#pragma mark - open/close animation

- (void)show {
    CGRect tempRect = self.holderView.frame;
    tempRect.origin.y = [AMActionSheetHelper screenHeight] - self.holderView.frame.size.height;
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        self.holderView.frame = tempRect;
    } completion:^(BOOL finished) {
    }];
}

- (void)hide {
    CGRect tempRect = self.holderView.frame;
    tempRect.origin.y = [AMActionSheetHelper screenHeight];
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        self.holderView.frame = tempRect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - help methods

- (void)adaptViewHeighs {
    if (self.listView.contentSize.height < 300) {
        CGRect tempListFrame = self.listView.frame;
        tempListFrame.size.height = self.listView.contentSize.height;
        self.listView.frame = tempListFrame;

        CGRect tempHolderFrame = self.holderView.frame;
        tempHolderFrame.size.height = self.listView.frame.size.height + 44;
        self.holderView.frame = tempHolderFrame;
    }
}

#pragma mark - memory

- (void)dealloc {
    NSLog(@"AMActionSheet dealloced");
}

@end