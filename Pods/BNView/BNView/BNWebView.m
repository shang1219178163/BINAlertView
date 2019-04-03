//
//  BNWebView.m
//  WHWebView
//
//  Created by hsf on 2018/5/11.
//  Copyright © 2018年 魏辉. All rights reserved.
//

#import "BNWebView.h"

#import "BNGloble.h"
#import "WKWebView+Helper.h"
#import "UIAlertController+Helper.h"

#import "Masonry.h"

NSString * const kProgress = @"estimatedProgress";

@interface BNWebView ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic,strong) UIRefreshControl *refreshControl;  //刷新
@property (nonatomic,strong) UIProgressView *progressView;  //进度条
@property (nonatomic,strong) UIButton *reloadBtn;  //重新加载按钮

@end

@implementation BNWebView

#pragma mark --Dealloc
- (void)dealloc{
    [_wkWebView removeObserver:self forKeyPath:kProgress];
    [_wkWebView stopLoading];
    _wkWebView.UIDelegate = nil;
    _wkWebView.navigationDelegate = nil;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        [self addSubview:self.wkWebView];
        [self addSubview:self.progressView];
        [self addSubview:self.reloadBtn];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.wkWebView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    [self.progressView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(1.5);
    }];
    
    [self.reloadBtn makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(CGRectGetWidth(self.bounds)/2.0);
        make.height.equalTo(CGRectGetWidth(self.bounds)/2.0);
    }];
    
}

#pragma mark -private Methods
- (void)loadRequest {
    [self loadRequest:self.urlString];
}

- (void)loadRequest:(NSString *)urlString {
    if (![urlString hasPrefix:@"http"]) {//容错处理 不要忘记plist文件中设置http可访问 App Transport Security Settings
        urlString = [NSString stringWithFormat:@"http://%@",urlString];
    }
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
//    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//    request.HTTPMethod = @"POST";
//    request.HTTPBody = [[NSString stringWithFormat:@"toke=%@&param=%@",@"", @""] dataUsingEncoding:NSUTF8StringEncoding];
//    [request addValue:@"skey=skeyValue" forHTTPHeaderField:@"Cookie"];
    [_wkWebView loadRequest:request];
}

- (void)wkWebViewReload{
    [_wkWebView reload];
}

#pragma mark -导航按钮
- (void)back:(UIBarButtonItem*)item {
    if (_wkWebView.canGoBack) {
        [_wkWebView goBack];
    } else {

    }
}

#pragma mark -KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:kProgress]) {
        _progressView.progress = [change[@"new"] floatValue];
        if (_progressView.progress == 1.0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self->_progressView.hidden = YES;
            });
        }
    }
}

#pragma mark -WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    _progressView.hidden = NO;
    _wkWebView.hidden = NO;
    _reloadBtn.hidden = YES;
    // 看是否加载空网页
    if ([webView.URL.scheme isEqual:@"about"]) {
        webView.hidden = YES;
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //执行JS方法获取导航栏标题
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
        DDLog(@"title:____%@",title);
        
    }];
    [_refreshControl endRefreshing];
}

// 返回内容是否允许加载
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

//页面加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    webView.hidden = YES;
    _reloadBtn.hidden = NO;
}

#pragma mark -UIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    DDLog(@"message__%@",message);
    
    [UIAlertController showAlertTitle:nil msg:message placeholders:nil actionTitles:@[@"OK"] handler:^(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nonnull action) {
        completionHandler();

    }];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    DDLog(@"msg__%@",message);

}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
}

#pragma mark -WKScriptMessageHandler js 拦截 调用OC方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    DDLog(@"方法名:%@", message.name);
    DDLog(@"参数:%@", message.body);
    //    // 方法名
    //    NSString *methods = [NSString stringWithFormat:@"%@:", message.name];
    //    SEL selector = NSSelectorFromString(methods);
    //    // 调用方法
    //    if ([self respondsToSelector:selector]) {
    //        [self performSelector:selector withObject:message.body];
    //    } else {
    //        DDLog(@"未实行方法：%@", methods);
    //    }
    
    if([message.name isEqualToString:@"jsCallOc"]){
        // do something
    }
}

#pragma mark -set

-(void)setJsString:(NSString *)jsString{
    _jsString = jsString;
    
    [self.wkWebView addUserScript:jsString];
}

#pragma mark -lazy load
- (WKWebView *)wkWebView{
    if (!_wkWebView) {
        // 设置WKWebView基本配置信息
        WKWebViewConfiguration *confi = WKWebView.confiDefault;
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        [userContentController addScriptMessageHandler:self name:@"jsCallOC"];
        confi.userContentController = userContentController;
        
        _wkWebView = [[WKWebView alloc] initWithFrame:self.bounds configuration:confi];
        // 设置代理
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
        
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        // 是否开启下拉刷新
        if (@available(iOS 10.0, *)) {
            _wkWebView.scrollView.refreshControl = self.refreshControl;
        } else {
            // Fallback on earlier versions
        }
        
        // 添加进度监听
        [_wkWebView addObserver:self forKeyPath:kProgress options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return _wkWebView;
}

- (UIRefreshControl *)refreshControl{
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:@selector(wkWebViewReload) forControlEvents:(UIControlEventValueChanged)];
    }
    return _refreshControl;
}

- (UIProgressView* )progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 2)];
        _progressView.progressTintColor = _progressColor ? : UIColor.blueColor;
    }
    return _progressView;
}

- (UIButton *)reloadBtn{
    if (!_reloadBtn) {
        _reloadBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _reloadBtn.frame = CGRectMake(0, 0, 200, 140);
        _reloadBtn.center = self.center;
        [_reloadBtn setBackgroundImage:[UIImage imageNamed:@"loadingError"] forState:UIControlStateNormal];
        [_reloadBtn setTitle:@"网络异常，点击重新加载" forState:UIControlStateNormal];
        [_reloadBtn setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
        [_reloadBtn setTitleEdgeInsets:UIEdgeInsetsMake(200, -50, 0, -50)];
        [_reloadBtn addTarget:self action:@selector(wkWebViewReload) forControlEvents:(UIControlEventTouchUpInside)];
        _reloadBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _reloadBtn.titleLabel.numberOfLines = 0;
        _reloadBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _reloadBtn.hidden = YES;
    }
    return _reloadBtn;
}


@end
