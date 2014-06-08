class ConvertInputFileToJSON
  def self.call(path)

    lines = []
    File.open(path, 'r').each do |line|
      lines << ParseLineIntoHash.call(line)
    end

    lines.to_json
  end
end
