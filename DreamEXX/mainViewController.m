//
//  mainViewController.m
//  DreamEXX
//
//  Created by LiYang on 16/6/25.
//  Copyright © 2016年 LiYang. All rights reserved.
//

#import "mainViewController.h"
#import "Masonry.h"
@interface mainViewController ()
@property (weak, nonatomic) IBOutlet UIButton *upBtn;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;
@property (weak, nonatomic) IBOutlet UIView *showView;
@property (nonatomic,strong)UISlider * slider;
@property (weak, nonatomic) IBOutlet UIView *bottomShowView;
@property (weak, nonatomic) IBOutlet UIButton *bottomLeBtn;
@property (weak, nonatomic) IBOutlet UIButton *bottomRiBtn;
@property (nonatomic,strong)UISlider * bottomSlider;
@property (weak, nonatomic) IBOutlet UIView *upShowView;
@property (nonatomic,strong)UISlider * upSlider;


@end

@implementation mainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setData];
    [self setUI];
    [self setVerSlider];
    [self setBottomView];
    [self setUpView];
    self.bluManager.delegate = self;
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    [self.bluManager connectPeripheral:_periheral options:nil];
}
-(void)setData{

    self.peripheralArr = [NSMutableArray array];
    self.serverArr = [NSMutableArray array];
}

-(void)setUI{
    self.navigationController.navigationBarHidden = YES;

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"i6"]];
    UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
   // [self.view addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"i6"];
    
}

-(void)setVerSlider{
    
    self.slider = [[UISlider alloc]init];
    [self.showView addSubview:self.slider];

    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.showView.frame.size.height-80, self.showView.frame.size.width));
        make.centerX.mas_equalTo(self.showView.mas_centerX);
        make.centerY.mas_equalTo(self.showView.mas_centerY);

    }];
    self.slider.transform = CGAffineTransformMakeRotation(1.57079633);

    //滑动条的背景图
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.showView.bounds.size.width, self.showView.bounds.size.height)];
    bgImageView.image = [UIImage imageNamed:@"滑块_03"];
    
    [self.showView addSubview:bgImageView];
    
    //设置滑动条
    
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 1;
    self.slider.value = 0.5;
    [self.slider setMinimumTrackTintColor:[UIColor clearColor]];
    [self.slider setMaximumTrackTintColor:[UIColor clearColor]];
    //设置滑块的图片
    UIImage *thumbImage = [UIImage imageNamed:@"123_03"];

    [self.slider setThumbImage:thumbImage forState:UIControlStateNormal];
    [self.slider setThumbImage:thumbImage forState:UIControlStateHighlighted];
    
    [self.showView bringSubviewToFront:self.slider];
    [self.upBtn addTarget:self action:@selector(upBtnclick) forControlEvents:UIControlEventTouchDown];
    [self.upBtn addTarget:self action:@selector(upBtnclick1) forControlEvents:UIControlEventTouchUpOutside];
    [self.downBtn addTarget:self action:@selector(downBtnclick) forControlEvents:UIControlEventTouchDown];
    [self.downBtn addTarget:self action:@selector(downBtnclick1) forControlEvents:UIControlEventTouchUpOutside];
    self.upBtn.userInteractionEnabled = YES;
    self.downBtn.userInteractionEnabled = YES;
    [self.slider addTarget:self action:@selector(sliderChange) forControlEvents:UIControlEventValueChanged];
    [self.slider addTarget:self action:@selector(sliderChange1) forControlEvents:UIControlEventTouchUpInside];
    [self.slider addTarget:self action:@selector(sliderChange2) forControlEvents:UIControlEventTouchUpOutside];
    
    [self.view bringSubviewToFront:self.showView];
}
-(void)sliderChange{

    if (self.slider.value > 0.5) {
        NSLog(@"xxxxx");
    }else if (self.slider.value < 0.5){
    
        NSLog(@"yyyyy");
    }
}
-(void)sliderChange1{

    self.slider.value = 0.5;
}
-(void)sliderChange2{

    self.slider.value = 0.5;

}
-(void)upBtnclick{

  
     self.slider.value = 0;
}
-(void)upBtnclick1{

    self.slider.value = 0.5;

}
- (IBAction)upClick:(id)sender {
    
      self.slider.value = 0.5;
    
   

}
-(void)downBtnclick{
    self.slider.value = 1;

}
-(void)downBtnclick1{
    self.slider.value = 0.5;

    
}
- (IBAction)downClick:(id)sender {
    

    self.slider.value = 0.5;
    
    
}

