//
//  bleTableViewController.h
//  DreamEXX
//
//  Created by LiYang on 16/6/25.
//  Copyright © 2016年 LiYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
@interface bleTableViewController : UITableViewController<CBCentralManagerDelegate,CBPeripheralDelegate>

@property (nonatomic,strong)CBPeripheral * periheral;
@property (nonatomic,strong)CBCentralManager * bluManager;

@property (nonatomic,strong)CBCharacteristic * on_off_Charac;

@end
