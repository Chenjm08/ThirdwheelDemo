//
//  YYKeyboardManager_ViewController.m
//  ThirdwheelDemo_Example
//
//  Created by Chen jiemin on 2020/6/23.
//  Copyright © 2020 chenjm. All rights reserved.
//

#import "YYKeyboardManager_ViewController.h"
#import <YYKeyboardManager/YYKeyboardManager.h>

@interface TestTextField : UITextField
@end

@implementation TestTextField

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}

@end



@interface YYKeyboardManager_ViewController () <YYKeyboardObserver, UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@end

@implementation YYKeyboardManager_ViewController

- (void)dealloc {
    // 移除监听者
    [[YYKeyboardManager defaultManager] removeObserver:self];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 监听键盘动画
        [[YYKeyboardManager defaultManager] addObserver:self];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField = ({
        UITextField *textField = [[TestTextField alloc] init];
        [self.view addSubview:textField];
        textField.backgroundColor = [UIColor blueColor];
        textField.delegate = self;
        textField;
    });
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    toolbar.alpha = 0.5;
    toolbar.backgroundColor = [UIColor redColor];
    
    self.textField.inputAccessoryView = toolbar;
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@60);
        make.bottom.equalTo(@-20);
    }];
        
}

// 在代理方法中做一些布局处理
- (void)keyboardChangedWithTransition:(YYKeyboardTransition)transition {
    YYKeyboardManager *manager = [YYKeyboardManager defaultManager];
    
    /* 测试数据 start */
    
    // 获取键盘的 view 和 window
    UIView *view = manager.keyboardView;
    UIWindow *window = manager.keyboardWindow;
    
    NSLog(@"keyboardView=%@, keyboardWindow=%@", view, window);
        
    // 键盘是否可见
    BOOL visible = manager.keyboardVisible;
    NSLog(@"keyboard is visible = %d", visible);
    
    CGRect frame = manager.keyboardFrame;
    NSLog(@"keyboardFrame=%@", NSStringFromCGRect(frame));
    
    frame = [manager convertRect:frame toView:self.view];
    NSLog(@"covert keyboardFrame=%@", NSStringFromCGRect(frame));
            
    
    CGRect fromFrame = [manager convertRect:transition.fromFrame toView:self.view];
    CGRect toFrame =  [manager convertRect:transition.toFrame toView:self.view];
    
    NSLog(@"transition from frame: %@", NSStringFromCGRect(fromFrame));
    NSLog(@"transition to frame: %@", NSStringFromCGRect(toFrame));
    
    BOOL fromVisible = transition.fromVisible;
    BOOL toVisible = transition.toVisible;
    NSTimeInterval animationDuration = transition.animationDuration;
    //UIViewAnimationCurve curve = transition.animationCurve;
    
    NSLog(@"transition fromVisible: %d", fromVisible);
    NSLog(@"transition toVisible: %d", toVisible);
    NSLog(@"animationDuration=%f", animationDuration);
    
    /* 测试数据 end */
    
    if (fromVisible) {
        CGRect textframe = self.textField.frame;
        textframe.origin.y = [UIScreen mainScreen].bounds.size.height - textframe.size.height - 20;
        self.textField.frame = textframe; // 这里的frame只是做动画用到，最后还是会被约束会原来的位置。为什么会有动画？没搞清楚～
    } else {
        ///从新计算tf的位置并赋值
        CGRect textframe = self.textField.frame;
        textframe.origin.y = toFrame.origin.y - textframe.size.height;
        self.textField.frame = textframe;
    }
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}

- (void)textFieldDidChangeSelection:(UITextField *)textField {
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - TouchEvent

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    
    NSLog(@"touch Frame=%@", NSStringFromCGRect(_textField.frame));
}

@end
