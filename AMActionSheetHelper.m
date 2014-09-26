//
// Created by Mustafin Askar on 26/09/2014.
// Copyright (c) 2014 askar. All rights reserved.
//

#import "AMActionSheetHelper.h"


@implementation AMActionSheetHelper {

}

+ (CGFloat)screenWidth {
    return [self screenSize].width;
}

+ (CGFloat)screenHeight {
    return [self screenSize].height;
}

+ (CGSize) screenSize {
    return [self screenSizeInOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

+ (CGSize) screenSizeInOrientation:(UIInterfaceOrientation)orientation {
    CGSize size = [UIScreen mainScreen].bounds.size;
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        size = CGSizeMake(size.height, size.width);
    }
    return size;
}

+ (UIWindow *)delegateWindow {
    return [[[UIApplication sharedApplication] delegate] window];
}

+ (UIImage *)scaleImage:(UIImage *)originalImage {
    return [UIImage imageWithCGImage:[originalImage CGImage]
                               scale:(originalImage.scale * 2)
                         orientation:(originalImage.imageOrientation)];
}

@end