-(void)setBottomView{

    self.bottomSlider = [[UISlider alloc]init];
    [self.bottomShowView addSubview:self.bottomSlider];
    
    [self.bottomSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.bottomShowView.frame.size.width-80, self.bottomShowView.frame.size.height));
        make.centerX.mas_equalTo(self.bottomShowView.mas_centerX);
        make.centerY.mas_equalTo(self.bottomShowView.mas_centerY);
        
    }];
    
    //滑动条的背景图
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bottomShowView.bounds.size.width, self.bottomShowView.bounds.size.height)];
    bgImageView.image = [UIImage imageNamed:@"滑块_10"];
    
    [self.bottomShowView addSubview:bgImageView];
    
    //设置滑动条
    
    self.bottomSlider.minimumValue = 0;
    self.bottomSlider.maximumValue = 1;
    self.bottomSlider.value = 0.5;
    [self.bottomSlider setMinimumTrackTintColor:[UIColor clearColor]];
    [self.bottomSlider setMaximumTrackTintColor:[UIColor clearColor]];
    //设置滑块的图片
    UIImage *thumbImage = [UIImage imageNamed:@"123_03"];
    
    [self.bottomSlider setThumbImage:thumbImage forState:UIControlStateNormal];
    [self.bottomSlider setThumbImage:thumbImage forState:UIControlStateHighlighted];
    
    [self.bottomShowView bringSubviewToFront:self.bottomSlider];
    
    [self.bottomLeBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchDown];
    [self.bottomLeBtn addTarget:self action:@selector(leftClick1) forControlEvents:UIControlEventTouchUpOutside];
    [self.bottomRiBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchDown];
    [self.bottomRiBtn addTarget:self action:@selector(rightClick1) forControlEvents:UIControlEventTouchUpOutside];
    self.bottomLeBtn.userInteractionEnabled = YES;
    self.bottomRiBtn.userInteractionEnabled = YES;
    [self.bottomSlider addTarget:self action:@selector(botoomsliderChange) forControlEvents:UIControlEventValueChanged];
    [self.bottomSlider addTarget:self action:@selector(botoomsliderChange1) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomSlider addTarget:self action:@selector(botoomsliderChange2) forControlEvents:UIControlEventTouchUpOutside];
    [self.view bringSubviewToFront:self.bottomShowView];
}
-(void)leftClick{

            self.bottomSlider.value = 0;

    
}
-(void)rightClick{

        self.bottomSlider.value = 1;

    
    
}
-(void)leftClick1{
     self.bottomSlider.value = 0.5;


}
- (IBAction)leftClick:(id)sender {
    
        
        self.bottomSlider.value = 0.5;


}
- (IBAction)rightClick:(id)sender {
    
    
        self.bottomSlider.value = 0.5;

        
   

}
-(void)rightClick1{

    self.bottomSlider.value = 0.5;

}
-(void)botoomsliderChange{

    if (self.bottomSlider.value > 0.5) {
        NSLog(@"kkkkk");

    }else if (self.bottomSlider.value < 0.5){
    
        NSLog(@"ggggg");
    }
    
}
-(void)botoomsliderChange1{

    
        self.bottomSlider.value = 0.5;

        
    
}
-(void)botoomsliderChange2{

    self.bottomSlider.value = 0.5;
}
-(void)setUpView{
     self.upSlider = [[UISlider alloc]init];
    [self.upShowView addSubview:self.upSlider];
    
    [self.upSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.upShowView.frame.size.width, self.upShowView.frame.size.height));
        make.centerX.mas_equalTo(self.upShowView.mas_centerX);
        make.centerY.mas_equalTo(self.upShowView.mas_centerY);
        
    }];
    
    //滑动条的背景图
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.upShowView.bounds.size.width, self.upShowView.bounds.size.height)];
    bgImageView.image = [UIImage imageNamed:@"滑块_06"];
    
    [self.upShowView addSubview:bgImageView];
    
    //设置滑动条
    
    self.upSlider.minimumValue = 0;
    self.upSlider.maximumValue = 1;
    self.upSlider.value = 1;
    [self.upSlider setMinimumTrackTintColor:[UIColor clearColor]];
    [self.upSlider setMaximumTrackTintColor:[UIColor clearColor]];
    
    //设置滑块的图片
    UIImage *thumbImage = [UIImage imageNamed:@"123_03"];
    
    [self.upSlider setThumbImage:thumbImage forState:UIControlStateNormal];
    [self.upSlider setThumbImage:thumbImage forState:UIControlStateHighlighted];
    
    [self.upSlider addTarget:self action:@selector(chang) forControlEvents:UIControlEventTouchUpInside];
    [self.upSlider addTarget:self action:@selector(chang2) forControlEvents:UIControlEventValueChanged];
    [self.upShowView bringSubviewToFront:self.upSlider];
    
    
    [self.view bringSubviewToFront:self.upShowView];


}

