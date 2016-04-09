# MCPikerView

---

常用的PikerView选择器
 
###示例图

![PikerviewImage](https://github.com/hhcui/MCPikerView/blob/master/pikerview.png = 100x60)

###控件特性

	使用简单，代码高聚合，block管理数据源，
	
###使用方式

    NSArray *ary = @[@"123",@"123",@"123"];
    
    [MCPikerView showWithItemsBlock:^(id<MCClickedItmesProtocol> items) {
        [items addItemsWithPikerView:ary];
    } clickedBlock:^(NSInteger clickedIndex) {
        NSLog(@"选中第%d数据源",clickedIndex);
    }];


