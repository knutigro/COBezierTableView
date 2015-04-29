#
# Be sure to run `pod lib lint COBezierTableView.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "COBezierTableView"
  s.version          = "0.1.5"
  s.summary          = "UITableView modification written in Swift where cells are scrolling in an arc defined by a BezierPath"
  s.description      = <<-DESC
                        UITableView modification written in Swift where cells are scrolling in an arc defined by a BezierPath.

                        Project even include classes for editing BezierPaths. When you are happy with your path, insert the static points to the BezierPoints struct in UView+Bezier.swift.
                        DESC
  s.homepage         = "https://github.com/knutigro/COBezierTableView"
  s.license          = 'MIT'
  s.author           = { "Knut Inge Grosland" => "”hei@knutinge.com”" }
  s.source           = { :git => "https://github.com/knutigro/COBezierTableView.git", :tag => s.version }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'COBezierTableView/*.swift'

end
