Pod::Spec.new do |s|
s.name = 'HycProject'
s.version = '1.0.3'
s.license = 'MIT'
s.summary = 'A Test in iOS.'
s.homepage = 'https://github.com/hyc603671932/HycProject'
s.authors = { 'HouKavin' => '603671932@qq.com' }
s.source = { :git => 'https://github.com/hyc603671932/HycProject.git', :tag => '1.0.3'}
s.requires_arc = true
s.ios.deployment_target = '7.0'
s.source_files = 'Utils'

end
