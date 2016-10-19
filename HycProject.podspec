Pod::Spec.new do |s|
//项目名
s.name = 'HycProject'
//版本号
s.version = '1.0.1'
//listen文件的类型
s.license = 'MIT'
//简单描述
s.summary = 'A Test in iOS.'
//项目的gitub地址
s.homepage = 'https://github.com/hyc603671932/HycProject'
//作者和邮箱
s.authors = { 'HouKavin' => '603671932@qq.com' }
//git仓库的https地址
s.source = { :git => 'https://github.com/hyc603671932/HycProject.git', :tag => '1.0.1'}
//是否要求arc
s.requires_arc = true
//最低要求的系统版本
s.ios.deployment_target = '7.0'
//表示源文件的路径，这个路径是相对podspec文件而言的。
s.source_files = 'AppInfo/*.*'
//需要用到的frameworks，不需要加.frameworks后缀。
s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit' 

end
