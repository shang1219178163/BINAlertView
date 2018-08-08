
//
//  UIImageView+Helper.m
//  ChildViewControllers
//
//  Created by BIN on 2018/1/16.
//  Copyright © 2018年 BIN. All rights reserved.
//

#import "UIImageView+Helper.h"

#import "UIImage+Helper.m"
#import "FLAnimatedImage.h"

#import "UIImageView+WebCache.h"

@implementation UIImageView (Helper)

- (void)startAnimationShowType:(NSString *)type imageArr:(NSArray *)imageArr{
    
    switch ([type integerValue]) {
        case 0:
        {
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
            animation.fromValue = [NSNumber numberWithFloat:0.f];
            animation.toValue = [NSNumber numberWithFloat: M_PI *2];
            animation.duration = 3;
            animation.autoreverses = NO;
            animation.fillMode = kCAFillModeForwards;
            animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
            [self.layer addAnimation:animation forKey:nil];
//            [self.layer removeAllAnimations];//停止动画 即可。 0
        }
            break;
        case 1:
        {
            [self startAnimationWithImageArr:imageArr];
        }
            break;
        case 2:
        {
            self.transform = CGAffineTransformRotate(self.transform, M_PI_2);

        }
            break;
        default:
            break;
    }
}

- (void)startAnimationWithImageArr:(NSArray *)imageArr{
    
    if (!self.image) {
        self.image = [UIImage imageNamed:[imageArr firstObject]];
        
    }
    
    [UIView transitionWithView:self duration:1.5f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        self.tag++;
        UIImage *image = (self.tag % 2 == 0) ? [UIImage imageNamed:[imageArr firstObject]] : [UIImage imageNamed:[imageArr lastObject]];
        self.image = image;
        
    } completion:^(BOOL finished) {
        NSLog(@"图像翻转完成");
        [self startAnimationWithImageArr:imageArr];
        
    }];
}

+(UIImageView *)imgViewWithRect:(CGRect)rect imageList:(NSArray *)imageList type:(NSNumber *)type{
    
    UIImageView *imgView = nil;
    switch ([type integerValue]) {
        case 0:
        {
            UIImage *image = [[UIImage imageNamed:[imageList firstObject]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            image = [UIImage imageNamed:[imageList firstObject]];
            imgView = [[UIImageView alloc] initWithImage:image];
            imgView.frame = rect;
            
            CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            anima.toValue = @(M_PI*2);
            anima.duration = 1.0f;
            anima.repeatCount = 10;
            [imgView.layer addAnimation:anima forKey:nil];
        }
            break;
        case 1:
        {
            UIImage * image = [UIImage imageNamed:[imageList firstObject]];
            
            imgView = [[UIImageView alloc] initWithFrame:rect];
            imgView.image = image;
            NSMutableArray *marr = [NSMutableArray arrayWithCapacity:0];
            for (NSInteger i = 0; i < imageList.count; i++) {
                UIImage *image = [UIImage imageNamed:imageList[i]];
                [marr addObject:image];
            }
            
            imgView.animationImages = marr;
            imgView.animationDuration = 0.8;
            imgView.animationRepeatCount = 0;
            [imgView startAnimating];
        }
            break;
        case 2:
        {
            NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]]pathForResource:@"loading" ofType:@"gif"];
            FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:filePath]];
            imgView = [[FLAnimatedImageView alloc] initWithFrame:rect];
            ((FLAnimatedImageView *)imgView).animatedImage = image;
        }
            break;
        default:
            break;
    }
    return imgView;
}

- (void)BN_addCorner:(CGFloat)radius{
    UIImage * image = [self.image imageAddCornerWithRadius:radius andSize:self.bounds.size];
    self.image = image;
}


- (void)loadImage:(id)image type:(NSNumber *)type{
    switch ([type integerValue]) {
        case 1:
            [self loadImage:image imageDefault:kIMAGE_default_User];

            break;
        default:
            [self loadImage:image imageDefault:kIMAGE_default_failed_S];

            break;
    }
    
}
    
- (void)loadImage:(id)image imageDefault:(NSString *)imageDefault{
    
    if ([image isKindOfClass:[UIImage class]]) {
        self.image = image;
        return;
    }

    if ([image isKindOfClass:[NSString class]]) {
        if (![image validObject]) {
            self.image = [UIImage imageNamed:imageDefault];
            return;
        }
//        if ([image containsString:@"/"]) image = [WHKRequestHelper getImageUrlWithImageName:image];
        if ([image hasPrefix:@"http"]) {
            self.image = [UIImage imageNamed:imageDefault];//占位
            
            imageDefault = imageDefault ? : kIMAGE_default_failed_S;//
            [self sd_setImageWithURL:image placeholderImage:[UIImage imageNamed:imageDefault]];//
            
        }
        else{
            self.image = [UIImage imageNamed:image];
            
        }
    }
    else{
        NSParameterAssert([image isKindOfClass:[NSString class]] || [image isKindOfClass:[UIImage class]]);
        
    }
    
}


@end
