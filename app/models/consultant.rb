class Consultant < ActiveRecord::Base
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      consultant                  = Consultant.new
      consultant.title            = spreadsheet.row(i)[0]
      consultant.address          = spreadsheet.row(i)[2]
      consultant.description      = spreadsheet.row(i)[10]
      consultant.region           = spreadsheet.row(i)[7]
      consultant.latitude         = spreadsheet.row(i)[8]
      consultant.longitude        = spreadsheet.row(i)[9]
      consultant.no_registration  = spreadsheet.row(i)[1]
      consultant.no_telp          = spreadsheet.row(i)[4]
      consultant.email            = spreadsheet.row(i)[5]
      consultant.website          = spreadsheet.row(i)[3]
      consultant.city             = spreadsheet.row(i)[6]
      consultant.save
    end
  end
  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path)
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}" 
    end
  end
end
