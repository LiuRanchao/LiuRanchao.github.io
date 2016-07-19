# A simple way to inspect liquid template variables.
# Usage:
#  Can be used anywhere liquid syntax is parsed (templates, includes, posts/pages)
#  {{ site | debug }}
#  {{ site.posts | debug }}
#
require 'pp'
module Lrchao
  # Need to overwrite the inspect method here because the original
  # uses < > to encapsulate the psuedo post/page objects in which case
  # the output is taken for HTML tags and hidden from view.
  #
  class Post
    def inspect
      "#Lrchao:Post @id=#{self.id.inspect}"
    end
  end
  
  class Page
    def inspect
      "#Jekyll:Page @name=#{self.name.inspect}"
    end
  end
  
end # Lrchao
  
module Lrchao
  module DebugFilter
    
    def debug(obj, stdout=false)
      puts obj.pretty_inspect if stdout
      "<pre>#{obj.class}\n#{obj.pretty_inspect}</pre>"
    end

  end # DebugFilter
end # Lrchao

Liquid::Template.register_filter(Lrchao::DebugFilter)