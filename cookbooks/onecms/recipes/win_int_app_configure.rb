# Cookbook:: onecms
# Recipe:: win_int_app_svr_configure
#
# Copyright:: 2018, Charles Harvey, All Rights Reserved.

windows_feature_powershell ['NET-Framework-45-ASPNET', 'NET-Framework-45-Core', 'NET-Framework-45-Features', 'NET-Framework-Features', 'NET-WCF-Services45', 'NET-WCF-TCP-PortSharing45', 'Web-App-Dev', 'Web-Asp-Net', 'Web-Asp-Net45', 'Web-Common-Http', 'Web-Default-Doc', 'Web-Dir-Browsing', 'Web-Filtering', 'Web-Health', 'Web-Http-Errors', 'Web-Http-Logging', 'Web-ISAPI-Ext', 'Web-ISAPI-Filter', 'Web-Mgmt-Console', 'Web-Mgmt-Tools', 'Web-Net-Ext', 'Web-Net-Ext45', 'Web-Performance', 'Web-Security', 'Web-Server', 'Web-Stat-Compression', 'Web-Static-Content', 'Web-WebServer'] do
  action :install
end

windows_service 'W3SVC' do
  action :enable
end

chocolatey_package 'vcredist-all' do
  action :install
end

chocolatey_package 'logparser' do
  action :install
end

# stop and delete the default site
iis_site 'Default Web Site' do
  action [:stop, :delete]
end

directory "#{node['iis']['docroot']}/onecms-CSS-App" do
  action :create
end

iis_pool 'onecms-CSS-App' do
  runtime_version "4.0"
  pipeline_mode :Integrated
  action :add
end

iis_site 'onecms-CSS-App' do
  protocol :http
  port 9525
  path "#{node['iis']['docroot']}/onecms-CSS-App"
  application_pool 'onecms-CSS-App'
  action [:add,:start]
end

template "#{node['iis']['docroot']}/onecms-CSS-App/Default.htm" do
  source 'default.htm.erb'
end

directory "#{node['iis']['docroot']}/onecms-CSS-Report" do
  action :create
end

iis_pool 'onecms-CSS-Report' do
  runtime_version "4.0"
  pipeline_mode :Integrated
  action :add
end

iis_site 'onecms-CSS-Report' do
  protocol :http
  port 9625
  path "#{node['iis']['docroot']}/onecms-CSS-Report"
  application_pool 'onecms-CSS-Report'
  action [:add,:start]
end

template "#{node['iis']['docroot']}/onecms-CSS-Report/Default.htm" do
  source 'default.htm.erb'
end

directory "#{node['iis']['docroot']}/onecms-CSS-restapp" do
  action :create
end

iis_pool 'onecms-CSS-restapp' do
  runtime_version "4.0"
  pipeline_mode :Integrated
  action :add
end

iis_site 'onecms-CSS-restapp' do
  protocol :http
  port 9575
  path "#{node['iis']['docroot']}/onecms-CSS-restapp"
  application_pool 'onecms-CSS-restapp'
  action [:add,:start]
end

template "#{node['iis']['docroot']}/onecms-CSS-restapp/Default.htm" do
  source 'default.htm.erb'
end

directory "#{node['iis']['docroot']}/onecms-App" do
  action :create
end

iis_pool 'onecms-App' do
  runtime_version "4.0"
  pipeline_mode :Integrated
  action :add
end

iis_site 'onecms-App' do
  protocol :http
  port 9500
  path "#{node['iis']['docroot']}/onecms-App"
  application_pool 'onecms-App'
  action [:add,:start]
end

template "#{node['iis']['docroot']}/onecms-App/Default.htm" do
  source 'default.htm.erb'
end

directory "#{node['iis']['docroot']}/onecms-AppExt" do
  action :create
end

iis_pool 'onecms-AppExt' do
  runtime_version "4.0"
  pipeline_mode :Integrated
  action :add
end

iis_site 'onecms-AppExt' do
  protocol :http
  port 9650
  path "#{node['iis']['docroot']}/onecms-AppExt"
  application_pool 'onecms-AppExt'
  action [:add,:start]
end

template "#{node['iis']['docroot']}/onecms-AppExt/Default.htm" do
  source 'default.htm.erb'
end

directory "#{node['iis']['docroot']}/onecms-AppExt" do
  action :create
end

iis_pool 'onecms-AppExt' do
  runtime_version "4.0"
  pipeline_mode :Integrated
  action :add
end

iis_site 'onecms-AppExt' do
  protocol :http
  port 9650
  path "#{node['iis']['docroot']}/onecms-AppExt"
  application_pool 'onecms-AppExt'
  action [:add,:start]
end

template "#{node['iis']['docroot']}/onecms-AppExt/Default.htm" do
  source 'default.htm.erb'
end

directory "#{node['iis']['docroot']}/onecms-report" do
  action :create
end

iis_pool 'onecms-report' do
  runtime_version "4.0"
  pipeline_mode :Integrated
  action :add
end

iis_site 'onecms-report' do
  protocol :http
  port 9600
  path "#{node['iis']['docroot']}/onecms-report"
  application_pool 'onecms-report'
  action [:add,:start]
end

template "#{node['iis']['docroot']}/onecms-report/Default.htm" do
  source 'default.htm.erb'
end

directory "#{node['iis']['docroot']}/onecms-restapp" do
  action :create
end

iis_pool 'onecms-restapp' do
  runtime_version "4.0"
  pipeline_mode :Integrated
  action :add
end

iis_site 'onecms-restapp' do
  protocol :http
  port 9550
  path "#{node['iis']['docroot']}/onecms-restapp"
  application_pool 'onecms-restapp'
  action [:add,:start]
end

template "#{node['iis']['docroot']}/onecms-restapp/Default.htm" do
  source 'default.htm.erb'
end