//
//  bleTableViewController.m
//  DreamEXX
//
//  Created by LiYang on 16/6/25.
//  Copyright © 2016年 LiYang. All rights reserved.
//

#import "bleTableViewController.h"
#import "mainViewController.h"

@interface bleTableViewController ()

@property (nonatomic,strong)NSMutableArray * peripheralArr;
@property (nonatomic,strong)NSMutableArray * serverArr;
@end

@implementation bleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setData];
    [self setUI];
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    
}
-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:YES];
    if (self.bluManager) {
        //[self.bluManager stopScan];
        [self startScan];
    }else{
    
        dispatch_queue_t centerqueue = dispatch_queue_create("com.center", DISPATCH_QUEUE_SERIAL);
        self.bluManager = [[CBCentralManager alloc]initWithDelegate:self queue:centerqueue];
        [self startScan];
    }
    
}
-(void)viewDidDisappear:(BOOL)animated{

    [self.bluManager stopScan];
}
-(void)setData{

     dispatch_queue_t centerqueue = dispatch_queue_create("com.center", DISPATCH_QUEUE_SERIAL);
    self.bluManager = [[CBCentralManager alloc]initWithDelegate:self queue:centerqueue];
    self.peripheralArr = [NSMutableArray array];
    self.serverArr = [NSMutableArray array];
}
-(void)setUI{

    UIButton * fresh = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [fresh setBackgroundImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    [fresh addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * freshItem = [[UIBarButtonItem alloc]initWithCustomView:fresh];
    
    self.navigationItem.rightBarButtonItem = freshItem;
    
}

-(void)btnClick{


}

#pragma mark scanBlu
-(void)startScan{

    [self.bluManager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];
}
#pragma mark -蓝牙代理
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{

    switch (central.state)
    {
        case CBCentralManagerStatePoweredOn:
            NSLog(@"Central Manager state --> power on.");
            //[self.centralMgr scanForPeripheralsWithServices:nil options:nil];
            //[self scanBLE];
            break;
            
        default:
            NSLog(@"Central Manager did change state");
            break;
    }

}
#pragma mark find peripheral
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{

    //NSLog(@"find:::%@",peripheral);
    NSLog(@"%@",advertisementData);
    if ([[advertisementData objectForKey:@"kCBAdvDataLocalName"] hasPrefix:@"AddLight"]) {
        if (![_peripheralArr containsObject:peripheral]) {
            [_peripheralArr addObject:peripheral];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }
}
#pragma mark connect peripheral
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{

    if (peripheral.state == CBPeripheralStateConnected) {
        NSLog(@"connect:::%@",peripheral);
        [self.bluManager stopScan];
        //[peripheral discoverServices:nil];
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
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellid = @"cellid";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        
    }
    cell.textLabel.text = @"test blue";
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UIStoryboard *mainStoryboad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    mainViewController *MainVC = [mainStoryboad instantiateViewControllerWithIdentifier:@"mainVC"];
    //CBPeripheral * p = _peripheralArr[indexPath.row];
    //p.delegate =self;
//    MainVC.periheral = _peripheralArr[indexPath.row];
//    MainVC.bluManager = self.bluManager;
    //[self.bluManager connectPeripheral:_peripheralArr[indexPath.row] options:nil];
    [self.navigationController pushViewController:MainVC animated:YES];
}



@end
