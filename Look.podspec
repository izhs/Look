# git tag 0.1.2
# git push origin 0.1.2
# pod lib lint Look.podspec --no-clean
# pod spec lint Look.podspec --allow-warnings
# pod trunk push Look.podspec

Pod::Spec.new do |s|

s.name                  = 'Look'
s.version               = '0.1.2'
s.summary               = 'Elegant UIView customizations in Swift'
s.homepage              = 'https://github.com/izhs/Look'
s.license               = { :type => 'MIT', :file => 'LICENSE' }
s.author                = { 'izhs' => 'izsh@protonmail.com' }
s.source                = { :git => 'https://github.com/izhs/Look.git', :tag => s.version.to_s }
s.ios.deployment_target = '8.0'
s.source_files          = 'Look/Classes/**/*'

end
