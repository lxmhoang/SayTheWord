//
//  HintView.m
//  1word2pics
//
//  Created by Hoang le on 4/5/13.
//  Copyright (c) 2013 Hoang le. All rights reserved.
//

#import "HintView.h"

@implementation HintView
@synthesize delegate;

- (void)shareFB:(UIGestureRecognizer *)_sender
{
//    [delegate shareFB:_sender];
    [self removeFromSuperview];
}

- (void)createSubViews
{

    UIView *bigView = [[UIView alloc]initWithFrame:CGRectMake(40, kHeightOfScreen/2-(kHeightOfTopBarPopUpIAP+4*kHeightOfRowStoreItem)/2, 240, kHeightOfTopBarPopUpIAP+4*kHeightOfRowStoreItem)];
    [bigView setBackgroundColor:[UIColor yellowColor]];
    bigView.alpha = 1;
    [self addSubview:bigView];
    
//    UIView *row1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidthOfScreen/4*3, kHeightOfScreen/4*3/9)];
//    [row1 setBackgroundColor:[UIColor yellowColor]];
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"gtk-cancel.png"] forState:UIControlStateNormal];
    [backBtn setFrame:CGRectMake(220, kHeightOfScreen/2-(kHeightOfTopBarPopUpIAP+4*kHeightOfRowStoreItem)/2+10, 40, 40)];
    [backBtn addTarget:self action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeightOfTopBarPopUpIAP, 240, 360)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [bigView addSubview:tableView];
    
    
//    [bigView addSubview:row1];
//    [row1 release];
    
    
//    UILabel *fbLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kHeightOfScreen/4*3/9, kWidthOfScreen/4*3,kHeightOfScreen/4*3/4)];
//    
//    fbLabel.text = @"Ask your friends to help";
//    [fbLabel setFont:[UIFont fontWithName:@"Verdana-Bold" size:12.0]];
//    fbLabel.userInteractionEnabled = YES;
//    [row1 addSubview:fbLabel];
//    
//    UITapGestureRecognizer *__tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareFB:)];
//    [row1 addGestureRecognizer:__tap];
//    [__tap release];
//    
//    
//    [fbLabel release];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        hintString = [[NSUserDefaults standardUserDefaults] stringForKey:@"hintString"];
        // Initialization code
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6];

        //        self.alpha = 0;

        
//        self.alpha = 1;
//        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.7f];
        
        [self createSubViews];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark UITableView Data source

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    HintCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    UIView *test = [[UIView alloc]init];
//    [test setBackgroundColor:[UIColor redColor]];
    
    if (cell == nil) {
        cell = [[HintCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"Remove a letter";
                [cell.textLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15]];
                [cell showCoin:[NSString stringWithFormat:@"%d",1]];
                if ([CommonFunction getCanRemoveALetter])
                {
                    cell.userInteractionEnabled = NO;
                    cell.textLabel.enabled = NO;
                    cell.detailTextLabel.enabled = NO;
                }
                break;
            case 1:
                cell.textLabel.text = @"Reveal a letter";
                [cell.textLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15]];
                [cell showCoin:[NSString stringWithFormat:@"%d",1]];
                if ([CommonFunction getCanRevealALetter])
                {
                    cell.userInteractionEnabled = NO;
                    cell.textLabel.enabled = NO;
                    cell.detailTextLabel.enabled = NO;
                }
                break;
            case 2:
//                cell.backgroundView = test;
                cell.textLabel.text = @"Show Left Word Title";
                [cell.textLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15]];
                [cell showCoin:[NSString stringWithFormat:@"%d",1]];

                break;
            case 3:
                //                cell.backgroundView = test;
                cell.textLabel.text = @"Show Right Word Title";
                [cell.textLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15]];
                [cell showCoin:[NSString stringWithFormat:@"%d",1]];

                break;
//            case 4:
////                cell.backgroundView = test;
//                [cell.textLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15]];
//                cell.textLabel.text = @"Ask your friend";
//                [cell showCoin:@"FREE"];
//                if (![[hintString substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"@"])
//                {
//                    cell.userInteractionEnabled = NO;
//                    cell.textLabel.enabled = NO;
//                    cell.detailTextLabel.enabled = NO;
//                }
//                break;
            default:
                cell.textLabel.text = @"Test Cell";
                break;
        }
//        cell.imageView.image = [UIImage imageNamed:@"coins.png"];
//        cell.textLabel.text = @"Test Cell";
        
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHeightOfRowStoreItem;
}



#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [delegate removeALetterFromHintView];
//            hintString = [hintString stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"0"];
            
            break;
        case 1:
            [delegate revealALetterFromHintView];
//            hintString = [hintString stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"0"];
            break;
        case 2:
            [delegate revealLeftWordFromHintView];
//            hintString = [hintString stringByReplacingCharactersInRange:NSMakeRange(2, 1) withString:@"0"];
            break;
        case 3:
            [delegate shareFBFromHint];
           
            break;
        case 4:
            //            [delegate shareFBFromHint];
            
            break;
        default:
            break;
    }
    
    
//    [[NSUserDefaults standardUserDefaults] setObject:hintString forKey:@"hintString"];
    
    
//    SKProduct *selectedProduct = [storeModel.listItems objectAtIndex:indexPath.row];
//    SKPayment *payment = [SKPayment paymentWithProduct:selectedProduct];
//    [[SKPaymentQueue defaultQueue] addPayment:payment];
    //    [delegate buyItem:[[storeModel.listItems objectAtIndex:indexPath.row] productIdentifier]];
    
}



@end
