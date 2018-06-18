# Recipe:: featureInternalAppServer
#
# Copyright:: 2018, Charles Harvey, All Rights Reserved.

include_recipe 'chocolatey::default'

windows_feature_powershell ['NET-Framework-45-ASPNET', 'NET-Framework-45-Core', 'NET-Framework-45-Features', 'NET-Framework-Features', 'NET-HTTP-Activation', 'NET-Non-HTTP-Activ', 'NET-WCF-HTTP-Activation45', 'NET-WCF-Services45', 'NET-WCF-TCP-Activation45', 'NET-WCF-TCP-PortSharing45', 'WAS', 'WAS-Config-APIs', 'WAS-NET-Environment', 'WAS-Process-Model', 'Web-App-Dev', 'Web-AppInit', 'Web-ASP', 'Web-Asp-Net', 'Web-Asp-Net45', 'Web-Common-Http', 'Web-Default-Doc', 'Web-Dir-Browsing', 'Web-Filtering', 'Web-Health', 'Web-Http-Errors', 'Web-Http-Logging', 'Web-ISAPI-Ext', 'Web-ISAPI-Filter', 'Web-Metabase', 'Web-Mgmt-Tools', 'Web-Net-Ext', 'Web-Net-Ext45', 'Web-Performance', 'Web-Security', 'Web-Server', 'Web-Stat-Compression', 'Web-Static-Content', 'Web-WebServer', 'Web-Windows-Auth'] do
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

directory "#{node['iis']['docroot']}/CDN-web" do
  action :create
end

iis_pool 'CDN-Web' do
  runtime_version '4.0'
  pipeline_mode :Integrated
  action [:add, :start]
end

iis_site 'CDN-web' do
  protocol :http
  port 9050
  path "#{node['iis']['docroot']}/CDN-web"
  application_pool 'CDN-Web'
  action [:add, :start]
end

template "#{node['iis']['docroot']}/CDN-web/Default.htm" do
  source 'default.htm.erb'
end

iis_pool 'fcil-web' do
  runtime_version '4.0'
  pipeline_mode :Integrated
  action [:add, :start]
end

directory "#{node['iis']['docroot']}/fcil-web" do
  action :create
end

iis_site 'fcil-web' do
  protocol :http
  port 9130
  path "#{node['iis']['docroot']}/fcil-web"
  application_pool 'fcil-web'
  action [:add, :start]
end

template "#{node['iis']['docroot']}/fcil-web/Default.htm" do
  source 'default.htm.erb'
end

iis_pool 'ParentPortal-web' do
  runtime_version '4.0'
  pipeline_mode :Integrated
  action [:add, :start]
end

directory "#{node['iis']['docroot']}/parentportal-web" do
  action :create
end

iis_site 'ParentPortal-Pro' do
  protocol :http
  port 9030
  path "#{node['iis']['docroot']}/parentportal-web"
  application_pool 'ParentPortal-web'
  action [:add, :start]
end

template "#{node['iis']['docroot']}/ParentPortal-web/Default.htm" do
  source 'default.htm.erb'
end

windows_firewall_rule 'IIS-OneCMS-CDN-web-In-TCP' do
  rule_name 'IIS-OneCMS-CDN-web-In-TCP'
  description 'Allow OneCMS CDN-web'
  localport '9050'
  protocol 'TCP'
  firewall_action :allow
  profile :any
end

windows_firewall_rule 'IIS-OneCMS-fcil-web-In-TCP' do
  rule_name 'IIS-OneCMS-fcil-web-In-TCP'
  description 'Allow OneCMS fcil-web'
  localport '9130'
  protocol 'TCP'
  firewall_action :allow
  profile :any
end

windows_firewall_rule 'IIS-OneCMS-ParentPortal-Pro-In-TCP' do
  rule_name 'IIS-OneCMS-ParentPortal-Pro-In-TCP'
  description 'Allow OneCMS Parent Portal Pro'
  localport '9030'
  protocol 'TCP'
  firewall_action :allow
  profile :any
end
