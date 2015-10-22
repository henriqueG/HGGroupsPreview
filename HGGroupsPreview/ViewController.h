//
//  ViewController.h
//  HGGroupsPreview
//
//  Created by Henrique Galo on 10/22/15.
//  Copyright © 2015 Henrique Galo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGGroupsPreview.h"

@interface ViewController : UIViewController <HGGroupsPreviewDataSource>
@property (nonatomic, weak) IBOutlet UIImageView *image;
@end

