//
//  MCPikerView.h
//
//
//  Created by Marc on 16/2/25.
//


#import <UIKit/UIKit.h>
@protocol MCClickedItmesProtocol <NSObject>
@required
- (void)addItemsWithPikerView:(NSArray *)ary;
@end
@interface MCPikerView : UIView
+ (void)showWithItemsBlock:(void (^)(id <MCClickedItmesProtocol>items))itemsBlock
              clickedBlock:(void (^)(NSInteger clickedIndex))clickedBlock;
@end
