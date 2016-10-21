Pod::Spec.new do |s|
 s.name = 'HycProject'
 s.version = '1.0.6'
 s.license = 'MIT'
 s.summary = 'A Test in iOS.'
 s.homepage = 'https://github.com/hyc603671932/HycProject'
 s.authors = { 'HouKavin' => '603671932@qq.com' }
 s.source = { :git => 'https://github.com/hyc603671932/HycProject.git', :tag => s.version}
 s.requires_arc = true
 s.ios.deployment_target = '7.0'
 s.source_files = 'Utils','ScaningView'

 s.subspec 'Test1' do |s1|
    s1.source_files = 'Test1/**.{h,m,xib,png}'
 end

 s.subspec 'Test2' do |s2|
    s2.source_files = 'Test2'
 end

 s.subspec 'Test3' do |s3|
    s3.source_files = 'Test3/*.*'
    s3.exclude_files = 'Test3/Contents3.json','Test3/test3.md','Test3/src3/text33.md','Test3/hello3.jpg','Test3/src3/hello33.jpg'
 end

end
