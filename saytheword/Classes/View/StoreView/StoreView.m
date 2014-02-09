//
//  StoreView.m
//  1word2pics
//
//  Created by Hoang le on 3/27/13.
//  Copyright (c) 2013 Hoang le. All rights reserved.
//

#import "StoreView.h"

@implementation StoreView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame andData:(StoreModel *)_data
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor yellowColor]];
        //        self.alpha = 0;
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        storeModel = [_data retain];
        [self createSubViews];
        HUD = [[MBProgressHUD alloc] initWithView:self];
        [self addSubview:HUD];
        
        HUD.delegate = self;
        HUD.labelText = @"Buying ...";
        HUD.detailsLabelText = @"Please wait";
        HUD.square = YES;
        
    }
    return self;
}

- (void)showTableView
{
    [tableView setHidden:NO];
}

- (void)createSubViews
{
    //    [self setBackgroundColor:[UIColor yellowColor]];
    //    UIButton *back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //    [back setFrame:CGRectMake(20, 10, 60, 40)];
    //
    //    [back setBackgroundColor:[UIColor yellowColor]];
    //    [back addTarget:delegate action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    //    [self addSubview:back];
    //    [back release];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"gtk-cancel.png"] forState:UIControlStateNormal];
    [backBtn setFrame:CGRectMake(180,10,40, 40)];
    [backBtn addTarget:delegate action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeightOfTopBarPopUpIAP, 240, 360)];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self addSubview:tableView];
    [tableView setHidden:YES];
    [tableView release];
    //    [self setBackgroundColor:[UIColor redColor]];
}

#pragma mark UITableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [storeModel.listItems count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHeightOfRowStoreItem;
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    StoreCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[StoreCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *productID =[[storeModel.listItems objectAtIndex:indexPath.row] productIdentifier];
        NSString *cellText;
        
        if ([productID isEqualToString:kProductIDOf200])
        {
            cellText = @"200 coins";
            [cell showPrice:@"$0.99" saving:@""];
            //            [cell showPrice:@"$0.99"];
        }
        if ([productID isEqualToString:kProductIDOf420])
        {
            cellText = @"420 coins";
            [cell showPrice:@"$1.99" saving:@"5%"];
            
        }
        if ([productID isEqualToString:kProductIDOf1085])
        {
            cellText = @"1085 coins";
            [cell showPrice:@"$4.99" saving:@"8%"];
            //            [cell showPrice:@"$4.99 28%"];
        }
        if ([productID isEqualToString:kProductIDOf2350])
        {
            cellText = @"2350 coins";
            [cell showPrice:@"$9.99" saving:@"15%"];
            //            [cell showPrice:@"$9.99 50%"];
        }
        if ([productID isEqualToString:kProductIDOf7150])
        {
            cellText = @"7150 coins";
            [cell showPrice:@"$24.99" saving:@"30%"];
            //            [cell showPrice:@"$19.99 60%"];
        }
        cell.textLabel.text = cellText;
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [HUD show:YES];
    SKProduct *selectedProduct = [storeModel.listItems objectAtIndex:indexPath.row];
    SKPayment *payment = [SKPayment paymentWithProduct:selectedProduct];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
    //    [delegate buyItem:[[storeModel.listItems objectAtIndex:indexPath.row] productIdentifier]];
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
