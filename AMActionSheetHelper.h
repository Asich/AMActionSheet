//
// Created by Mustafin Askar on 26/09/2014.
// Copyright (c) 2014 askar. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AMActionSheetHelper : NSObject

+ (CGFloat)screenWidth;

+ (CGFloat)screenHeight;

+ (CGSize)screenSize;

+ (CGSize)screenSizeInOrientation:(UIInterfaceOrientation)orientation;

+ (UIWindow *)delegateWindow;

+ (UIImage *)scaleImage:(UIImage *)originalImage;

@end