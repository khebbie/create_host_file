require 'rest-client'

response = RestClient.get 'https://disconnect.me/services-plaintext.json'
body = response.to_str
json =JSON.parse body
hostfile = <<-ownhosts
##
# Host Database
#
# localhost is used to configure the loopback interface
# when the system is booting.  Do not change this entry.
##
127.0.0.1	localhost
255.255.255.255	broadcasthost
::1             localhost 

# my own hosts
127.0.0.1 media-match.com
127.0.0.1 adclick.g.doublecklick.net
127.0.0.1 www.googleadservices.com
127.0.0.1 open.spotify.com
127.0.0.1 pagead2.googlesyndication.com
127.0.0.1 desktop.spotify.com
127.0.0.1 googleads.g.doubleclick.net
127.0.0.1 pubads.g.doubleclick.net
127.0.0.1 audio2.spotify.com

127.0.0.1 www.omaze.com
127.0.0.1 omaze.com
127.0.0.1 bounceexchange.com
# hosts from disconnect
ownhosts
json["categories"]["Advertising"].each do | advertising |
  advertising.values[0].values[0].each do |site|
    hostfile += "127.0.0.1 #{site}\n"
  end
end
f = File.new("host", "w")
f.write(hostfile)
p hostfile
