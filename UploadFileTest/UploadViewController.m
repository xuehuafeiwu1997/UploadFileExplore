//
//  UploadViewController.m
//  UploadFileTest
//
//  Created by 许明洋 on 2020/12/8.
//

#import "UploadViewController.h"
#import "Masonry.h"

@interface UploadViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *uploadButton;

@end

@implementation UploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"上传文件到服务器";
    self.navigationController.navigationBar.translucent = NO;
    
    [self.view addSubview:self.imageView];
//    UIImage *image = [UIImage imageNamed:@"秦时明月.jpg"];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(12);
        make.width.greaterThanOrEqualTo(@0);
        make.height.greaterThanOrEqualTo(@0);
    }];
    
    [self.view addSubview:self.uploadButton];
    [self.uploadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.imageView.mas_bottom).offset(60);
        make.width.greaterThanOrEqualTo(@0);
        make.height.greaterThanOrEqualTo(@0);
    }];
}

- (UIButton *)uploadButton {
    if (_uploadButton) {
        return _uploadButton;
    }
    _uploadButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    [_uploadButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_uploadButton setTitle:@"上传文件" forState:UIControlStateNormal];
    [_uploadButton addTarget:self action:@selector(uploadFileToServer) forControlEvents:UIControlEventTouchUpInside];
    return _uploadButton;
}

- (UIImageView *)imageView {
    if (_imageView) {
        return _imageView;
    }
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    _imageView.image = [UIImage imageNamed:@"秦时明月.jpg"];
    return _imageView;
}

- (void)uploadFileToServer {
    NSLog(@"开始上传文件到服务器");

//    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"秦时明月" ofType:@".jpg"]];
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"txt"]];
    NSLog(@"当前的url为%@",url);
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: [NSURL URLWithString:@"http://192.168.31.61:3000/"]];
//    [[[self session] uploadTaskWithRequest:request fromFile:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            if (error) {
//                NSLog(@"上传文件出错，出错的原因为%@",error);
//                return;
//            }
//            NSLog(@"上传成功");
//            NSLog(@"服务器返回的response为：%@",request);
//        }] resume];
    [self uploadSimpleTextData];
}

- (void)uploadSimpleTextData {
    NSString *str = @"你好,陌生人";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: [NSURL URLWithString:@"http://192.168.31.61:3000/"]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://192.168.31.61:3000/"]];
    [request addValue:@"text/plain" forHTTPHeaderField:@"Content-type"];
//    [request addValue:@"许明洋，sixsixisix" forHTTPHeaderField:@"body"];
    request.HTTPMethod = @"POST";
    
    [[[self session] uploadTaskWithRequest:request fromData:data completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                
        if (error) {
            NSLog(@"上传文件出错，出错的原因是%@",error);
        }
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"当前的str为%@",str);
        NSLog(@"resposne的对象为%@",response);
        NSLog(@"服务器返回的数据为%@",data);
    }] resume];
}

#pragma mark - session
- (NSURLSession *)session {
    static NSURLSession *session;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    });
    return session;
}

@end
