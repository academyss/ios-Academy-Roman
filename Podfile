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
    pod 'RxTest'
    pod 'RxBlocking'
    pod 'Cuckoo'
  end

  pod 'STT', '~> 2.2.8'
  pod 'AlamofireNetworkActivityLogger'
  pod 'SDWebImage', '~> 4.4.7'
  pod 'Swinject'
  pod 'SwinjectStoryboard'
  pod 'LightRoute', :git => 'https://github.com/SpectralDragon/LightRoute.git', :tag => '2.1.20'
  pod 'AppCenter'
  pod 'SideMenu'

  pod 'SINQ'
end

