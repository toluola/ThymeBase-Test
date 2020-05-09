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

  
  # def generate_colour
  #   '#' + "%06x" % (rand * 0xffffff)
  # end

  # def create_span
  #   highlights.each { |p|
  #     @span_array = []
  #     highlighted_word = content.split(" ")[p[:start]..p[:end]].to_a.join(' ')
  #     span = "<span style=\"background:#{generate_colour};\" class=\"highlight\" comment=\"#{p[:comment]}\">#{highlighted_word}</span>"
  #     @span_array.push({words: highlighted_word, span: span})
  #   }
  # end

  # def insert_span
  #   @span_array.each { |p|
  #     content[p[:words]] = p[:span]
  #   }
  # end

  # def content_split
  #   split_content = content.split("\n\n")
  #   res = split_content.each { |p|
  #     "<p>#{p}<p>"
  #   }
  # end

  def create_highlight
    span_array = []
    highlights.each { |p|
    colour = '#' + "%06x" % (rand * 0xffffff)
    highlighted_word = content.split(/ /)[p[:start]..p[:end]].to_a.join(' ')
    if highlighted_word.include? "\n\n"
      new_line = highlighted_word.split("\n\n")
      new_line.each { |s|
      new_span = "<span style=\"background:#{colour};\" class=\"highlight\" comment=\"#{p[:comment]}\">#{s}</span>" 
      span_array.push({words: s, span: new_span})
      }
    else 
      span = "<span style=\"background:#{colour};\" class=\"highlight\" comment=\"#{p[:comment]}\">#{highlighted_word}</span>"
      span_array.push({words: highlighted_word, span: span}) 
    end
    }
    span_array.each { |p|
      content[p[:words]] = p[:span]
    }
  
    c = content.split("\n\n")

    c.each { |p| content[p] = "<p>#{p}</p>"}

    content.split("\n\n").join(' ')
    # debugger
  end
end