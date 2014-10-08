StudioLookup.new(:id => 1, :facility_name => "Richmond", :studio_name => "Monk", :mdns_localname => "monk-rpc.local", :ip_fallback => "192.168.0.161", :phone => "0205", :active => true).save()
StudioLookup.new(:id => 2, :facility_name => "Richmond", :studio_name => "Mingus", :mdns_localname => "mingus-rpc.local", :ip_fallback => "192.168.0.160", :phone => "02032741099", :active => true).save()
StudioLookup.new(:id => 3, :facility_name => "Central London", :studio_name => "Charlie Parker", :mdns_localname => "cp-rpc.local", :ip_fallback => "192.168.0.1", :phone => "0208955", :active => false).save()

FormatLookup.new(id: 1, name: 'MP3', extension: 'MP3').save
FormatLookup.new(id: 2, name: 'MP4', extension: 'MP4').save
FormatLookup.new(id: 3, name: 'MPG', extension: 'MPG').save

Admin.new(:email => 'leej@sowhatresearch.com', :password => 'plutonia', :password_confirmation => 'plutonia').save()
Admin.new(:email => 'baz@sowhatresearch.com', :password => 'plutonia', :password_confirmation => 'plutonia').save()
Admin.new(:email => 'ruth@sowhatresearch.com', :password => 'plutonia', :password_confirmation => 'plutonia').save()
Admin.new(:email => 'info@sowhatresearch.com', :password => 'plutonia', :password_confirmation => 'plutonia').save()
