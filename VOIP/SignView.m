//
//  SignView.m
//  Move
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SignView.h"
#import "LewPopupViewAnimationDrop.h"

@interface SignView( )

@property (nonatomic, retain)UIView*shareView1;



@end


@implementation SignView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)dealloc{
    [super dealloc];
    [_centersignLabel3 release];
    [_shareView1 release];
    
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = frame;
        
        UIImageView*centersignImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"signpage_bg_img"]];
        centersignImageView.frame = CGRectMake(0, 0, 267*kDeviceWidth/375.0, 242*kDeviceWidth/375.0);
        centersignImageView.userInteractionEnabled = YES;
        
        UILabel*centersignLabel = [[UILabel alloc]init];
        centersignLabel.font = [UIFont systemFontOfSize:25.0];
        centersignLabel.text = @"签到成功";
        centersignLabel.textColor = CHANGEColorWith(0x3b6cde,1.0);
        CGSize textSize = [centersignLabel.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:25.0] }];
        centersignLabel.bounds = CGRectMake(0, 0, textSize.width, textSize.height);
        centersignLabel.center = CGPointMake(centersignImageView.center.x, 49*kDeviceWidth/375.0);
        centersignLabel.textAlignment = NSTextAlignmentCenter;
        
        UILabel*centersignLabel1 = [[UILabel alloc]init];
        centersignLabel1.font = [UIFont systemFontOfSize:25.0];
        
        NSString*minuteStr1 = [NSString stringWithFormat:@"+%@",@"10"];
        // centersignLabel1.text = @"0";
        centersignLabel1.textColor = [UIColor redColor];
        CGSize centetextSize1 = [minuteStr1 sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:25.0] }];
        centersignLabel1.bounds = CGRectMake(0, 0, centetextSize1.width, centetextSize1.height);
        centersignLabel1.center = CGPointMake(centersignImageView.center.x-centetextSize1.width/2 - 5, centersignLabel.frame.origin.y+textSize.height+centetextSize1.height - 5*375.0/kDeviceWidth);
        centersignLabel1.textAlignment = NSTextAlignmentRight;
        self.centersignLabel3 = centersignLabel1;
        NSLog(@"ssbbbb%@",centersignLabel1);
        
        UILabel*centersignLabel2 = [[UILabel alloc]init];
        centersignLabel2.font = [UIFont systemFontOfSize:17.0];
        centersignLabel2.textColor = CHANGEColorWith(0x7c99d6,1.0);
        centersignLabel2.text = @"分钟";
        CGSize centetextSize2 = [centersignLabel2.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:17.0] }];
        centersignLabel2.bounds = CGRectMake(0, 0, centetextSize2.width, centetextSize2.height);
        centersignLabel2.center = CGPointMake(centersignImageView.center.x+centetextSize2.width/2, centersignLabel1.frame.origin.y+centetextSize1.height - centetextSize2.height/2 - 2);
        
        UIButton *viewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        viewButton.frame = CGRectMake(self.frame.size.width - 31 - 29, 8, 29, 29);
        
        [viewButton setBackgroundImage:[UIImage imageNamed:@"signpage_icon_close_n"] forState:UIControlStateNormal];
        [viewButton setBackgroundImage:[UIImage imageNamed:@"signpage_icon_close_s-_s"] forState:UIControlStateHighlighted];
        [viewButton addTarget:self action:@selector(CloseAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *viewButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        viewButton1.bounds = CGRectMake(0, 0, self.frame.size.width - 2*(69*kDeviceWidth/375.0), 25*kDeviceWidth/375.0);
        viewButton1.center = CGPointMake(centersignImageView.center.x, centersignImageView.frame.size.height - 55*kDeviceWidth/375.0);
        viewButton1.tag = 1;
        [viewButton1 setBackgroundImage:[UIImage imageNamed:@"signpage_btn_share_n"] forState:UIControlStateNormal];
        [viewButton1 setBackgroundImage:[UIImage imageNamed:@"signpage_btn_share_s"] forState:UIControlStateHighlighted];
        [viewButton1 addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [self addSubview:centersignImageView];
        [self addSubview:centersignLabel];
        [self addSubview:centersignLabel1];
        [self addSubview:centersignLabel2];
        [self addSubview:viewButton];
        [self addSubview:viewButton1];
        [centersignImageView release];
        [centersignLabel release];
        [centersignLabel1 release];
        [centersignLabel2 release];
        [viewButton release];
        [viewButton1 release];
        
        
    }
    return self ;
}

+ (instancetype)defaultPopupView{
    
    return [[SignView alloc]initWithFrame:CGRectMake(0, 0, 267*kDeviceWidth/375.0, 242*kDeviceWidth/375.0)];
}

-(void)CloseAction:(UIButton*)sender{
    [_parentVC lew_dismissPopupViewWithanimation:[LewPopupViewAnimationDrop new]];
    
}

-(void)shareAction:(UIButton*)sender{
    if (sender.tag == 1) {
        sender.tag = 2;
        
        if (_shareView1) {
            
            _shareView1.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y+sender.frame.size.height, sender.frame.size.width,  sender.frame.size.height *4);
            
            [self addSubview:_shareView1];
        }else{
            CGRect rect = self.frame;
            rect.size.height = self.frame.size.height+50.0;
            
            self.frame = rect;
            
            
            UIView*shareView = [[UIView alloc]initWithFrame:CGRectMake(sender.frame.origin.x, sender.frame.origin.y+sender.frame.size.height, sender.frame.size.width, sender.frame.size.height *4)];
            shareView.backgroundColor = [UIColor redColor];
            UIImageView*shareImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sign_share_bg"]];
            shareImageView.frame = CGRectMake(0, 0, sender.frame.size.width, sender.frame.size.height *4);
            //[shareView addSubview:shareImageView];
            for (int i = 0; i < 4; i ++) {
                float kx ;
                float ky ;
                kx = 0;
                ky = i*sender.frame.size.height;
                
                UIButton *downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [downBtn setFrame:CGRectMake(0, ky, sender.frame.size.width, sender.frame.size.height)];
                downBtn.tag = i+1;
                [downBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"share_%d_n",i+1]] forState:UIControlStateNormal];
                [downBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"share_%d_s",i+1]] forState:UIControlStateHighlighted];
                //downBtn.backgroundColor = [UIColor whiteColor];
                [downBtn addTarget:self action:@selector(shareAction1:) forControlEvents:UIControlEventTouchUpInside];
                [shareView addSubview:downBtn];
                [downBtn release];
                
            }
            
            _shareView1 = shareView;
            
            [self addSubview:shareView];
            [shareView release];
        }
        
    }else{
        sender.tag = 1;
        
        _shareView1.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y+sender.frame.size.height, sender.frame.size.width, 0);
        _shareView1.clipsToBounds = YES;
    }
    
}

-(void)shareAction1:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(signView: tag:) ]) {
        [self.delegate signView:self tag:sender.tag];
    }
}





@end
