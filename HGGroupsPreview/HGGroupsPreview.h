//
//  HGGroupsPreview.h
//  IconLook Mac
//
//  Created by Henrique Galo on 4/17/15.
//  Copyright (c) 2015 Henrique Galo. All rights reserved.
//

/*
 This will get an maximum of 9 images and make a Home Screen groups like image.
 */

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#elif TARGET_OS_MAC
#import <Cocoa/Cocoa.h>
#endif

#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC
@interface InvertedView : NSView
@end
#endif

@class HGGroupsPreview;

@protocol HGGroupsPreviewDataSource <NSObject>
@required
- (NSInteger)numberOfImagesForGroup:(HGGroupsPreview*)group;
- (CGSize)sizeForGroup:(HGGroupsPreview*)group;
#if TARGET_OS_IPHONE
- (UIImage*)group:(HGGroupsPreview*)group imageForIndex:(NSInteger)index;
#elif TARGET_OS_MAC
- (NSImage*)group:(HGGroupsPreview*)group imageForIndex:(NSInteger)index;
#endif
@end

@interface HGGroupsPreview : NSObject

@property NSInteger tag;
@property(nonatomic, assign) id<HGGroupsPreviewDataSource> dataSource;
#if TARGET_OS_IPHONE
- (void)generateGroupImageFromCache:(BOOL)cache hasChanges:(BOOL)changes cacheID:(NSString*)cacheID completionHandler:(void(^)(UIImage *generatedImage))completionBlock;
- (void)generateGroupViewFromCache:(BOOL)cache hasChanges:(BOOL)changes cacheID:(NSString*)cacheID completionHandler:(void(^)(UIView *generatedView))completionBlock;
- (void)generateGroupImageWithCompletionHandler:(void(^)(UIImage *generatedImage))completionBlock;
- (UIImage*)generateGroupImage;
#elif TARGET_OS_MAC
- (NSImage*)generateGroupImage;
#endif
@end
