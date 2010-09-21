# To hide Rack::Test warning
#
# Reference: http://crimpycode.brennonbortz.com/?p=42
#
module Rack
  module Utils
    def escape(s)
      EscapeUtils.escape_url(s)
    end
  end
end
