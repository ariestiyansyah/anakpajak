class Rule < ActiveRecord::Base
  belongs_to :user
  
  def self.import(file)
    doc       = Docx::Document.open(file.path)
    result    = doc.paragraphs.map do |p|
      p.to_html
    end
    rule = Rule.new
    rule.content = result.join("")
    rule.save
  end
  
end
