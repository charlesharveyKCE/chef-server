# Cookbook:: OneCMS
# Recipe:: win_int_web_svr_configure
#
# Copyright:: 2018, Charles Harvey, All Rights Reserved.

windows_feature_powershell ['NET-Framework-45-ASPNET', 'NET-Framework-45-Core', 'NET-Framework-45-Features', 'NET-Framework-Features', 'NET-WCF-Services45', 'NET-WCF-TCP-PortSharing45', 'Web-App-Dev', 'Web-Asp-Net', 'Web-Asp-Net45', 'Web-Common-Http', 'Web-Default-Doc', 'Web-Dir-Browsing', 'Web-Filtering', 'Web-Health', 'Web-Http-Errors', 'Web-Http-Logging', 'Web-ISAPI-Ext', 'Web-ISAPI-Filter', 'Web-Mgmt-Console', 'Web-Mgmt-Service', 'Web-Mgmt-Tools', 'Web-Net-Ext', 'Web-Net-Ext45', 'Web-Performance', 'Web-Scripting-Tools', 'Web-Security', 'Web-Server', 'Web-Stat-Compression', 'Web-Static-Content', 'Web-WebServer'] do
  action :install
end

chocolatey_package 'vcredist-all' do
  action :install
end

chocolatey_package 'logparser' do
  action :install
end

windows_service 'W3SVC' do
  action :enable
end

# stop and delete the default site
iis_site 'Default Web Site' do
  action [:stop, :delete]
end

directory "#{node['iis']['docroot']}/CDN-web" do
  action :create
end

iis_pool 'CDN-Web' do
  runtime_version "4.0"
  pipeline_mode :Integrated
  action [:add,:start]
end

iis_site 'CDN-web' do
  protocol :http
  port 9050
  path "#{node['iis']['docroot']}/CDN-web"
  application_pool 'CDN-Web'
  action [:add,:start]
end

template "#{node['iis']['docroot']}/CDN-web/Default.htm" do
  source 'default.htm.erb'
end

directory "#{node['iis']['docroot']}/CMS-CSS-Web" do
  action :create
end

iis_pool 'CMS-CSS-Web' do
  runtime_version "4.0"
  pipeline_mode :Integrated
  action [:add,:start]
end

iis_site 'CMS-CSS-Web' do
  protocol :http
  port 9060
  path "#{node['iis']['docroot']}/CMS-CSS-Web"
  application_pool 'CMS-CSS-Web'
  action [:add,:start]
end

template "#{node['iis']['docroot']}/CMS-CSS-Web/Default.htm" do
  source 'default.htm.erb'
end

directory "#{node['iis']['docroot']}/CMS-web" do
  action :create
end

iis_pool 'CMS-web' do
  runtime_version "4.0"
  pipeline_mode :Integrated
  action [:add,:start]
end

iis_site 'CMS-web' do
  protocol :http
  port 9000
  path "#{node['iis']['docroot']}/CMS-web"
  application_pool 'CMS-web'
  action [:add,:start]
end

template "#{node['iis']['docroot']}/CMS-web/Default.htm" do
  source 'default.htm.erb'
end

directory "#{node['iis']['docroot']}/Subsidy-CSS-Web" do
  action :create
end

iis_pool 'Subsidy-CSS-Web' do
  runtime_version "4.0"
  pipeline_mode :Integrated
  action [:add,:start]
end

iis_site 'Subsidy-CSS-Web' do
  protocol :http
  port 9070
  path "#{node['iis']['docroot']}/Subsidy-CSS-Web"
  application_pool 'Subsidy-CSS-Web'
  action [:add,:start]
end

template "#{node['iis']['docroot']}/Subsidy-CSS-Web/Default.htm" do
  source 'default.htm.erb'
end

directory "#{node['iis']['docroot']}/Subsidy-web" do
  action :create
end

iis_pool 'Subsidy-web' do
  runtime_version "4.0"
  pipeline_mode :Integrated
  action [:add,:start]
end

iis_site 'Subsidy-web' do
  protocol :http
  port 9020
  path "#{node['iis']['docroot']}/Subsidy-web"
  application_pool 'Subsidy-web'
  action [:add,:start]
end

template "#{node['iis']['docroot']}/Subsidy-web/Default.htm" do
  source 'default.htm.erb'
end

directory "#{node['iis']['docroot']}/TC-web" do
  action :create
end

iis_pool 'TC-web' do
  runtime_version "4.0"
  pipeline_mode :Integrated
  action [:add,:start]
end

iis_site 'TC-web' do
  protocol :http
  port 9010
  path "#{node['iis']['docroot']}/TC-web"
  application_pool 'TC-web'
  action [:add,:start]
end

template "#{node['iis']['docroot']}/TC-web/Default.htm" do
  source 'default.htm.erb'
end
