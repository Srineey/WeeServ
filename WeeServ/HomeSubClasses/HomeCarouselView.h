//
//  HomeCarouselView.h
//  WeeServ
//
//  Created by saran c on 12/06/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCarouselView : UIView <UIScrollViewDelegate>
{
    UIImageView *sliderImgView;
    UIScrollView *pageControlScrl;
    UIPageControl *pageControl;
    
    int viewWidth;
}

- (void)homeSliderView:(NSArray *)sliderImagesArray;

@end
