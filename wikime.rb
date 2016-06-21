class ParseWiki
  require 'nokogiri'
  require 'open-uri'

  def initialize(url)
    @url = url
  end

  def parse_this
    Nokogiri::HTML(open(@url))
  end

  def body
    parse_this.css('div#content')
  end

  def write_html
    write_me = File.open("wikime.html", 'w+') 
    write_me << "<!DOCTYPE html>"
    write_me << "<meta charset='UTF-8'>"
    write_me << '<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">'
    write_me << '<link href="featherlight/src/featherlight.css" type="text/css" rel="stylesheet" />'
    write_me << '<link href="https://fonts.googleapis.com/css?family=Open+Sans:400,400italic,600,600italic" rel="stylesheet" type="text/css">'
    write_me << '<link rel="stylesheet" href="ExpandingSearchBar/css/component.css">'
    write_me << "<link rel='stylesheet' href='wikime.css'>"
    write_me << '<header class="nav-down">
                  <div id="sb-search" class="sb-search">
                  <form>
                    <input class="sb-search-input" placeholder="Search Wikipedia..." type="search" name="search" id="search">
                    <input class="sb-search-submit" type="submit" value="">
                    <span class="sb-icon-search" id="hit"></span>
                  </form>
                </div>
                <a href="#toc" id="hamburger" class="menu-link">&#9776;</a>
                </header>'
    write_me << body
    write_me << '<script src="https://code.jquery.com/jquery-2.2.4.min.js"   integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="   crossorigin="anonymous"></script>'
    write_me << '<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"   integrity="sha256-xNjb53/rY+WmG+4L6tTl9m6PpqknWZvRt0rO1SRnJzw="   crossorigin="anonymous"></script>'
    write_me << '<script src="featherlight/src/featherlight.js"></script>'
    write_me << '<script src="ExpandingSearchBar/js/classie.js"></script>'
    write_me << '<script src="ExpandingSearchBar/js/modernizr.custom.js"></script>'
    write_me << '<script src="ExpandingSearchBar/js/uisearch.js"></script>'
    write_me << '<script src="bigSlider.js"></script>'
    write_me << '<script>
                  new UISearch( document.getElementById( "sb-search" ) );
                </script>'
    write_me << '<script src="wikime.js"></script>'
    write_me.close
  end
end

class HtmlMe
  def initialize(html_file)
    @file = html_file
  end

  def add_http
    text = File.read(@file)
    content = text.gsub("/wiki/", "https://en.wikipedia.org/wiki/")
    File.open(@file, 'w+') { |f| f << f.write(content) }
  end

  def fix_images
    text = File.read(@file)
    content = text.gsub("//upload", "https://upload")
    File.open(@file, 'w+') { |f| f << f.write(content) }
  end
end

wiki = ParseWiki.new("https://en.wikipedia.org/wiki/" + ARGV.join("_"))
wiki.write_html
html_me = HtmlMe.new("wikime.html")
html_me.add_http
html_me.fix_images
system("open", "wikime.html")