//
//  enlargeHeaderTableView.m
//  TableViewHeaderEnlarde
//
//  Created by 腾实信 on 2017/3/9.
//  Copyright © 2017年 ida. All rights reserved.
//

#import "enlargeHeaderTableView.h"
#define kHEIGHT 200

@interface enlargeHeaderTableView ()

@end

@implementation enlargeHeaderTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_id"];
    //布置图片的时候，我们首先要通过设置UITableview的内容偏移来为图片视图留出位置，这里我们的图片高度暂定为200。
    self.tableView.contentInset = UIEdgeInsetsMake(kHEIGHT, 0, 0, 0);
    
    //接下来就是布置图片，图片要放在内容视图之上，所以图片的纵向位置应该为负。
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -kHEIGHT, [UIScreen mainScreen].bounds.size.width, kHEIGHT)];
    //删除多余图片。（不加这个得话。第一行被遮盖)
    imageView.clipsToBounds = YES;
    imageView.image = [UIImage imageNamed:@"路飞"];
    //图片的 contentMode 必须设置为 UIViewContentModeScaleAspectFill ， 这样才能保证图片在放大的过程中高和宽是同时放大的。
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.tag = 111;
    [self.tableView addSubview:imageView];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}

//，一旦判定是下拉状态并且是从大于图片高度的地方下拉的，那么我们就要动态的改变图片的纵向位置和图片的高度（由于设置了contentMode，所以宽度自己会变化），最终实现所需要的效果
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
    if (point.y < -kHEIGHT) {
        CGRect rect = [self.tableView viewWithTag:111].frame;
        //ImageView的top始终粘着屏幕的上顶端
        rect.origin.y = point.y;
        rect.size.height = -point.y;
        [self.tableView viewWithTag:111].frame = rect;
    }
}

@end
