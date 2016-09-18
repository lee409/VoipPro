//
//  GetFeeView.h
//  VOIP
//
//  Created by hermit on 15/5/6.
//  Copyright (c) 2015年 apple. All rights reserved.
//
#define COINPOINT_OFFSET
#import <UIKit/UIKit.h>

@protocol GetFeeViewDelegate <NSObject>

-(void)getFeeCoinAnimationFinished;

@end
@class coinImageView;
@class ParticleEmitter3D;

@interface GetFeeView : UIView
{
    EAGLContext         *context;
    GLuint              viewRenderbuffer, viewFramebuffer;
    GLint               backingWidth;
    GLint               backingHeight;
    GLuint              depthRenderbuffer;
    bool                bDrawPraticle;
    UILabel             *textlabel;
    NSTimer             *coinTimer;
    
    int                 coinTotleNum;
    int                 curCoinNum;
    CGPoint             coinPoint;
    int                 iticktime;

}


@property (retain, nonatomic) IBOutlet UIView *innerView;
+ (instancetype)defaultPopupView;

@property (nonatomic,strong) NSMutableArray                 *emitters;
@property (nonatomic,strong) NSMutableArray                 *images;
@property (nonatomic,strong) NSMutableArray                 *deleteemitters;
@property (nonatomic,strong) NSMutableArray                 *deleteimages;
@property (nonatomic,weak) id<GetFeeViewDelegate>             getFeedelegate;

-(void)initOpenGl;
-(BOOL)createFramebuffer;
-(void)destroyFramebuffer;
-(void)createmitter:(CGPoint) point;
-(void)creatimage:(CGPoint) point;
-(void)close;
@property (nonatomic, weak)UIViewController *parentVC;

@end
