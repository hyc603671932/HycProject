Pod::Spec.new do |s|
s.name = 'HycProject'
s.version = '1.0.4'
s.license = 'MIT'
s.summary = 'A Test in iOS.'
s.homepage = 'https://github.com/hyc603671932/HycProject'
s.authors = { 'HouKavin' => '603671932@qq.com' }
s.source = { :git => 'https://github.com/hyc603671932/HycProject.git', :tag => s.version}
s.requires_arc = true
s.ios.deployment_target = '7.0'
s.source_files = 'Utils','ScaningView'

end
