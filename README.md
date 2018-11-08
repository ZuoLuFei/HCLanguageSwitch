# HCLanguageSwitch
应用内切换语言国际化方案

使用前请先下载、运行并查看Demo。

## 【Demo演示】


![演示1](https://github.com/ZuoLuFei/DemoFigure/blob/master/HCLanguageSwitch演示动图/HCLanguageSwitch-1.gif)


/**********************************************************************/

## 【手动导入】

手动导入LanguageSwitch文件夹即可


/**********************************************************************/
## 方法说明

1. 在AppDelegate中初始化语言，默认是英语
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

/**
初始化国际化为汉语，默认是英语
注意：只在程序第一次启动初始化时才生效
*/
HCLocalizableManager.share.initializeLanguage("zh-Hans")

return true
}
```

2. 切换语言
```swift
// 切换语言，参数为bundleName
HCLocalizableManager.share.updateLanguage("en")
```

3. 业务中使用方式
```swift
override func viewDidLoad() {
super.viewDidLoad()

/// 使用方式一，正常推荐使用
titleWordLabel.hc_Text = "first_inputName"
changeLanuageBtn.hc_SetTitle("first_changeLanguage", for: .normal)

/// 使用方式二，在拼接变量时使用
currentLanguageLabel.text = DEF_LOCALIZED_STRING(key: "first_currentLanguage") + HCLocalizableResourcesFilter.share.currentLanguageName

/// 使用方法三，在特殊情况，需要手动监听语言更新
contentTextField.placeholder = DEF_LOCALIZED_STRING(key: "first_name")
contentTextField.localizableDidChange { [weak self] in
self?.contentTextField.placeholder = DEF_LOCALIZED_STRING(key: "first_name")
}
}
```

/**********************************************************************/

## 【示例】

请下载、运行并查看Demo

/**********************************************************************/

## 【贡献】

如果您发现了bug或需要帮助，请打开一个issue或者提交一个pull request，十分感谢
