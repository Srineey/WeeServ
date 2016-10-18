//
//  HomeCarouselView.m
//  WeeServ
//
//  Created by saran c on 12/06/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "HomeCarouselView.h"
#import "UIImageView+WebCache.h"

@implementation HomeCarouselView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self    =   [super initWithFrame:frame];
    
    viewWidth = self.frame.size.width;
    
    [self setUI];
    
    return self;
}

- (void)setUI
{
    pageControlScrl = [[UIScrollView alloc] init];
    [pageControlScrl setFrame:CGRectMake(0, 0, viewWidth, self.frame.size.height)];
    [pageControlScrl setBackgroundColor:[UIColor clearColor]];
    [pageControlScrl setShowsVerticalScrollIndicator:NO];
    [pageControlScrl setShowsHorizontalScrollIndicator:NO];
    [self addSubview:pageControlScrl];
}

- (void)homeSliderView:(NSArray *)sliderImagesArray
{
    int xPos = 0;
    
    @autoreleasepool
    {
        for(int i = 0; i < [sliderImagesArray count]; i++)
        {
            NSString *stringUrl = [sliderImagesArray objectAtIndex:i];
            sliderImgView = [[UIImageView alloc] init];
            [sliderImgView setFrame:CGRectMake(xPos, 0, viewWidth, self.frame.size.height)];
            [sliderImgView setBackgroundColor:[UIColor clearColor]];
            [sliderImgView setContentMode:UIViewContentModeScaleAspectFill];
            [sliderImgView sd_setImageWithURL:[NSURL URLWithString:stringUrl] placeholderImage:[UIImage imageNamed:@"noimagePlaceholder.jpg"] ];
            [pageControlScrl addSubview:sliderImgView];
            
            xPos += viewWidth;
        }
        
        if (pageControl) {
            [pageControl removeFromSuperview];
        }
        pageControl = [[UIPageControl alloc] init];
        pageControl.frame = CGRectMake(0 , pageControlScrl.frame.size.height - 30, viewWidth, 20);
        
        pageControl.numberOfPages = [sliderImagesArray count];
        
        pageControl.backgroundColor = [UIColor clearColor];
        pageControl.currentPage = 0;
        pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
        pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        
        [self addSubview:pageControl];
        [pageControlScrl setBounces:NO];
        pageControlScrl.contentSize = CGSizeMake(viewWidth*[sliderImagesArray count], self.frame.size.height);
        [pageControlScrl setPagingEnabled:YES];
        pageControlScrl.delegate = self;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = pageControlScrl.frame.size.width;
    int page = floor((pageControlScrl.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//    currentPage = page;
    pageControl.currentPage = page;
}

@end
