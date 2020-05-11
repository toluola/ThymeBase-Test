class Highlight
  def initialize(content, highlights)
    @content = content
    @highlights = highlights
  end

  def call
    create_highlight
  end

  private

  attr_reader :content, :highlights

  def insert_span
    @span_array.each { |p|
      content[p[:words]] = p[:span]
    }
  end

  def content_split
    splited_content = content.split("\n\n")
    splited_content.each { |p| 
      content[p] = "<p>#{p}</p>"
    }
    content.split("\n\n").join(' ')
  end

  def genarate_id
    (0...8).map { (65 + rand(26)).chr }.join
   end

  def create_highlight
    @span_array = []
    highlights.each { |p|
    generate_colour = '#' + "%06x" % (rand * 0xffffff)
    highlighted_word = content.split(/ /)[p[:start]..p[:end]].to_a.join(' ')
    if highlighted_word.include? "\n\n"
      new_line = highlighted_word.split("\n\n")
      new_line.each { |s|
      new_span = "<span id=\"#{genarate_id}\" style=\"background:#{generate_colour};\" 
                  class=\"highlight\" comment=\"#{p[:comment]}\" 
                  onmouseover=\"createTip(this)\" onmouseout=\"cancelTip(this)\">#{s}
                  </span>" 
      @span_array.push({words: s, span: new_span})
      }
    else 
      span = "<span id=\"#{genarate_id}\" style=\"background:#{generate_colour};\" 
      class=\"highlight\" comment=\"#{p[:comment]}\"
      onmouseover=\"createTip(this)\" onmouseout=\"cancelTip(this)\">#{highlighted_word}
      </span>"
      @span_array.push({words: highlighted_word, span: span}) 
    end
    }
    insert_span
    content_split
  end
end