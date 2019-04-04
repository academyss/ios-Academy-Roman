source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'
use_frameworks!

project 'SSAnalytics', {
    'Debug' => :debug,
    'Debug UAT' => :debug,
    'Debug PROD' => :debug,
    'Release' => :release,
    'Release UAT' => :release,
    'Release PROD' => :release
}

target 'SSAnalytics' do

  target 'SSAnalyticsTests' do
    pod 'RxTest', '~> 4.0'
    pod 'RxBlocking', '~> 4.0'
    pod 'Cuckoo'
  end

  pod 'STT'#, :path => '../../STT'
  pod 'AlamofireNetworkActivityLogger', '~> 2.3'
  pod 'SDWebImage', '~> 4.0'
  pod 'Swinject'
  pod 'SwinjectStoryboard'
  pod 'LightRoute', :git => 'https://github.com/SpectralDragon/LightRoute.git', :tag => '2.1.20'
  pod 'AppCenter'
#  pod 'RxRealm'
#  pod 'RealmSwift'
  pod 'SINQ'
end

