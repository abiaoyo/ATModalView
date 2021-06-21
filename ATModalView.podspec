Pod::Spec.new do |s|
  s.name             = 'ATModalView'
  s.version          = '1.0'
  s.summary          = 'iOS 模态视图，可在此基础上自定义适合业务的action，alert及其他弹窗'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/abiaoyo/ATModalView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '347991555@qq.com' => '347991555@qq.com' }
  s.source           = { :git => 'https://github.com/abiaoyo/ATModalView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'ATModalView/*'
  
end
