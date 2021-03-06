//
//  IAPHelper.m
//  1word2pics
//
//  Created by Hoang le on 3/27/13.
//  Copyright (c) 2013 Hoang le. All rights reserved.
//

#import "IAPHelper.h"

@implementation IAPHelper
@synthesize delegate, productList;


- (id)init
{
    self = [super init];
    if (self)
    {
//        [self loadStore];
    }
    return self;
}


- (void)requestPurchaseItem
{
    if (!productsRequest)
    {
        productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObjects:kProductIDOf200, kProductIDOf420, kProductIDOf1100, kProductIDOf2400, kProductIDOf7800, nil ]];
        productsRequest.delegate = self;
        [productsRequest start];
    }else
    {
        
    }
}


- (void)loadStore
{
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];

    // get the product description (defined in early sections)
    [self requestPurchaseItem];
}

- (BOOL)canMakePurchase
{
   return [SKPaymentQueue canMakePayments];
}

- (void)purchaseItem
{
//    SKPayment *payment =  [SKPayment paymentWithProduct:IAPProduct];
//    [SKPayment paymentWithProductIdentifier:kInAppPurchaseProUpgradeProductId];
//    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

#pragma mark skproductrequest delegate



- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0)
{
    productList = [[NSArray alloc]initWithArray:response.products];


    
    for (NSString *invalidProductId in response.invalidProductIdentifiers)
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Invalid product ! There is an error in Itunes transactions. Please try again " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        NSLog(@"Shit");
        NSLog(@"Invalid product id: %@" , invalidProductId);
    }
    
    // finally release the reqest we alloc/init’ed in requestProUpgradeProductData
    if (delegate && [delegate respondsToSelector:@selector(setListProducts:)])
    {
        
            [delegate setListProducts:productList];
    }
//    [productsRequest release];
//    [self purchaseItem];
//    [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerProductsFetchedNotification object:self userInfo:nil];
}

#pragma mark SKPaymentTransactionObserver method

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    productsRequest = nil;
    for (SKPaymentTransaction *transaction in transactions)
    {
        NSLog(@"transaction identifier : %@",transaction.transactionIdentifier);
//        transaction.transactionIdentifier
        NSLog(@"transaction DATA : %@ ",transaction.transactionDate);
//        [transaction.transactionDate ]
        NSLog(@" transasction state: %ld",(long)transaction.transactionState);
        if (transaction.error)
        {
            
            NSLog(@" transasction error: %@",transaction.error);
        }
        switch (transaction.transactionState)
        {
            
            case SKPaymentTransactionStatePurchased:
               
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                if (transaction.error.code == SKErrorPaymentCancelled) {
                    /// user has cancelled
                    [self finishTransaction:transaction wasSuccessful:NO reason:@"Transaction cancelled"];
                }
                else if (transaction.error.code == SKErrorPaymentNotAllowed) {
                    // payment not allowed
                    [self finishTransaction:transaction wasSuccessful:NO reason:@"This device is not allowed to make the payment"];
                } else if (transaction.error.code == SKErrorStoreProductNotAvailable) {
                    // payment not allowed
                    [self finishTransaction:transaction wasSuccessful:NO reason:@"Product is not available in the current storefront"];
                }
                else {
                    // real error
                    [self finishTransaction:transaction wasSuccessful:NO reason:transaction.error.localizedDescription];
                    // show error
                }
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
                break;
            
            default:
                break;
        }
    }
   
}