-(void)chang{

//    if (self.upSlider.value == 0) {
//        self.upSlider.value = 1;
//    }else if(self.upSlider.value == 1){
//        self.upSlider.value = 0;
//        
//    }
}
-(void)chang2{

    if (self.upSlider.value > 0.5) {
        
            int aaa = 0x00;
            NSData * data = [NSData dataWithBytes:&aaa  length:1];
            [self.periheral writeValue:data forCharacteristic:self.on_off_Charac type:CBCharacteristicWriteWithResponse];
        
        self.upSlider.value = 1;
       
       
    }else if (self.upSlider.value < 0.5){
        
        
        
            int aaa = 0xFF;
            NSData * data = [NSData dataWithBytes:&aaa  length:1];
            [self.periheral writeValue:data forCharacteristic:self.on_off_Charac type:CBCharacteristicWriteWithResponse];
               
        self.upSlider.value = 0;

    }
    
}

#pragma mark connect peripheral
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    
    if (peripheral.state == CBPeripheralStateConnected) {
        NSLog(@"kkkk::connect:::%@",peripheral);
        [self.bluManager stopScan];
        peripheral.delegate =self;
        self.periheral = peripheral;
        [peripheral discoverServices:nil];
    
    }
}
#pragma mark find services
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    
    NSLog(@"find:::%@",peripheral.services);
    
    if (error) {
        return;
    }
    for (CBService *service in peripheral.services) {
        NSLog(@"uuid:::%@",service.UUID);
        
        if ([service.UUID.UUIDString isEqualToString:@"FFB0"]) {
            
            if (![_serverArr containsObject:service]) {
                [_serverArr addObject:service];
                [peripheral discoverCharacteristics:nil forService:service];
                
            }
        }
        
        
    }
    
    
}
#pragma mark find characteristics
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    
    
    NSLog(@"KKKK:::%@",service.characteristics);
    
    for (CBCharacteristic * c in service.characteristics) {
        
        [peripheral readValueForCharacteristic:c];
        
    }
    
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    if (error) {
        return;
    }
    
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFB6"]]) {
        
        
        self.on_off_Charac = characteristic;
        
    }
    NSLog(@"UUUUUUU:::%@",self.on_off_Charac);
    
}



@end
