//
//  PYPageControl.m
//  PYFrameworks
//
//  Created by 储彬彬 on 14/12/1.
//  Copyright (c) 2014年 储彬彬. All rights reserved.
//

#import "PYPageControl.h"

// 颜色
static inline UIColor *RGBA(int R, int G, int B, double A) {
    return [UIColor colorWithRed: R/255.0 green: G/255.0 blue: B/255.0 alpha: A];
}

static inline UIColor *HexColorA(int v, double A) {
    return RGBA((double)((v&0xff0000)>>16), (double)((v&0xff00)>>8), (double)(v&0xff), A);
}

@interface PYPageControl ()

@end

@implementation PYPageControl
@synthesize numberOfPages=_numberOfPages;
@synthesize currentPage=_currentPage;
@synthesize pageControlStyle=_pageControlStyle;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setup
{
    self.strokeWidth = 0.0;
    self.gapWidth = 10.0;
    self.diameter = 12.0;
    self.hidesForSinglePage = NO;
    self.pageControlStyle = PageControlStyleDefault;
    self.pageIndicatorColor =  RGBA(128, 130, 133, 1);
    self.currentPageIndicatorColor = RGBA(51, 51, 51, 1.0);
    self.strokeNormalColor =  RGBA(128, 130, 133, 1.0);
    
    self.numberCurrentTextColor = [UIColor blackColor];
    self.numberNormalTextColor = [UIColor blackColor];
    self.numberCurrentBgColor = HexColorA(0x000000, 0.3);
    self.numberNormalBgColor = [UIColor clearColor];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapped:)];
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)onTapped:(UITapGestureRecognizer*)gesture
{
    CGPoint touchPoint = [gesture locationInView:[gesture view]];
    
    if (touchPoint.x < self.frame.size.width/2)
    {
        if (self.currentPage>0)
        {
            self.currentPage -= 1;
        }
    }
    else
    {
        if (self.currentPage<self.numberOfPages-1)
        {
            self.currentPage += 1;
        }
    }
    
    
    if (self.clickThePageBlock) {
        self.clickThePageBlock(self.currentPage);
    }
    [self setNeedsDisplay];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}