//
// called when the transaction was successful
//
- (void)completeTransaction:(SKPaymentTransaction *)transaction
{
    NSLog(@"completeTransaction");
//    NSData *oldReceipt = [[NSUserDefaults standardUserDefaults] objectForKey:@"receipt"];
//    if ([transaction.transactionReceipt isEqualToData:oldReceipt])
//    {
//        NSLog(@"TRUNG RECEIPT");
//    }
//    else{
//        NSLog(@"KHONG TRUNG");
//        [[NSUserDefaults standardUserDefaults] setObject:transaction.transactionReceipt forKey:@"receipt"];
        [self recordTransaction:transaction];
        [self provideContent:transaction.payment.productIdentifier];
        [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
       
//    }
    

        [delegate afterTransaction];    
 
    

//    [self finishTransaction:transaction wasSuccessful:YES];
}

//
// called when a transaction has been restored and and successfully completed
//
- (void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    NSLog(@"restoreTransaction");
    NSString *oldReceipt = [[NSUserDefaults standardUserDefaults] stringForKey:@"receipt"];
    if ([[[[NSBundle mainBundle] appStoreReceiptURL] absoluteString]  isEqualToString:oldReceipt])
    {
        NSLog(@"TRUNG RECEIPT");
    }
    else{
        NSLog(@"KHONG TRUNG");
        [[NSUserDefaults standardUserDefaults] setObject:[[[NSBundle mainBundle] appStoreReceiptURL] absoluteString] forKey:@"receipt"];
        [self recordTransaction:transaction.originalTransaction];
        [self provideContent:transaction.originalTransaction.payment.productIdentifier];
        [[SKPaymentQueue defaultQueue] finishTransaction: transaction];

        
    }
    //    [self finishTransaction:transaction wasSuccessful:YES];
    if ([delegate respondsToSelector:@selector(dismissVC)])
    {
        [delegate dismissVC];
    }
    
}

//
// called when a transaction has failed
//
- (void)failedTransaction:(SKPaymentTransaction *)transaction
{
    NSLog(@"failedTransaction");
    NSLog(@"ly do fail : %@", transaction.error);
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        NSLog(@"loi, khong phai do user cancel");
        // error!
//        [self finishTransaction:transaction wasSuccessful:NO];
    }
    else
    {
//        NSLog(@"remove transaction : %@", transaction.transactionIdentifier);
//        // this is fine, the user just cancelled, so don’t notify
//        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
     [delegate dismissVC];
}

#pragma -
#pragma Purchase helpers

//
// saves a record of the transaction by storing the receipt to disk
//
- (void)recordTransaction:(SKPaymentTransaction *)transaction
{
   
    if ([transaction.payment.productIdentifier isEqualToString:kInAppPurchaseProUpgradeProductId])
    {
        // save the transaction receipt to disk
//        [[NSUserDefaults standardUserDefaults] setValue:transaction.transactionReceipt forKey:@"proUpgradeTransactionReceipt" ];
//        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

//
// enable pro features
//
- (void)provideContent:(NSString *)productId
{
//    if ([productId isEqualToString:kInAppPurchaseProUpgradeProductId])
//    {
//        // enable the pro features
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isProUpgradePurchased" ];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
    
    int addAmount = 0;
    
    
    
    if ([productId isEqualToString:kProductIDOf200])
    {
        addAmount = 200;
    }
    if ([productId isEqualToString:kProductIDOf420])
    {
        addAmount = 420;
    }
    if ([productId isEqualToString:kProductIDOf1100])
    {
        addAmount = 1100;
    }
    if ([productId isEqualToString:kProductIDOf2400])
    {
        addAmount = 2400;
    }
    if ([productId isEqualToString:kProductIDOf7800])
    {
        addAmount = 7800;
    }
    
    if (addAmount>= 1100)
    {
        [CommonFunction setNoAds:YES];
    }

    
    [CommonFunction setCoin:([CommonFunction getCoin]+addAmount)];
    
//    int coins = [[[NSUserDefaults standardUserDefaults] objectForKey:@"coins"] intValue];
//    
//    coins = coins+addAmount;
//    NSNumber *num = [NSNumber numberWithInt:coins];
//    NSLog(@" new coin : %d",[num intValue]);
//    [[NSUserDefaults standardUserDefaults] setObject:(id)num forKey:@"coins"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

//
// removes the transaction from the queue and posts a notification with the transaction result
//
- (void)finishTransaction:(SKPaymentTransaction *)transaction wasSuccessful:(BOOL)wasSuccessful reason:(NSString *)reason
{
//    NSLog(@"remove transaction : %@", transaction.transactionIdentifier);
    // remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:transaction, @"transaction" , nil];
    if (wasSuccessful)
    {
        // send out a notification that we’ve finished the transaction
        [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerTransactionSucceededNotification object:self userInfo:userInfo];
    }
    else
    {
        [CommonFunction alert:reason delegate:nil];
        // send out a notification for the failed transaction
        [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerTransactionFailedNotification object:self userInfo:userInfo];
    }
    
//    [CommonFunction alert:@"Transaction failed" delegate:nil];
    
//    [delegate finishTransaction];
}

#pragma mark SKRequestDelegate

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    [delegate IAPFailed];
}
- (void)requestDidFinish:(SKRequest *)request{
    
}

- (void)dealloc
{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    productsRequest.delegate = nil; // <----- Solution
}


@end
