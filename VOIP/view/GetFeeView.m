//
//  GetFeeView.m
//  VOIP
//
//  Created by hermit on 15/5/6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "GetFeeView.h"
#import "UIViewController+LewPopupViewController.h"
#import "LewPopupViewAnimationDrop.h"
#import "LewPopupViewAnimationSlide.h"
#import "OpenGLTexture3D.h"
#import "ParticleEmitter3D.h"
#import "coinImageView.h"
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
@interface GetFeeView ()

@end

@implementation GetFeeView

@synthesize emitters;
@synthesize images;
@synthesize deleteemitters;
@synthesize deleteimages;
@synthesize getFeedelegate;

- (void)dealloc
{
    
    if([EAGLContext currentContext] == context)
    {
        [EAGLContext setCurrentContext:nil];
    }
    
    context = nil;
    
    [self destroyFramebuffer];
    
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil];
        _innerView.frame = frame;
        [self setMultipleTouchEnabled:YES];
        self.userInteractionEnabled = YES;
        iticktime = 0;
        getFeedelegate = nil;
        
        curCoinNum = 0;
        coinTotleNum = 20;
        coinPoint = CGPointMake(frame.size.width / 2 - 20.0f, 0.0f);
        emitters = [[NSMutableArray alloc] init];
        images = [[NSMutableArray alloc] init];
        deleteemitters = [[NSMutableArray alloc] init];
        deleteimages = [[NSMutableArray alloc] init];
        
        [self initOpenGl];
        
        coinTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"bgm_coin_01" ofType:@"mp3"];
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
        AudioServicesPlaySystemSound (soundID);
        
        [self addSubview:_innerView];
        
    }
    return self;
}

+ (instancetype)defaultPopupView{
    return [[GetFeeView alloc]initWithFrame:CGRectMake(0, 0, 313, 268)];
}

// Clean up any buffers we have allocated.
- (void)timerFired:(id)sender
{
    
   
    
    CGRect rwindow = [[UIScreen mainScreen] bounds];
    
    if(curCoinNum < coinTotleNum && iticktime > 1)
    {
        
        
       
        for (int i = 0; i < 4; i++)
        {
            [self creatimage:coinPoint];
            [self createmitter:coinPoint];
            
            if(coinPoint.x > rwindow.size.width / 2)
            {
                coinPoint.x -= arc4random() % 150;
                coinPoint.y -= arc4random() % 50;
            }
            else
            {
                coinPoint.x += arc4random() % 150;
                coinPoint.x += arc4random() % 50;
            }
        }
            
        ++curCoinNum;
        
        
        iticktime = 0;
    }
    else
    {
        ++iticktime;
    }
    
    for (__strong coinImageView *delview in deleteimages)
    {
        [images removeObject:delview];
        delview = nil;
    }
    
    [deleteimages removeAllObjects];
    
    for (__strong ParticleEmitter3D *delemitter in deleteemitters)
    {
        [emitters removeObject:delemitter];
        [delemitter stopEmitting];
        delemitter = nil;
    }
    
    [deleteemitters removeAllObjects];
    
    for (coinImageView *view in images)
    {
        [view tick];
        
        CGRect r = [view frame];
        if(r.origin.y > rwindow.size.height)
        {
            [deleteimages addObject:view];
        }
    }
    
    if(bDrawPraticle)
    {
        glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
        
        glColor4f(0.0, 0.0, 0.0, 0.0);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        
        for (ParticleEmitter3D *pemitter in emitters)
        {
            if (pemitter != nil)
            {
                Vertex3D pd = [pemitter position];
                
                pd.y -= 20 / rwindow.size.height * 2.0f;
                [pemitter setPosition:pd];
                [pemitter drawSelf];
                
                if (pd.y < -1.0f)
                {
                    [deleteemitters addObject:pemitter];
                }
            }
        }
        
        glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
        [context presentRenderbuffer:GL_RENDERBUFFER_OES];
        
    }
    
    if(curCoinNum == coinTotleNum && [images count] == 0 && [emitters count] == 0)
    {
        [coinTimer invalidate];
        coinTimer = nil;
        
        if(getFeedelegate != nil)
        {
            [getFeedelegate getFeeCoinAnimationFinished];
        }
    }
}

