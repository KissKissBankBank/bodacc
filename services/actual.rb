class Actual
  # rubocop:disable Metrics/AbcSize
  def self.scrape(years)
    # Url
    url = "https://echanges.dila.gouv.fr/OPENDATA/BODACC/#{Time.now.year}/"

    # Opening last_update file
    last_update = find_last_update?(years)

    # Nokogiri for xml scraping, Mechanize for file download
    page = Nokogiri::HTML(open(url))

    # Download every new file
    puts 'Downloading and decompresing files...'.light_blue
    page.search('//tr').each do |line|
      next if line.search('td/text()')[4].to_s.blank?
      date = line.search('td/text()')[4].to_s.strip.to_datetime
      file = line.search('td > a/text()').to_s.strip

      # Init path depending on the file
      path = get_path(file)
      next if path.nil?

      # Downloading them if not already
      if (date.strftime("%Y-%m-%d") > last_update) or
           (last_update == Time.now)
          Downloader.execute(url + file, file, path)

          # Untar every files and remove all .taz file
          system("tar -xf #{path} -C #{path.gsub(file, '')}")
          FileUtils.rm(path)
      end

    end
    # rubocop:enable Metrics/AbcSize
  end

  def self.find_last_update?(years)
    last_modification = Modification.last
    if last_modification.nil?
      return Time.now
    else
      return last_modification.parution_at.to_datetime.strftime("%Y-%m-%d")
    end
  end

  # Return the correct path depending on the file type
  # (ex: BILAN_BXC20080050.xml go to "tmp/xml/BILAN/BILAN_BXC20080050.xml")
  def self.get_path(file)
    if file.to_s.include? 'BILAN'
      'tmp/xml/BILAN/' + file
    elsif file.to_s.include? 'RCS-A'
      'tmp/xml/RCS-A/' + file
    elsif file.to_s.include? 'RCS-B'
      'tmp/xml/RCS-B/' + file
    elsif file.to_s.include? 'PCL'
      'tmp/xml/PCL/' + file
    end
  end
end
