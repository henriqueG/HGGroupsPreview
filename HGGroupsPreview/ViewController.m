//
//  ViewController.m
//  HGGroupsPreview
//
//  Created by Henrique Galo on 10/22/15.
//  Copyright © 2015 Henrique Galo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (NSInteger)numberOfImagesForGroup:(HGGroupsPreview*)group {
    return 4;
}
- (CGSize)sizeForGroup:(HGGroupsPreview*)group {
    return CGSizeMake(200, 200);
}

- (UIImage*)group:(HGGroupsPreview*)group imageForIndex:(NSInteger)index {
    return [UIImage imageNamed:[NSString stringWithFormat:@"Button%ld", (long)index+1]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HGGroupsPreview *group = [[HGGroupsPreview alloc] init];
    group.dataSource = self;
    self.image.image = [group generateGroupImage];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
