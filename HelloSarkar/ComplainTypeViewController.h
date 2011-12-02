//
//  ComplainTypeViewController.h
//  HelloSarkar
//
//  Created by nepal on 26/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedStore.h"

@class ComplainTypeViewController;  

@protocol ComplainTypeViewControllerDelegate <NSObject>
// we will make one function mandatory to include
    -(void)selectedComplainType:(NSString *)complainTypeTitle withCode:(NSString *)complainTypeTitleCode;
@end 

@interface ComplainTypeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    IBOutlet UITableView *complainTypeListTableView;
    
    NSMutableArray *complainTypeCodeListArray;   
    NSMutableArray *complainTypeListArray;
    NSInteger selectedIndex;
    NSString *selectedComplainTypeCode;

    id <ComplainTypeViewControllerDelegate> delegate;
}
//---------  PROPERTIES --------- 
@property (nonatomic, retain) IBOutlet UITableView *complainTypeListTableView;
@property (nonatomic, retain) NSMutableArray *complainTypeCodeListArray;
@property (nonatomic, retain) NSMutableArray *complainTypeListArray;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, retain) NSString *selectedComplainTypeCode;
@property (nonatomic, assign) id <ComplainTypeViewControllerDelegate> delegate;

//---------  SELF METHODS ---------
-(id)initWithComplainTypeCode:(NSString *)_complainTypeCode;

//---------  CUSTOM METHODS ---------
-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
-(void)prepareComplainTypeList;

@end
