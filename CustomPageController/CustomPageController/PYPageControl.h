//
//  PYPageControl.h
//  PYFrameworks
//
//  Created by CBB on 14/12/1.
//  Copyright (c) 2014年 储彬彬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    PageControlStyleDefault = 0,
    /** 空心圆*/
    PageControlStyleStrokedCircle = 1,
    /** 圆点中加入数字*/
    PageControlStyleWithPageNumber = 2,
    /** 自定义图片*/
    PageControlStyleThumb = 3
} PageControlStyle;

/**
 *  自定义UIPageControl，可指定图片，颜色
 */
@interface PYPageControl : UIControl
{
    NSInteger _numberOfPages;
    NSInteger _currentPage;
    PageControlStyle _pageControlStyle;
}

/**********************  共有属性 **************************/
/**  选中页码(必需) */
@property (nonatomic, assign) NSInteger currentPage;

/**  总页码(必需) */
@property (nonatomic, assign) NSInteger numberOfPages;

/** 选择的类型(可选)*/
@property (nonatomic, assign) PageControlStyle pageControlStyle;

/**  当只有一页时是否隐藏(可选) */
@property (nonatomic, assign) BOOL hidesForSinglePage;

/** 圆点直径,default = 12 (包含边框) (可选) */
@property (nonatomic, assign) NSInteger diameter;

/** 两个圆点间距,default = 10  (可选)*/
@property (nonatomic, assign) NSInteger gapWidth;


@property (nonatomic, copy) void(^clickThePageBlock)(NSInteger currentPage);


/**  页码标识的颜色 */
@property (nonatomic, strong) UIColor *pageIndicatorColor;
/**  当前选中页码标识的颜色 */
@property (nonatomic, strong) UIColor *currentPageIndicatorColor;


/**********************  空心圆点需要的 **************************/
/**边框大小, default = 0 */
@property (nonatomic, assign) NSInteger strokeWidth;

/**页码边框颜色，默认与pageIndicatorColor相同 */
@property (nonatomic, strong) UIColor *strokeNormalColor;

/** 选中页码边框颜色，默认与currentPageIndicatorColor相同 */
@property (nonatomic, strong) UIColor *strokeSelectedColor;


/**********************  圆点数字需要的 **************************/

/**  圆点数字 - 当前文字的颜色  默认-黑色*/
@property (nonatomic, strong) UIColor *numberNormalTextColor;

/**  圆点数字 - 当前文字的颜色  默认-黑色*/
@property (nonatomic, strong) UIColor *numberCurrentTextColor;

/**  圆点数字 - 当前文字的背景色  默认-gray*/
@property (nonatomic, strong) UIColor *numberCurrentBgColor;

/**  圆点数字 - 当前文字的背景色  默认-透明色*/
@property (nonatomic, strong) UIColor *numberNormalBgColor;



/**********************  自定义图片需要的 **************************/

/** 自定义页码图片 - 未选中的图片*/
@property (nonatomic, strong) UIImage *pageThumbImage;

/** 自定义页码图片 - 当前页面图片*/
@property (nonatomic, strong) UIImage *currentPageThumbImage;



@end