- (void)drawRect:(CGRect)rect
{
    if (self.hidesForSinglePage && self.numberOfPages==1) {
        return;
    }
    
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    if (self.pageControlStyle == PageControlStyleDefault)
    {
        if (self.pageThumbImage && self.currentPageThumbImage)
        {
            self.diameter = self.pageThumbImage.size.width;
        }
    }
    
    
    NSInteger total_width = _numberOfPages*self.diameter + (_numberOfPages-1) *_gapWidth;
    if (total_width>self.frame.size.width)
    {
        while (total_width>self.frame.size.width)
        {
            _diameter -= 2;
            _gapWidth = _diameter + 2;
            while (total_width>self.frame.size.width)
            {
                _gapWidth -= 1;
                total_width = _numberOfPages*_diameter + (_numberOfPages-1)*_gapWidth;
                
                if (_gapWidth==2)
                {
                    break;
                }
            }
            
            if (_diameter==2)
            {
                break;
            }
        }
    }
    
    
    for (NSInteger i = 0; i < _numberOfPages; i++)
    {
        NSInteger x = (self.frame.size.width - total_width)/2 + i*(_diameter+_gapWidth);
        if (self.pageControlStyle==PageControlStyleDefault) {

            if (i==_currentPage)
            {
                CGContextSetFillColorWithColor(myContext, [_currentPageIndicatorColor CGColor]);
                CGContextFillEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-_diameter)/2,_diameter,_diameter));
                if (_strokeWidth > 0) {
                    CGContextSetStrokeColorWithColor(myContext, [_strokeSelectedColor CGColor]);
                    CGContextStrokeEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-_diameter)/2,_diameter,_diameter));
                }
            } else {
                CGContextSetFillColorWithColor(myContext, [_pageIndicatorColor CGColor]);
                CGContextFillEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-_diameter)/2,_diameter,_diameter));
                if (_strokeWidth > 0) {
                    CGContextSetStrokeColorWithColor(myContext, [_strokeNormalColor CGColor]);
                    CGContextStrokeEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-_diameter)/2,_diameter,_diameter));
                }
            }
        } else if (self.pageControlStyle == PageControlStyleStrokedCircle) {
            
            CGContextSetLineWidth(myContext, _strokeWidth);
            if (i==_currentPage) {
                CGContextSetFillColorWithColor(myContext, [_currentPageIndicatorColor CGColor]);
                CGContextFillEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-_diameter)/2,_diameter,_diameter));
                
                CGContextSetStrokeColorWithColor(myContext, [_strokeSelectedColor CGColor]);
                CGContextStrokeEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-_diameter)/2,_diameter,_diameter));
            } else {
                
                CGContextSetFillColorWithColor(myContext, [_pageIndicatorColor CGColor]);
                CGContextFillEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-_diameter)/2,_diameter,_diameter));
                
                CGContextSetStrokeColorWithColor(myContext, [_strokeNormalColor CGColor]);
                CGContextStrokeEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-_diameter)/2,_diameter,_diameter));
            }
            
        } else if (self.pageControlStyle == PageControlStyleThumb) {
            //占用的总体宽度
            total_width = self.currentPageThumbImage.size.width + self.pageThumbImage.size.width * (self.numberOfPages - 1) + self.gapWidth *(self.numberOfPages - 1);
            
            x = (self.frame.size.width - total_width)/2;
            
            CGFloat y = (self.frame.size.height-self.currentPageThumbImage.size.height)/2;
            
            if (self.pageThumbImage && self.currentPageThumbImage)
            {
                if (i==_currentPage)
                {
                    x = x + _currentPage * (self.pageThumbImage.size.width + self.gapWidth);
                    [self.currentPageThumbImage drawInRect:CGRectMake(x,y,self.currentPageThumbImage.size.width,self.currentPageThumbImage.size.height)];
                }
                else
                {
                    if (i < _currentPage) {
                       x = x + i * (self.pageThumbImage.size.width + self.gapWidth);
                    } else {
                       x = x + (self.currentPageThumbImage.size.width + self.gapWidth) + (self.pageThumbImage.size.width + self.gapWidth) * (i - 1);
                    }
            
                    [self.pageThumbImage drawInRect:CGRectMake(x,y,self.pageThumbImage.size.width,self.pageThumbImage.size.height)];
                }
            }
            
        } else if (_pageControlStyle==PageControlStyleWithPageNumber) {
            
            NSString *pageNumber = [NSString stringWithFormat:@"%ld", (long)i+1];
            
            int _currentPageDiameter = _diameter* 1.5;
            x = (self.frame.size.width-total_width)/2 + i*(_diameter+_gapWidth) ;
            
            UIColor *bgColor = nil;
            UIColor *textColor = nil;
            if (i==_currentPage) {
                bgColor = _numberCurrentBgColor;
                textColor = _numberCurrentTextColor;
            } else {
                bgColor = _numberNormalBgColor;
                textColor = _numberNormalTextColor;
            }
            //设置背景色
            CGContextSetFillColorWithColor(myContext, [bgColor CGColor]);
            CGContextFillEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-_currentPageDiameter)/2,_currentPageDiameter,_currentPageDiameter));
            
            //设置文字的属性
            NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
            paragraphStyle.alignment = NSTextAlignmentCenter;
            
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:_currentPageDiameter-2],NSForegroundColorAttributeName:textColor,NSParagraphStyleAttributeName:paragraphStyle};
            [pageNumber drawInRect:CGRectMake(x,(self.frame.size.height-_currentPageDiameter)/2-1,_currentPageDiameter,_currentPageDiameter) withAttributes:attributes];
        }
    }
}


- (PageControlStyle)pageControlStyle
{
    return _pageControlStyle;
}

- (void)setPageControlStyle:(PageControlStyle)style
{
    _pageControlStyle = style;
    [self setNeedsDisplay];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    
    [self setNeedsDisplay];
}

- (NSInteger)numberOfPages
{
    return _numberOfPages;
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    [self setNeedsDisplay];
}

- (NSInteger)currentPage
{
    return _currentPage;
}



@end
