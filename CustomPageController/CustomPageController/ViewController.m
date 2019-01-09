//
//  ViewController.m
//  CustomPageController
//
//  Created by admin on 2019/1/9.
//  Copyright © 2019年 admin. All rights reserved.
//

#import "ViewController.h"
#import "PYPageControl.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet PYPageControl *pageController1;
@property (weak, nonatomic) IBOutlet PYPageControl *pageController2;
@property (weak, nonatomic) IBOutlet PYPageControl *pageController3;
@property (weak, nonatomic) IBOutlet PYPageControl *pageController4;

@property (weak, nonatomic) IBOutlet PYPageControl *pageController5;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 自定义图片1*/
    self.pageController1.pageControlStyle = PageControlStyleThumb;
    self.pageController1.numberOfPages = 5;
    self.pageController1.currentPage = 3;
    self.pageController1.currentPageThumbImage = [UIImage imageNamed:@"WBZ_pageController_select"];
    self.pageController1.pageThumbImage = [UIImage imageNamed:@"WBZ_pageController_normal"];
    self.pageController1.clickThePageBlock = ^(NSInteger currentPage) {
        NSLog(@"++++++++++++++++ %ld",currentPage);
    };
    
    /** 自定义图片2*/
    self.pageController2.pageControlStyle = PageControlStyleThumb;
    self.pageController2.numberOfPages = 4;
    self.pageController2.currentPage = 1;
    self.pageController2.currentPageThumbImage = [UIImage imageNamed:@"LaunchGuide_derect_highlight"];
    self.pageController2.pageThumbImage = [UIImage imageNamed:@"LaunchGuide_derect_default"];
    
    /** 数字*/
    self.pageController3.pageControlStyle = PageControlStyleWithPageNumber;
    self.pageController3.numberOfPages = 4;
    self.pageController3.currentPage = 1;
    self.pageController3.gapWidth = 22;
    self.pageController3.numberNormalTextColor = [UIColor redColor];
    self.pageController3.numberCurrentTextColor = [UIColor greenColor];
    self.pageController3.numberCurrentBgColor = [UIColor redColor];
    self.pageController3.numberNormalBgColor = [UIColor purpleColor];
    
    /** 默认*/
    self.pageController4.pageControlStyle = PageControlStyleDefault;
    self.pageController4.numberOfPages = 5;
    self.pageController4.currentPage = 3;
    self.pageController4.strokeWidth = 10;
    self.pageController4.pageIndicatorColor = [UIColor redColor];
    self.pageController4.currentPageIndicatorColor = [UIColor orangeColor];
    
    /** 空心圆*/
    self.pageController5.pageControlStyle = PageControlStyleStrokedCircle;
    self.pageController5.numberOfPages = 5;
    self.pageController5.currentPage = 3;
    self.pageController5.strokeWidth = 5;
    self.pageController5.pageIndicatorColor = [UIColor redColor];
    self.pageController5.currentPageIndicatorColor = [UIColor orangeColor];

    self.pageController5.strokeNormalColor = [UIColor purpleColor];
    self.pageController5.strokeSelectedColor = [UIColor greenColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