-(void)initOpenGl
{
    CAEAGLLayer *eaglLayer = (CAEAGLLayer*) self.layer;
    
    // Configure it so that it is opaque, does not retain the contents of the backbuffer when displayed, and uses RGBA8888 color.
    eaglLayer.opaque = NO;
    eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking,
                                    kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat,
                                    nil];
    
    // Create our EAGLContext, and if successful make it current and create our framebuffer.
    context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    if(!context || ![EAGLContext setCurrentContext:context] || ![self createFramebuffer])
    {
        bDrawPraticle = false;
    }
    else
    {
        const GLfloat zNear = 0.01, zFar = 1000.0, fieldOfView = 45.0;
        GLfloat size;
        glEnable(GL_DEPTH_TEST);
        glMatrixMode(GL_PROJECTION);
        size = zNear * tanf(DEGREES_TO_RADIANS(fieldOfView) / 2.0);
        CGRect rect = self.bounds;
        glFrustumf(-size, size, -size / (rect.size.width / rect.size.height), size /
                   (rect.size.width / rect.size.height), zNear, zFar);
        glViewport(0, 0, rect.size.width, rect.size.height);
        glMatrixMode(GL_MODELVIEW);
        
        glEnable (GL_BLEND);
        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA) ;
        glEnable(GL_POINT_SMOOTH);
        
        glLoadIdentity();
        
        bDrawPraticle = true;
    }
    
}

- (BOOL)createFramebuffer
{
    // Generate IDs for a framebuffer object and a color renderbuffer
    glGenFramebuffersOES(1, &viewFramebuffer);
    glGenRenderbuffersOES(1, &viewRenderbuffer);
    
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
    // This call associates the storage for the current render buffer with the EAGLDrawable (our CAEAGLLayer)
    // allowing us to draw into a buffer that will later be rendered to screen whereever the layer is (which corresponds with our view).
    [context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(id<EAGLDrawable>)self.layer];
    glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, viewRenderbuffer);
    
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
    
    // For this sample, we also need a depth buffer, so we'll create and attach one via another renderbuffer.
    glGenRenderbuffersOES(1, &depthRenderbuffer);
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, depthRenderbuffer);
    glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, backingWidth, backingHeight);
    glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, depthRenderbuffer);
    
    if(glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES)
    {
        NSLog(@"failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
        return NO;
    }
    
    return YES;
}

// Clean up any buffers we have allocated.
- (void)destroyFramebuffer
{
    glDeleteFramebuffersOES(1, &viewFramebuffer);
    viewFramebuffer = 0;
    glDeleteRenderbuffersOES(1, &viewRenderbuffer);
    viewRenderbuffer = 0;
    
    if(depthRenderbuffer)
    {
        glDeleteRenderbuffersOES(1, &depthRenderbuffer);
        depthRenderbuffer = 0;
    }
}

+ (Class) layerClass
{
    return [CAEAGLLayer class];
}

-(void)createmitter:(CGPoint)point
{
    CGRect rc = [[UIScreen mainScreen] bounds];
    
    point.x = point.x * 1.6f / rc.size.width - 0.7f;
    point.y = point.y * 2.0f / rc.size.height - 0.85f;
    
    point.y = -point.y;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"stars2" ofType:@"png"];
    OpenGLTexture3D *texture = [[OpenGLTexture3D alloc] initWithFilename:path width:16 height:16];
    ParticleEmitter3D *pEmitter = [[ParticleEmitter3D alloc] initWithName:@"jj"
                                                                 position:Vertex3DMake(point.x,point.y, -2.0)
                                                                 rotation:Rotation3DMake(0.0, 0.0, 0.0)
                                                          azimuthVariance:35.0f
                                                            pitchVariance:35.0f
                                                                    speed:1.0
                                                            speedVariance:0.2
                                                       particlesPerSecond:15.0f
                                               particlesPerSecondVariance:10.0f
                                                         particleLifespan:3.0
                                                 particleLifespanVariance:1.0
                                                               startColor:Color3DMake(1.0, 0.98, 0.0, 1.0)
                                                       startColorVariance:Color3DMake(0.0, 0.0, 0.0, 0.0)
                                                              finishColor:Color3DMake(1.0, 0.98, 0.0, 1.0)
                                                      finishColorVariance:Color3DMake(0.0, 0.0, 0.0, 1.0)
                                                                    force:Vector3DMake(0.0, 0.0, .0)
                                                            forceVariance:Vector3DMake(0.2, 0.1, 0.2)
                                                                     mode:ParticleEmitter3DDrawTextureMap
                                                             particleSize:2.0f
                                                     particleSizeVariance:2.0f
                                                                  texture:texture] ;
    
    
    [pEmitter startEmitting];
    
    [emitters addObject:pEmitter];
}

-(void)creatimage:(CGPoint)point
{
    coinImageView* view = [[coinImageView alloc]initWithFrame:CGRectMake(point.x, point.y, 30, 20)];
    [self.innerView addSubview:view];
      [images addObject:view];
}

- (void)close
{
    LewPopupViewAnimationSlide *animation = [[LewPopupViewAnimationSlide alloc]init];
    animation.type = LewPopupViewAnimationSlideTypeTopBottom;
    [_parentVC lew_dismissPopupViewWithanimation:animation];
}
//如果有对父类addsubview的回调请替换此方法
-(void)layoutSubviews
{
    [self.superview bringSubviewToFront:self];
}


@end
