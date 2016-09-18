//
//  PayMoneyViewController.m
//  VOIP
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PayMoneyViewController.h"
#import "PayMoneyTableViewCell.h"
#import "PayMoneyTableViewCell1.h"
#import "PayMoney1ViewController.h"
#import "PayMoneyTableViewCell2.h"
@interface PayMoneyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *myTableView;
@end

@implementation PayMoneyViewController
-(void)dealloc{
    [super dealloc];
   // [_myTableView release];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addAavigationView:@"在线充值" aback:nil];
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight - 49) style:UITableViewStylePlain];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.myTableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }
    
    if (indexPath.section == 2) {
        return 400;
    }
    return 63;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 10;
    }else if (section == 2){
        return 10;
    }
    
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 2) {
        return 1;
        
    }
    return 6;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentfier =@"Paycell";
   static NSString *cellIndentfier1 =@"Paycell1";
    static NSString *cellIndentfier2 =@"Paycell2";
    if (indexPath.section == 0) {
        
            PayMoneyTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIndentfier];
            if (!cell)
            {
                cell =[[[NSBundle mainBundle]loadNibNamed:@"PayMoneyTableViewCell" owner:nil options:nil]objectAtIndex:0];

               // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
        
        cell.payImage.image = [UIImage imageNamed:@"recharge_img_1"];
        cell.prettyImage.image = [UIImage imageNamed:@"recharge_btn_1"];
        cell.moneyNumLabel.text = @"¥100元";

        cell.contextLabel.text = @"首充100送120元到2750分钟";
        return cell;
    }
    else if(indexPath.section == 1){
        
            PayMoneyTableViewCell1 *cell1 =[tableView dequeueReusableCellWithIdentifier:cellIndentfier1];
            if (!cell1)
            {
                cell1 =[[[NSBundle mainBundle]loadNibNamed:@"PayMoneyTableViewCell1" owner:nil options:nil]objectAtIndex:0];
                //cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell1.selectionStyle = UITableViewCellSelectionStyleNone;
                
            
            }
        if(indexPath.row == 0)
        {
            cell1.payImage1.image = [UIImage imageNamed:@"recharge_img_500"];
          
            
            cell1.numLabel1.text = @"充300送500元到10000分钟";
            cell1.numLabel2.text =  @"折扣3分钱/分钟";
            cell1.moneyNumber.text = @"¥300元";
            
            
        
        }
        else if(indexPath.row == 1)
        {
            cell1.payImage1.image = [UIImage imageNamed:@"recharge_img_200"];
            cell1.numLabel1.text = @"充100送100元到2500分钟";
            cell1.numLabel2.text = @"折扣4分钱/分钟";
            cell1.moneyNumber.text = @"¥100元";

        }
        else if(indexPath.row == 2)
        {
            cell1.payImage1.image = [UIImage imageNamed:@"recharge_img_30"];
            cell1.numLabel1.text = @"充50送30元到1000分钟";
            cell1.numLabel2.text = @"折扣5分钱/分钟";
            cell1.moneyNumber.text = @"¥50元";

        }
        else if(indexPath.row == 3)
        {
            cell1.payImage1.image = [UIImage imageNamed:@"recharge_img_10"];
            cell1.numLabel1.text = @"充30送10元到500分钟";
            cell1.numLabel2.text = @"折扣6分钱/分钟";
            cell1.moneyNumber.text = @"¥30元";

        }else if(indexPath.row == 4)
        {
            cell1.payImage1.image = [UIImage imageNamed:@"recharge_img_0"];
            cell1.numLabel1.text = @"充10到125分钟";
            cell1.numLabel2.text = @"折扣8分钱/分钟";
            cell1.moneyNumber.text = @"¥10元";
        }else if(indexPath.row == 5)
        {
            cell1.payImage1.image = [UIImage imageNamed:@"recharge_img_1500"];
            cell1.numLabel1.text = @"充500送1500";
            cell1.numLabel2.text = @"折扣2分钱/分钟";
            cell1.moneyNumber.text = @"¥500元";
            
        }
        
         return cell1;
    }else{
        PayMoneyTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIndentfier2];
        if (!cell)
        {
            cell =[[[NSBundle mainBundle]loadNibNamed:@"PayMoneyTableViewCell2" owner:nil options:nil]objectAtIndex:0];
            
           // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
       
        return cell;
        
        
    }
    
    
    return nil;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        PayMoney1ViewController*payMoney0 = [[PayMoney1ViewController alloc]init];
       
        payMoney0.labelNumstr = @"首充100送120元到2750分钟";
        payMoney0.moneyStr = @"100";
        payMoney0.topup_type = @"2";
        payMoney0.subject = @"100元";
        payMoney0.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:payMoney0 animated:YES];
        [payMoney0 release];
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            PayMoney1ViewController*payMoney0 = [[PayMoney1ViewController alloc]init];
            payMoney0.labelNumstr = @"充300送500元到10000分钟";
            payMoney0.moneyStr = @"300";
            payMoney0.topup_type = @"1";
            payMoney0.subject = @"300元";
            payMoney0.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:payMoney0 animated:YES];
            [payMoney0 release];

        }else if (indexPath.row == 1){
            PayMoney1ViewController*payMoney0 = [[PayMoney1ViewController alloc]init];
          
            payMoney0.labelNumstr = @"充100送100元到2500分钟";
            payMoney0.moneyStr = @"100";
            payMoney0.topup_type = @"1";
            payMoney0.subject = @"100元";
            
            payMoney0.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:payMoney0 animated:YES];
            [payMoney0 release];
            
        }else if (indexPath.row == 2){
            PayMoney1ViewController*payMoney0 = [[PayMoney1ViewController alloc]init];
          
            payMoney0.labelNumstr = @"充50送30元到1000分钟";
            payMoney0.moneyStr = @"50";
            payMoney0.topup_type = @"1";
            payMoney0.subject = @"50元";
            
            payMoney0.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:payMoney0 animated:YES];
            [payMoney0 release];
            
        }else if (indexPath.row == 3){
            PayMoney1ViewController*payMoney0 = [[PayMoney1ViewController alloc]init];
            
            payMoney0.labelNumstr = @"充30送10元到500分钟";
            payMoney0.moneyStr = @"30";
            payMoney0.topup_type = @"1";
            payMoney0.subject = @"30元";
            
            payMoney0.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:payMoney0 animated:YES];
            [payMoney0 release];
            
        }else if (indexPath.row == 4){
            PayMoney1ViewController*payMoney0 = [[PayMoney1ViewController alloc]init];
           
            payMoney0.labelNumstr = @"充10到125分钟";
            payMoney0.moneyStr = @"10";
            payMoney0.topup_type = @"1";
            payMoney0.subject = @"10元";
            
            payMoney0.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:payMoney0 animated:YES];
            [payMoney0 release];
            
        }else if (indexPath.row == 5){
            PayMoney1ViewController*payMoney0 = [[PayMoney1ViewController alloc]init];
            payMoney0.labelNumstr = @"充500送1500";
            payMoney0.moneyStr = @"500";
            payMoney0.topup_type = @"1";
            payMoney0.subject = @"500元";
            
            payMoney0.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:payMoney0 animated:YES];
            [payMoney0 release];
            
        }
    }
    
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
//    aa{
//        Connection = close;
//        "Content-Length" = 529;
//        "Content-Type" = "text/html; charset=UTF-8";
//        Date = "Fri, 03 Jun 2016 02:36:47 GMT";
//        Server = "Apache/2.2.3 (CentOS)";
//        "X-Powered-By" = "PHP/5.1.6";
//    }
//    2016-06-03 10:36:47.944 yilian[26819:8007482] hh{"state":"1","result":"_input_charset=utf-8&body=\u5145100\u9001100&it_b_pay=30m&mobile=13113369267&notify_url=http:\/\/120.76.78.99\/api\/alipay\/notify_url.php&out_trade_no=YDCL201606035114071&partner=20882218743ortp-warning-eXosip_trylock busy.
//        ortp-warning-eXosip_trylock busy.
//        28562&payment_type=1&seller_id=3433409460@qq.com&service=mobile.securitypay.pay&subject=100\u5143&total_fee=100&sign=XI7QuGHOUcMSj7doNR9FjuayyzJiABO9iBqkrFfYszrfMpJi7PPH%2FDOqxWE0qtD0ekMAk3Y%2F0Ht5cASgBbcqVVQMb%2Bn7zct92BnSk9P3wa7oiFGe3ltu4cRv%2F8sVbEy9O83VxzYVxLKQ4xhnlOS2a7pJlL7wst4diYziwMtneAk%3D&sign_type=RSA"}
//        ortp-warning-eXosip_trylock busy.
//    
    
   //_input_charset=utf-8&body=充100送100&it_b_pay=30m&mobile=13113369267&notify_url=http://120.76.78.99/api/alipay/notify_url.php&out_trade_no=YDCL201606031757371&partner=2088221874328562&payment_type=1&seller_id=3433409460@qq.com&service=mobile.securitypay.pay&subject=100元&total_fee=100&sign=Bs8hl%2Bn0lBcGTGOyhwxCNa%2F%2FIqraRd9VJPl%2BfyTfodUbAMoZ53VKMvI1hE4uzcLNNRfI6FzCrEdI%2FaLRneFa2GkNT8xtgxv6JKscsrlDCjZIE71MyAu0mIFO4%2Fvfp8Pu670WTBKsaBiVfCl52IZWLuOADGLKIEdb7HHpKC3EUzs%3D&sign_type=RSA
}


@end
