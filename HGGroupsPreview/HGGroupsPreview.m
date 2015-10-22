//
//  HGGroupsPreview.m
//  IconLook Mac
//
//  Created by Henrique Galo on 4/17/15.
//  Copyright (c) 2015 Henrique Galo. All rights reserved.
//

#import "HGGroupsPreview.h"

#if TARGET_OS_IPHONE

#elif TARGET_OS_MAC
@implementation InvertedView

- (BOOL)isFlipped {
    return TRUE;
}

@end
#endif

@implementation HGGroupsPreview

#if TARGET_OS_IPHONE

- (void)generateGroupImageFromCache:(BOOL)cache hasChanges:(BOOL)changes cacheID:(NSString*)cacheID completionHandler:(void(^)(UIImage *generatedImage))completionBlock {
    
    
    NSString *cacheFolder = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"Folders Cache"];
    
    if (cache) {
//        NSLog(@"Using Cache");
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:cacheFolder]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:cacheFolder withIntermediateDirectories:TRUE attributes:nil error:nil];
//            NSLog(@"Folder created");
        }
        
        NSString *cacheImage = [cacheFolder stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", cacheID]];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:cacheImage] && !changes) {
//            NSLog(@"Found Cache");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *cache = [UIImage imageWithContentsOfFile:cacheImage];
                
                completionBlock(cache);
            });

        }
        else {
//            NSLog(@"File not Found %@! create", changes ? @"and has changes" : @"!");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *generate = [self generateGroupImage];
                
                [UIImagePNGRepresentation(generate) writeToFile:cacheImage atomically:FALSE];
                
                completionBlock(generate);
            });

        }

    }
}

- (void)generateGroupViewFromCache:(BOOL)cache hasChanges:(BOOL)changes cacheID:(NSString*)cacheID completionHandler:(void(^)(UIView *generatedView))completionBlock {
    NSString *cacheFolder = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"Folders Cache"];
    
    if (cache) {
//        NSLog(@"Using Cache");
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:cacheFolder]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:cacheFolder withIntermediateDirectories:TRUE attributes:nil error:nil];
//            NSLog(@"Folder created");
        }
        
        NSString *cacheImage = [cacheFolder stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", cacheID]];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:cacheImage] && !changes) {
//            NSLog(@"Found Cache");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImageView *cache = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:cacheImage]];
                CGSize sizeToGenerate = [self.dataSource sizeForGroup:self];
                [cache setFrame:CGRectMake(0, 0, sizeToGenerate.width, sizeToGenerate.height)];

                UIView *returningView = [[UIView alloc] initWithFrame:cache.frame];
                [returningView setBackgroundColor:[UIColor grayColor]];
                [returningView addSubview:cache];
                
//                UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
//                [effectView setFrame:cache.frame];
//                [[effectView contentView] addSubview:cache];
                
                completionBlock(returningView);
            });
            
        }
        else {
//            NSLog(@"File not Found %@! create", changes ? @"and has changes" : @"!");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *generate = [self generateGroupImage];
                
                [UIImagePNGRepresentation(generate) writeToFile:cacheImage atomically:FALSE];
                
                UIImageView *cache = [[UIImageView alloc] initWithImage:generate];
                
                UIView *returningView = [[UIView alloc] initWithFrame:cache.frame];
                [returningView setBackgroundColor:[UIColor grayColor]];
                [returningView addSubview:cache];
                
                completionBlock(returningView);
            });
            
        }
        
    }
}


- (UIImage*)generateGroupImage {
    CGSize sizeToGenerate = [self.dataSource sizeForGroup:self];
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sizeToGenerate.width, sizeToGenerate.height)];
    
    NSInteger numberOfImages = [self.dataSource numberOfImagesForGroup:self];
    
    CGFloat scale = sizeToGenerate.width / 24.f;
    CGFloat imageSize = 5.2f * scale;
    
    for (NSInteger i = 0; i < (numberOfImages > 9 ? 9 : numberOfImages); i++) {
        NSInteger rowNumber = i / 3;
    
        NSInteger itemRowNumber = i - (3*rowNumber);
        
        CGRect imagePosition = CGRectMake((3 * scale) + (5.2f * scale * (itemRowNumber)) + (1.2f * scale * (itemRowNumber)), (3 * scale) + (5.2f * scale * (rowNumber)) + (1.2f * scale * (rowNumber)), imageSize, imageSize);
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[self.dataSource group:self imageForIndex:i]];
        [imageView setFrame:imagePosition];
        [baseView addSubview:imageView];
    }
    
    UIGraphicsBeginImageContextWithOptions(baseView.bounds.size, NO, 0);
    [baseView drawViewHierarchyInRect:baseView.bounds afterScreenUpdates:YES];
    UIImage *copied = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return copied;
}

- (void)generateGroupImageWithCompletionHandler:(void(^)(UIImage *generatedImage))completionBlock {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImage *generate = [self generateGroupImage];
        
        completionBlock(generate);
    });
}

#elif TARGET_OS_MAC

- (NSImage*)generateGroupImage {
    CGSize sizeToGenerate = [self.dataSource sizeForGroup:self];
    InvertedView *baseView = [[InvertedView alloc] initWithFrame:CGRectMake(0, 0, sizeToGenerate.width, sizeToGenerate.height)];

    NSInteger numberOfImages = [self.dataSource numberOfImagesForGroup:self];
        
    CGFloat scale = sizeToGenerate.width / 24.f;
    CGFloat imageSize = 5.2f * scale;
    
    for (NSInteger i = 0; i < (numberOfImages > 9 ? 9 : numberOfImages); i++) {
        NSInteger rowNumber = i / 3;
        
        NSInteger itemRowNumber = i - (3*rowNumber);
        
        CGRect imagePosition = CGRectMake((3 * scale) + (5.2f * scale * (itemRowNumber)) + (1.2f * scale * (itemRowNumber)), (3 * scale) + (5.2f * scale * (rowNumber)) + (1.2f * scale * (rowNumber)), imageSize, imageSize);
        
        NSImageView *imageView = [[NSImageView alloc] initWithFrame:imagePosition];
        [imageView setImage:[self.dataSource group:self imageForIndex:i]];
        [baseView addSubview:imageView];
    }
    
    NSBitmapImageRep *imageRep = [baseView bitmapImageRepForCachingDisplayInRect:baseView.bounds];

    [baseView cacheDisplayInRect:baseView.bounds toBitmapImageRep:imageRep];
    
    NSImage *renderedImage = [[NSImage alloc] initWithSize:[imageRep size]];
    [renderedImage addRepresentation:imageRep];

    return renderedImage;
}

#endif

@end
